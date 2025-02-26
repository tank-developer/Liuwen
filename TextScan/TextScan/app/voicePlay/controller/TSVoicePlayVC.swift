//
//  TSVoicePlayVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit
import AVFAudio

class TSVoicePlayVC: BaseTemplateVC {
    
    var playStatus:String = "pause"
    
    lazy var voicePlayVo:TSVoicePlayVo = {
        let vo = TSVoicePlayVo()
        return vo
    }()
    lazy var voicePlayService:TSVoicePlayService = {
        let service = TSVoicePlayService()
        return service
    }()
    
    var voicePlayView:TSVoicePlayView!
    
    var dataDic:Dictionary<String,Any> = Dictionary<String,Any>()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let path = dataDic["path"]
        RecordTool.shared.pause(fileName: path as! String)
    }
    
    override func initBaseView() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.voicePlayView = TSVoicePlayView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseView: self.voicePlayView)
        self.voicePlayView.backgroundColor = UIColor.white
        
        let dic = Dictionary<String, Any>()
//        self.requestWithURL(url: urlStr, pamDic: dic, loadingText: "", requestType: Request.POST)
        
        voicePlayView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        voicePlayView.bottomView.playBtn.addTarget(self, action: #selector(playAction(sender:)), for: UIControl.Event.touchUpInside)
        
        voicePlayView.textView.text = dataDic["title"] as! String
        voicePlayView.location.text = dataDic["location"] as! String
        voicePlayView.dateLbl.text = dataDic["date"] as! String
        voicePlayView.durationLbl.text = dataDic["duration"] as! String
        
        self.voicePlayView.headerView.setupBackImagename(imagename: "left")
        playStatus = "stop"

        RecordTool.shared.playFinishBlock = {(dic:Dictionary<String, Any>) in
            self.voicePlayView.bottomView.refreshPlayBtn(imagename: "play")
            self.playStatus = "stop"
        };
        RecordTool.shared.timerChangeBlock = {(dic:Dictionary<String, Any>) in
            self.voicePlayView.timeLbl.text = dic["time"] as! String
        };

        self.voicePlayView.headerView.setupTitleText(title: "Play")
        
    }
    
    @objc func backAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func playAction(sender:UIButton) {
        let path = dataDic["path"]
        
        if playStatus == "play"{
            RecordTool.shared.pause(fileName: path as! String)
            playStatus = "stop"
            voicePlayView.bottomView.refreshPlayBtn(imagename: "play")
        }else if playStatus == "stop"{
            RecordTool.shared.playBy(fileName: path as! String)
            playStatus = "play"
            voicePlayView.bottomView.refreshPlayBtn(imagename: "pause")

        }
    }
    
}
