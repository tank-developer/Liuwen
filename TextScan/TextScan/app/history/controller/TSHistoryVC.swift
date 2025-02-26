//
//  TSHistoryVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit
import MJRefresh

class TSHistoryVC: BaseTableViewVC {

    var historyView:TSHistoryView!
    
    var editImgVo:TSEditImgVo!

    lazy var historyService:TSHistoryService = {
        let service = TSHistoryService()
        return service
    }()
    lazy var historyVo:TSHistoryVo = {
        let vo = TSHistoryVo()
        return vo
    }()
    
    override func initService() {
        self.historyService = TSHistoryService()
    }
    override func initBaseVo() {
        self.historyVo = TSHistoryVo()
        self.editImgVo = TSEditImgVo()
    }
    override func getBaseTableViewVo() -> BaseTableViewVo {
        return self.historyVo
    }
    override func getBaseTableView() -> (BaseTableView) {
        return self.historyView
    }
    override func getBaseTemplateService() -> (BaseTemplateService) {
        return self.historyService
    }
    override func getVCName() -> (String) {
        return "TSHistoryVC"
    }
    
    var editImgService:TSEditImgService!
    
    override func initBaseView() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.historyView = TSHistoryView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseTableView: self.historyView)
        let dic = Dictionary<String, Any>()
        self.historyVo = self.historyVo.initByDic(dic: dic)
        self.historyView.reloadView(baseTableViewVo: self.historyVo)
        self.historyView.baseTableView.backgroundColor = CommonUtil.color(hex: bgViewColor)
        
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        self.historyView.baseTableView.mj_header = header
        self.historyView.baseTableView.mj_header?.beginRefreshing()
        
        self.historyView.headerView.setupBackHide(hide: false)
        self.historyView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        self.historyView.headerView.setupTitleText(title: "History")
        self.editImgService = TSEditImgService()
        
    }
    @objc func loadMoreData(){
        let imgArray = self.editImgVo.queryFromDB()
        self.historyVo.refreshCellvo(imgArr: imgArray)
        self.historyView.reloadView(baseTableViewVo: self.historyVo)
        self.historyView.baseTableView.mj_header?.endRefreshing()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.historyVo)
        var historyCell:TSHistoryCell!
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSHistoryCell" {
                let cell_ID = "TSHistoryCell"
                tableView.register(TSHistoryCell.self, forCellReuseIdentifier: cell_ID)
                historyCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSHistoryCell
                if historyCell==nil {
                    historyCell = TSHistoryCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                historyCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                historyCell?.contentView.backgroundColor = UIColor.white
                return historyCell!
            }
        }
        return historyCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.historyVo)
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSHistoryCell" {
                return 80
            }
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.historyVo)
        let title = baseTableCellVo.cellDataDic["lbl2"] as! String
        var dic = Dictionary<String,String>()
        dic["title"] = title
        let vc = TSTextDetailVC()
        vc.textDic = dic
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func removeCellFromTableView(tableview: UITableView, toBeRemoveVo: BaseTableCellVo, cellIndexPath: IndexPath) {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: cellIndexPath, baseTableViewVo: self.historyVo)
        var dic = Dictionary<String,String>()
        
        dic["path"] = baseTableCellVo.dbDic["path"] as? String
        dic["daoId"] = baseTableCellVo.dbDic["daoId"] as? String
        dic["title"] = baseTableCellVo.dbDic["title"] as? String
        
        deleteDoucoumtsImagesImg(imageName: baseTableCellVo.dbDic["path"] as! String)
        
        let result = editImgService.deleteEditImg(dic: dic)
        self.historyView.baseTableView.mj_header?.beginRefreshing()
        
    }
    
    func deleteDoucoumtsImagesImg(imageName:String) {
        let fileManager = FileManager.default
        let baseUrl = NSHomeDirectory().appending("/Documents/images/")
        let fullPath = baseUrl.appending(imageName)
        do {
          try fileManager.removeItem(atPath: fullPath)
        } catch let error as NSError {
          print("Error removing file: \(error)")
        }
    }
    
    @objc func backAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
