//
//  TSEditVideoListVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit
import SPAlertController

class TSEditVideoListVC: BaseTableViewVC {

    var editVideoListView:TSEditVideoListView!
    
    lazy var editVideoListService:TSEditVideoListService = {
        let service = TSEditVideoListService()
        return service
    }()
    lazy var editVideoListVo:TSEditVideoListVo = {
        let vo = TSEditVideoListVo()
        return vo
    }()
    
    override func initService() {
        self.editVideoListService = TSEditVideoListService()
    }
    override func initBaseVo() {
        self.editVideoListVo = TSEditVideoListVo()
    }
    override func getBaseTableViewVo() -> BaseTableViewVo {
        return self.editVideoListVo
    }
    override func getBaseTableView() -> (BaseTableView) {
        return self.editVideoListView
    }
    override func getBaseTemplateService() -> (BaseTemplateService) {
        return self.editVideoListService
    }
    lazy var voiceListService: TSVoiceListService = {
        let service = TSVoiceListService()
        return service
    }()
    override func getVCName() -> (String) {
        return "TSEditVideoListVC"
    }
    
    lazy var editVideoAlertView: TSEditVideoAlertView = {
        let alert = TSEditVideoAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 120))
        return alert
    }()
    var selectArray:NSMutableArray!
    
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        self.editVideoListView = TSEditVideoListView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseTableView: self.editVideoListView)
        let dic = Dictionary<String, Any>()
        self.editVideoListVo = self.editVideoListVo.initByDic(dic: dic)
        self.editVideoListView.reloadView(baseTableViewVo: self.editVideoListVo)
        self.editVideoListView.baseTableView.backgroundColor = CommonUtil.color(hex: bgViewColor)
        
        refreshTableView()
        
//        editVideoListView.baseTableView.isEditing = true
        
        editVideoListView.baseTableView.setEditing(true, animated: true)
        selectArray = NSMutableArray()
        self.editVideoListView.deleteBtn.addTarget(self, action: #selector(deleteAction(sender:)), for: UIControl.Event.touchUpInside)
        
        self.editVideoListView.headerView.setupBackImagename(imagename: "left")
        self.editVideoListView.headerView.backBtn.addTarget(self, action: #selector(backAction(button:)), for: UIControl.Event.touchUpInside)
        self.editVideoListView.headerView.setupTitleText(title: "History")
    }
    
    func refreshTableView() {
        let arr = voiceListService.queryAll()
        self.editVideoListVo.refreshCellVo(arr: arr)
        self.editVideoListView.reloadView(baseTableViewVo: self.editVideoListVo)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.editVideoListVo)
        var editVideoListCell:TSEditVideoListCell!
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSEditVideoListCell" {
                let cell_ID = "TSEditVideoListCell"
                tableView.register(TSEditVideoListCell.self, forCellReuseIdentifier: cell_ID)
                editVideoListCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSEditVideoListCell
                if editVideoListCell==nil {
                    editVideoListCell = TSEditVideoListCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                editVideoListCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                editVideoListCell?.contentView.backgroundColor = UIColor.white
                return editVideoListCell!
            }
        }
        return editVideoListCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.editVideoListVo)
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSEditVideoListCell" {
                return 80
            }
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let select = self.editVideoListVo.cellVoArray[indexPath.row]
            if (!self.selectArray.contains(select)) {
//                self.selectArray.append(select)
                self.selectArray.add(select)
            }
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let select = self.editVideoListVo.dataArray[indexPath.row]
          if (self.selectArray.contains(select)) {
              let index = selectArray.index(of: select)
              selectArray.removeObject(at: index)
          }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true//返回可编辑
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //这里非常关键！
        return UITableViewCell.EditingStyle(rawValue: UITableViewCell.EditingStyle.delete.rawValue | UITableViewCell.EditingStyle.insert.rawValue)!
    }
    
    @objc func deleteAction(sender:UIButton) {
        //如果selectArray.count，则选择数量大于0，有选cell
        if selectArray.count > 0 {
            popDeleteAlertView()
        }else{
            SVProgressHUD.showError(withStatus: "Select item please.")
        }
  
    }
    
    
    //删除文件夹
    private func deleteFolderItems(basePath:String, exceptFolderName:String, callBack: @escaping (Bool) -> Void) {
        
        let fileManager = FileManager.default
        let queue = DispatchQueue(label: "clearnQueue", attributes: [])
        queue.async { () -> Void in
            guard let childFiles = fileManager.subpaths(atPath: basePath) else{
                callBack(true)
                return
            }
            for fileName in childFiles {
                if exceptFolderName != "" {
                    let folderName = fileName.components(separatedBy: "/").first
                    if folderName == exceptFolderName{
                        continue
                    }
                }
                let path = basePath as NSString
                let fileFullPath = path.appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: fileFullPath) {
                    do {
                        try fileManager.removeItem(atPath: fileFullPath)
                    } catch _{}
                }
            }
            DispatchQueue.main.async(execute: {
                callBack(true)
            })
        }
    }

    @objc func backAction(button:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popDeleteAlertView()  {
        let alertView = SPAlertController.init(customHeaderView: self.editVideoAlertView, preferredStyle: SPAlertControllerStyle.alert, animationType: SPAlertAnimationType.shrink)
        alertView.setBackgroundViewAppearanceStyle(UIBlurEffect.Style.dark, alpha: 0.6)
        alertView.tapBackgroundViewDismiss = false
        self.editVideoAlertView.cancelBlock = {(dic:Dictionary<String, Any>) in
            alertView.dismiss(animated: true) {

            }
            
        };
        self.editVideoAlertView.comfirmlock = {(dic:Dictionary<String, Any>) in
            alertView.dismiss(animated: true) {
                self.deleteRecord()
            }
        }
        self.present(alertView, animated: true) {
            
        }
    }
    
    
    func deleteRecord() {
        if selectArray.count > 0 {
            
            for (index,obj) in selectArray.enumerated(){
                
                var vo = obj as! BaseTableCellVo
                var daoId = vo.dbDic["daoId"];
                var title = vo.dbDic["title"];
                var date = vo.dbDic["date"];
                var location = vo.dbDic["location"];
                var duration = vo.dbDic["duration"];
                var path = vo.dbDic["path"];
                
                
                var dic = Dictionary<String,Any>()
                dic["daoId"] = daoId
                dic["title"] = title
                dic["date"] = date
                dic["location"] = location
                dic["duration"] = duration
                dic["path"] = path
                
                voiceListService.deleteItemBy(dic: dic)
                
            }
            refreshTableView()
        }
        else {
            SVProgressHUD.showError(withStatus: "Select item please.")
        }
    }
}
