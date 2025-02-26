//
//  TSEditImgVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import Vision
import SPAlertController
import SVProgressHUD
import Photos


class TSEditImgVC: BaseTemplateVC {
    
    var resultingText = ""
    var requests = Array<VNRecognizeTextRequest>()
    
    var editImgView:TSEditImgView!
    
    var textArray:NSMutableArray!
    
    var editImgVo:TSEditImgVo!
    
    lazy var editImgAlertView: TSEditImgAlertView = {
        let calendar = TSEditImgAlertView()
        calendar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 550)
        calendar.backgroundColor = UIColor.white
        return calendar
    }()
    lazy var editImgLanguageAlertView: TSEditImgLanguageAlertView = {
        let calendar = TSEditImgLanguageAlertView()
        calendar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 550)
        calendar.backgroundColor = UIColor.white
        
        return calendar
    }()
    
    var selectDic:Dictionary<String,String>!
    var selectorImage:UIImage!
    lazy var cleanView: UIView = {
        guard let imageSize = selectorImage?.scaleImage() else { return UIView() }
        let cleanVIew = UIView()
        cleanVIew.backgroundColor = UIColor.clear
        return cleanVIew
    }()
    
    var mbp:MBProgressHUD!
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        
        self.editImgView = TSEditImgView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseView: self.editImgView)
        self.editImgVo = TSEditImgVo()
        
        self.editImgView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        
        self.editImgView.bgImg.image = selectorImage
        self.editImgView.scanBtn.addTarget(self, action: #selector(getText(sender:)), for: UIControl.Event.touchUpInside)
        
        textArray = NSMutableArray()
        self.editImgView.headerView.setupBackImagename(imagename: "left")
        self.editImgView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        self.editImgView.headerView.setupTitleText(title: "Scan")
        self.editImgView.headerView.setupRightImg(img: "exchange")

        
        self.editImgView.headerView.rightBtn.addTarget(self, action: #selector(selectLanguage(sender:)), for: UIControl.Event.touchUpInside)
        selectDic = Dictionary<String,String>()
        selectDic["lan"] = "Chinese"
        selectDic["code"] = "zh-Hans"
        self.editImgView.headerView.setupTitleText(title: self.selectDic["lan"] ?? "Chinese")
        


    }
    
    func getBaseTableView() -> (BaseView) {
        return self.editImgView
    }
    
    override func getVCName() -> (String) {
        return "TSEditImgVC"
    }
    
    func popPrivateAlertView() {
        let alertView = SPAlertController.init(customHeaderView: self.editImgAlertView, preferredStyle: SPAlertControllerStyle.actionSheet, animationType: SPAlertAnimationType.fromBottom)
        alertView.setBackgroundViewAppearanceStyle(UIBlurEffect.Style.dark, alpha: 0.6)
        alertView.tapBackgroundViewDismiss = false
        self.editImgAlertView.cancelBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                self.editImgAlertView.refreshTextView(text: "")
            }
        };
        self.editImgAlertView.comfirmBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                UIPasteboard.general.string = String(format: dic["title"] as! String)
                SVProgressHUD.showSuccess(withStatus: "拷贝成功")
                
            }
        }
        self.editImgAlertView.checkBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                let vc = TSCheckTextVC()
                vc.hidesBottomBarWhenPushed = true
                var dic1 = Dictionary<String,String>()
                dic1["title"] = String(format: dic["title"] as! String)
                vc.textDic = dic1
                vc.selectorImage = self.selectorImage
                self.navigationController?.pushViewController(vc, animated: true)
            }
        };
        self.present(alertView, animated: true) {
            self.startObs()
        }
    }
    
    @objc func getText(sender:UIButton) {
        self.popPrivateAlertView()
    }
    
    func startObs() {
        do{
            let supportLanguageArray = try VNRecognizeTextRequest.supportedRecognitionLanguages(for: .accurate, revision: VNRecognizeTextRequestRevision1)
              print(supportLanguageArray)
        }catch{
            
        }
        
        self.textArray.removeAllObjects()
        let textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            // 把识别的文字全部连成一个string
            let maximumCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                self.resultingText += candidate.string + "\n"
                self.textArray.add(self.resultingText)
//                print(self.textArray.count)
                // 判断当前线程是否是主线程
                 if Thread.current.isMainThread {
                     if observations.count == self.textArray.count{
                         // UI 事件
                         var string = self.textArray.lastObject as! String
                         self.editImgAlertView.refreshTextView(text: string)
                         self.saveTitleToDB(title: string)
                     }
                 } else {
                     // 切换到 main 线程，处理
                     DispatchQueue.main.async {
                         if observations.count == self.textArray.count{
                             var string = self.textArray.lastObject as! String
                             self.editImgAlertView.refreshTextView(text: string)
                             self.saveTitleToDB(title: string)
                         }
                         // 结束事件，防止造成递归循环
                         return
                     }
                 }
            }
        }
        let code = self.selectDic["code"]!
        textRecognitionRequest.recognitionLanguages = [code]
        textRecognitionRequest.recognitionLevel = .accurate
        if #available(iOS 16.0, *) {
            textRecognitionRequest.revision = VNRecognizeTextRequestRevision3
        } else {
            if #available(iOS 14.0, *) {
                textRecognitionRequest.revision = VNRecognizeTextRequestRevision2
            }else{
                textRecognitionRequest.revision = VNRecognizeTextRequestRevision1
            }
        }
        let requests = [textRecognitionRequest]
        let image = selectorImage
        if let cgImage = image?.cgImage {
             let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
             do {
                 try requestHandler.perform(requests)
             } catch {
                 print(error)
             }
        }
    }
    
    @objc func backAction(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //保存图片至沙盒
    private func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
            
            let manager = FileManager.default
            let baseUrl = NSHomeDirectory().appending("/Documents/images/")
            let exist = manager.fileExists(atPath: baseUrl)
            //如果文件夹不存在，则执行之后的代码
           if !exist{
               do{
            //创建指定位置上的文件夹
                   try manager.createDirectory(atPath: baseUrl, withIntermediateDirectories: true, attributes: nil)
                   print("Succes to create folder")
               }
               catch{
                   print("Error to create folder")
               }
            }
            
            let fullPath = baseUrl.appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
    }
    
    func queryImage(fullPath:String) {
        if let savedImage = UIImage(contentsOfFile: fullPath) {
            //self.imageView.image = savedImage
        } else {
            print("文件不存在")
        }
    }
    
    
    func saveTitleToDB(title:String) {
        let filename = CommonUtil.getIdentifier()
        let filenameNum = filename as NSNumber
        let filenameString : String = filenameNum.stringValue
        
        self.saveImage(currentImage: self.selectorImage, persent: 0.8, imageName: filenameString + ".png")
        var dic1 = Dictionary<String,String>()
        dic1["title"] = title
        dic1["path"] = filenameString + ".png"
        dic1["location"] = "location"
        dic1["date"] = "date"
        self.editImgVo.insertDB(Dic: dic1, daoId: filename)
    }
    
    
    @objc func selectLanguage(sender:UIButton) {
        let alertView = SPAlertController.init(customHeaderView: self.editImgLanguageAlertView, preferredStyle: SPAlertControllerStyle.actionSheet, animationType: SPAlertAnimationType.fromBottom)
        alertView.setBackgroundViewAppearanceStyle(UIBlurEffect.Style.dark, alpha: 0.6)
        alertView.tapBackgroundViewDismiss = false
        self.editImgLanguageAlertView.cancelBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                
            }
        };
        self.editImgLanguageAlertView.comfirmBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                let dict = Dictionary<String,String>()
                
                self.selectDic["code"] = dic["code"] as! String
                self.selectDic["lan"] = dic["lan"] as! String
                self.editImgView.headerView.setupTitleText(title: self.selectDic["lan"] ?? "Chinese")

            }
        }
        self.present(alertView, animated: true)
    }
}
