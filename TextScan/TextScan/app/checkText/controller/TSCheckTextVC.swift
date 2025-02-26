//
//  TSCheckTextVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSCheckTextVC: BaseTemplateVC {

    lazy var checkTextVo: TSCheckTextVo = {
        let vo = TSCheckTextVo()
        return vo
    }()
    
    var editImgVo:TSEditImgVo!
    
    var checkTextView:TSCheckTextView!
    
    var textDic:Dictionary<String,String>!
    var selectorImage:UIImage!
    
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        self.checkTextView = TSCheckTextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseView: self.checkTextView)
        self.checkTextView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        self.checkTextView.headerView.setupBackImagename(imagename: "left")
        self.checkTextView.headerView.setupTitleText(title: "Scan")
        self.checkTextView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        self.checkTextView.textview.text = textDic["title"]
        self.checkTextView.headerView.setupOutputBtnImg(img: "copy")
        self.checkTextView.headerView.setupRightImg(img: "inspection")
        self.checkTextView.headerView.outputBtn.addTarget(self, action: #selector(outputAction(sender:)), for: UIControl.Event.touchUpInside)
        self.checkTextView.headerView.rightBtn.addTarget(self, action: #selector(checkAction(sender:)), for: UIControl.Event.touchUpInside)
        
        self.checkTextView.bottomView.bImage.image = selectorImage
        self.checkTextView.downBottomView()
        self.checkTextView.bottomView.cancelBtn.addTarget(self, action: #selector(cancelAction(button:)), for: UIControl.Event.touchUpInside)
    }
    
    func getBaseTableView() -> (BaseView) {
        return self.checkTextView
    }
    
    override func getVCName() -> (String) {
        return "TSCheckTextVC"
    }
    
    @objc func backAction(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func checkAction(sender:UIButton){
        UIView.animate(withDuration: 0.2) {
            self.checkTextView.upBottomView()
        }
    }
    @objc func outputAction(sender:UIButton){
        /// 整个窗口截屏
//        let image = UIApplication.shared.keyWindow!.asImage()
        /// 将转换后的UIImage保存到相机胶卷中
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        /// 某一个单独View截图
//        let image = self.imageBgView.asImage()
        
        UIPasteboard.general.string = self.checkTextView.textview.text
        SVProgressHUD.showSuccess(withStatus: "Successfully copied")
    }
    
    @objc func cancelAction(button:UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.checkTextView.downBottomView()
        }
    }
    
}

extension UIView {
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

