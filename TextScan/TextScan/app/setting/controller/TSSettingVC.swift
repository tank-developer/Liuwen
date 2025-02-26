//
//  TSSettingVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import SPAlertController

class TSSettingVC: BaseTableViewVC {
    
    var settingView:TSSettingView!
    
    lazy var settingService:TSSettingService = {
        let service = TSSettingService()
        return service
    }()
    lazy var settingVo:TSSettingVo = {
        let vo = TSSettingVo()
        return vo
    }()
    override func initService() {
        self.settingService = TSSettingService()
    }
    override func initBaseVo() {
        self.settingVo = TSSettingVo()
    }
    override func getBaseTableViewVo() -> BaseTableViewVo {
        return self.settingVo
    }
    override func getBaseTableView() -> (BaseTableView) {
        return self.settingView
    }
    override func getBaseTemplateService() -> (BaseTemplateService) {
        return self.settingService
    }
    override func getVCName() -> (String) {
        return "TSSettingVC"
    }
    lazy var settingShareView: TSSettingShareView = {
        let vie = TSSettingShareView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 500))
        return vie
    }()
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        self.settingView = TSSettingView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseTableView: self.settingView)
        let dic = Dictionary<String, Any>()
        self.settingVo = self.settingVo.initByDic(dic: dic)
        self.settingView.reloadView(baseTableViewVo: self.settingVo)
        self.settingView.baseTableView.backgroundColor = CommonUtil.color(hex: bgViewColor)
        self.settingView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        self.settingView.headerView.setupBackImagename(imagename: "left")
        self.settingView.headerView.setupTitleText(title: "Setup")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.settingVo)
        var settingCell:TSSettingCell!
        var settingVersionCell:TSSettingVersionCell!
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSSettingCell" {
                let cell_ID = "TSSettingCell"
                tableView.register(TSSettingCell.self, forCellReuseIdentifier: cell_ID)
                settingCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSSettingCell
                if settingCell==nil {
                    settingCell = TSSettingCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                settingCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                settingCell?.contentView.backgroundColor = UIColor.white
                return settingCell!
            }else if baseTableCellVo.cellName == "TSSettingVersionCell" {
                let cell_ID = "TSSettingVersionCell"
                tableView.register(TSSettingVersionCell.self, forCellReuseIdentifier: cell_ID)
                settingVersionCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSSettingVersionCell
                if settingVersionCell==nil {
                    settingVersionCell = TSSettingVersionCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                settingVersionCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                settingVersionCell?.contentView.backgroundColor = UIColor.white
                return settingVersionCell!
            }else if baseTableCellVo.cellName == "TSSettingAppsCell" {
                let cell_ID = "TSSettingAppsCell"
                tableView.register(TSSettingCell.self, forCellReuseIdentifier: cell_ID)
                settingCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSSettingCell
                if settingCell==nil {
                    settingCell = TSSettingCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                settingCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                settingCell?.contentView.backgroundColor = UIColor.white
                return settingCell!
            }
        }
        return settingCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.settingVo)
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSSettingCell" || baseTableCellVo.cellName == "TSSettingVersionCell" || baseTableCellVo.cellName == "TSSettingAppsCell"{
                return 80
            }
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.settingVo)
        let title = baseTableCellVo.cellDataDic["lbl1"]
        if title as! String == "Share"{
            popShareView()
        }
        if title as! String == "More Apps"{
            popAlrtSheet()
        }
        
        if title as! String == "Privacy Policy" {
        let url = "https://docs.qq.com/doc/DYkJ1V0J2QmF5bXNZ"
            let URLs = URL.init(string: url)
            //根据iOS系统版本，分别处理
                 if  #available(iOS 10, *) {
                     UIApplication .shared.open(URLs!, options: [:],
                                               completionHandler: {
                                                 (success)  in
                     })
                 }  else  {
                     UIApplication .shared.openURL(URLs!)
                 }
            
        }
    }
    
    func popShareView() {
        let alertView = SPAlertController.init(customHeaderView: self.settingShareView, preferredStyle: SPAlertControllerStyle.actionSheet, animationType: SPAlertAnimationType.fromBottom)
        alertView.setBackgroundViewAppearanceStyle(UIBlurEffect.Style.dark, alpha: 0.6)
        alertView.tapBackgroundViewDismiss = false
        self.settingShareView.shareBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true) {
                let image = dic["img"] as! UIImage
                self.share(image: image)
            }
        }
        self.settingShareView.cancelBlock = {(dic:Dictionary<String, Any>) in
            self.dismiss(animated: true)
        }
        self.present(alertView, animated: true)
        
    }
    @objc func backAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func share(image:UIImage){
        
        DispatchQueue.main.async {
            //屏幕截图得到一个图片
            //初始化一个UIActivity
            var activity = UIActivity()
            let activities = [activity]
            
            //一个字符串
//            let shareString = "AppStore下载溜溜记账"
//            let image:UIImage = UIImage.init(named: "AppIcon")!
//            let url = NSURL.init(string: "https://apps.apple.com/cn/app/%E6%BA%9C%E6%BA%9C%E8%AE%B0%E8%B4%A6/id6468029980")
            let activityItems = [image]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
            activityController.modalPresentationStyle = .fullScreen
            activityController.completionWithItemsHandler = {
                (type, flag, array, error) -> Void in
                if flag == true {
//                    分享成功
                } else {
//                    分享失败
                }
            }
            self.present(activityController, animated: true, completion: nil)
        }
        
     
        
    }
    
    func popAlrtSheet() {
        var alertSheet = UIAlertController.init(title: "More Apps", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        var actionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            
        }
        var actionKaapa = UIAlertAction.init(title: "kaapa-Share Beautiful Words", style: UIAlertAction.Style.default) { action in
            self.click1(downloadURL: "https://apps.apple.com/cn/app/kaapa/id6502706009")
        }
        alertSheet.addAction(actionKaapa)
        alertSheet.addAction(actionCancel)
        
        self.present(alertSheet, animated: true)
        
    }
    /// 跳转
    @objc func click1(downloadURL:String) {

       let url = URL(string: downloadURL)
       // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
       if !UIApplication.shared.canOpenURL(url!) {
           // 不能跳转就不要往下执行了
           return
       }

       if #available(iOS 10.0, *) {
           UIApplication.shared.open(url!, options: [:]) { (success) in
               if (success) {
                   print("10以后可以跳转url")
               }else{
                   print("10以后不能完成跳转")
               }
           }
        } else {
           // Fallback on earlier versions
           let success = UIApplication.shared.openURL(url!)
           if (success) {
               print("10以下可以跳转")
           }else{
               print("10以下不能完成跳转")
           }
        }
    }
    
    
}
