//
//  TSVoiceListVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit
import Floaty
import SPAlertController
import MJRefresh

class TSVoiceListVC: BaseTableViewVC {
    
    var recordState = "recording"
    
    var voiceListView:TSVoiceListView!
    
    lazy var voiceListService:TSVoiceListService = {
        let service = TSVoiceListService()
        return service
    }()
    lazy var voiceListVo:TSVoiceListVo = {
        let vo = TSVoiceListVo()
        return vo
    }()
    
    override func initService() {
        self.voiceListService = TSVoiceListService()
    }
    override func initBaseVo() {
        self.voiceListVo = TSVoiceListVo()
    }
    override func getBaseTableViewVo() -> BaseTableViewVo {
        return self.voiceListVo
    }
    override func getBaseTableView() -> (BaseTableView) {
        return self.voiceListView
    }
    override func getBaseTemplateService() -> (BaseTemplateService) {
        return self.voiceListService
    }
    override func getVCName() -> (String) {
        return "TSVoiceListVC"
    }
    func initFloatyBtn() {
        var btn = UIButton()
        btn.addTarget(self, action: #selector(floatAction(sener:)), for: UIControl.Event.touchUpInside)
        btn.frame = CGRectMake(SCREEN_WIDTH - (70 + 10), SCREEN_HEIGHT - (70 + 90), 70, 70)
        let appledele = UIApplication.shared.delegate as! AppDelegate
        self.voiceListView.addSubview(btn)
        btn.backgroundColor = CommonUtil.color(hex: itemColor)
        btn.setImage(UIImage.init(named: "record"), for: UIControl.State.normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        btn.layer.cornerRadius = 35
        btn.layer.masksToBounds = true
        
    }
    @objc func floatAction(sener:UIButton) {
        popVoiceAlertView()
        RecordTool.shared.setupRecorder()
        RecordTool.shared.startRecording()
    }
    lazy var voiceListAlertView: TSVoiceListAlertView = {
        let calendar = TSVoiceListAlertView()
        calendar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500)
        calendar.backgroundColor = UIColor.white
        calendar.textView.textColor = UIColor.black
        return calendar
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        self.voiceListView = TSVoiceListView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseTableView: self.voiceListView)
        let dic = Dictionary<String, Any>()
        self.voiceListVo = self.voiceListVo.initByDic(dic: dic)
        self.voiceListView.reloadView(baseTableViewVo: self.voiceListVo)
        self.voiceListView.baseTableView.backgroundColor = CommonUtil.color(hex: bgViewColor)
        
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        self.voiceListView.baseTableView.mj_header = header
        self.voiceListView.baseTableView.mj_header?.beginRefreshing()
        
        
        initFloatyBtn()
        
  

        
//        getAllFile()
    }
    
    @objc func loadMoreData(){
    
        let arr = self.voiceListVo.queryAll()
        self.voiceListVo.refreshCellVo(videoArr: arr)
        self.voiceListView.reloadView(baseTableViewVo: self.voiceListVo)
        self.voiceListView.baseTableView.mj_header?.endRefreshing()
    }
    
    func getAllFile() {
        // Do any additional setup after loading the view, typically from a nib.
//        首先获得文件管理对象，它的功能包括：读取文件中的数据，向一个文件中写入，删除文件，或者复制，移动文件，比较两个文件内容的或者测试文件存在性等
        let manger = FileManager.default
//        创建一个字符串对象，表示文档目录
        let url = NSHomeDirectory() + "/Documents/images/"
        do{
//            获得文档目录下的所有目录，并存储在一个数组对象中
            let cintents1 = try manger.contentsOfDirectory(atPath: url)
            print("cintents:\(cintents1)\n")
            
//            获得此文档下所有内容，以及子文件夹下的内容，并储存在一个数组对象中
            let contents2 = manger.enumerator(atPath: url)
            print("contents2:\(String(describing: contents2?.allObjects))\n")
            
        } catch{
            print("Error occurs.")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.voiceListVo)
        var voiceListCell:TSVoiceListCell!
        var voiceListBannerCell:TSVoiceListBannerCell!
        var voiceListSettingCell:TSVoiceListSettingCell!

        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSVoiceListCell" {
                let cell_ID = "TSVoiceListCell"
                tableView.register(TSVoiceListCell.self, forCellReuseIdentifier: cell_ID)
                voiceListCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSVoiceListCell
                if voiceListCell==nil {
                    voiceListCell = TSVoiceListCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                voiceListCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                voiceListCell?.contentView.backgroundColor = UIColor.white
                return voiceListCell!
            }else if baseTableCellVo.cellName == "TSVoiceListBannerCell" {
                let cell_ID = "TSVoiceListBannerCell"
                tableView.register(TSVoiceListBannerCell.self, forCellReuseIdentifier: cell_ID)
                voiceListBannerCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSVoiceListBannerCell
                if voiceListBannerCell==nil {
                    voiceListBannerCell = TSVoiceListBannerCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                voiceListBannerCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                voiceListBannerCell.contentView.backgroundColor = CommonUtil.color(hex: itemColor)
                return voiceListBannerCell!
            }else if baseTableCellVo.cellName == "TSVoiceListSettingCell" {
                let cell_ID = "TSVoiceListSettingCell"
                tableView.register(TSVoiceListSettingCell.self, forCellReuseIdentifier: cell_ID)
                voiceListSettingCell = tableView.dequeueReusableCell(withIdentifier: cell_ID) as? TSVoiceListSettingCell
                if voiceListSettingCell==nil {
                    voiceListSettingCell = TSVoiceListSettingCell(style: .subtitle, reuseIdentifier: cell_ID)
                }
                voiceListSettingCell?.setCellDataByCellVo(baseTableCellVo: baseTableCellVo)
                voiceListSettingCell?.contentView.backgroundColor = UIColor.white
                voiceListSettingCell.more.addTarget(self, action: #selector(moreAction(sender:)), for: UIControl.Event.touchUpInside)
                
                return voiceListSettingCell!
            }
        }
        return voiceListCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.voiceListVo)
        if !baseTableCellVo.isEqual(NSNull.self) {
            if baseTableCellVo.cellName == "TSVoiceListCell" {
                return 80
            }else if baseTableCellVo.cellName == "TSVoiceListBannerCell"{
                return 150
            }else if baseTableCellVo.cellName == "TSVoiceListSettingCell"{
                return 44
            }
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseTableCellVo = super.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.voiceListVo)
        
        if baseTableCellVo.cellName == "TSVoiceListCell" {
            let vc = TSVoicePlayVC()
            vc.hidesBottomBarWhenPushed = true
            vc.dataDic = baseTableCellVo.dbDic
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func popVoiceAlertView() {
        let alertView = SPAlertController.init(customHeaderView: self.voiceListAlertView, preferredStyle: SPAlertControllerStyle.actionSheet, animationType: SPAlertAnimationType.fromBottom)
        alertView.setBackgroundViewAppearanceStyle(UIBlurEffect.Style.dark, alpha: 0.6)
        alertView.tapBackgroundViewDismiss = false
        self.voiceListAlertView.recordBlock = {(dic:Dictionary<String, Any>) in
            if self.recordState == "recording"{
                LGSpeechManager.share.lg_stopDictating()
                RecordTool.shared.stopRecording()
                self.recordState = "stop"
                self.voiceListAlertView.recordBtn.setImage(UIImage.init(named: "play"), for: UIControl.State.normal)
            }else{
                self.recordState = "recording"
                self.startSpeech()
//                RecordTool.shared.setupRecorder()
                RecordTool.shared.startRecording()
                self.voiceListAlertView.recordBtn.setImage(UIImage.init(named: "pause"), for: UIControl.State.normal)
            }
        };
        
        self.voiceListAlertView.stopBlock = {(dic:Dictionary<String, Any>) in
            LGSpeechManager.share.lg_stopDictating()
            RecordTool.shared.stopRecording()
            
            var dic1 = Dictionary<String,String>()
            dic1["path"] = RecordTool.shared.queryFilePath()
            dic1["date"] = String(format: dic["date"] as! String)
            dic1["title"] = String(format: dic["title"] as! String)
            dic1["location"] = String(format: dic["location"] as! String)
            dic1["duration"] = String(format: dic["duration"] as! String)
            
            let billIdentifier = CommonUtil.getIdentifier()
            self.voiceListVo.insertVoiceDao(dic: dic1, daoid: billIdentifier)
            
            self.dismiss(animated: true) {
                let arr = self.voiceListVo.queryAll()
                self.voiceListAlertView.recordBtn.setImage(UIImage.init(named: "pause"), for: UIControl.State.normal)
                self.voiceListVo.refreshCellVo(videoArr: arr)
                self.voiceListView.reloadView(baseTableViewVo: self.voiceListVo)
            }
        }
        self.present(alertView, animated: true) {
            self.voiceListAlertView.refreshTextNull()
            
            self.recordState = "recording"
            self.voiceListAlertView.recordBtn.setImage(UIImage.init(named: "pause"), for: UIControl.State.normal)
            
            self.voiceListAlertView.refreshCurentDate(text: CommonUtil.getCurrentTime())
            self.voiceListAlertView.refreshLocation(text: MMKVUtil.shared.getlocation())
            
            
            
            self.startSpeech()
            RecordTool.shared.timerChangeBlock = {(dic:Dictionary<String, Any>) in
                self.voiceListAlertView.timerCountLbl.text = dic["time"] as? String
            };
        }
    }
    
    func startSpeech() {
        LGSpeechManager.share.lg_startSpeech(speechVc: self, langugeSimple: "zh-CN") { speechType, finalText in
            // 获取语音识别结果
            if finalText != nil{
                self.voiceListAlertView.refreshTextView(text: finalText ?? "")
            }
        }
    }
    @objc func moreAction(sender:UIButton) {
        let vc = TSEditVideoListVC()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
