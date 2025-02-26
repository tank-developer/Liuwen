//
//  TSVoiceListAlertView.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSVoiceListAlertView: UIView {
    
    typealias RecordBlock = (_ dic:Dictionary<String, Any>)->Void;
    var recordBlock : RecordBlock?;
    
    typealias StopBlock = (_ dic:Dictionary<String, Any>)->Void;
    var stopBlock : StopBlock?;
    
    lazy var timerCountLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.text = "00:00"
        lbl.font = textFont13
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.text = "2023年11月11日 15:48 · APP"
        lbl.font = textFont15
        lbl.textColor = UIColor.black
        return lbl
    }()
    lazy var locationLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.text = "琼海市"
        lbl.font = textFont17
        lbl.textColor = UIColor.black
        return lbl
    }()
//    lazy var textLbl: UILabel = {
//        let lbl = UILabel()
//        self.addSubview(lbl)
//        lbl.text = "都是风景"
//        lbl.font = textFont15
//        lbl.textColor = UIColor.black
//        return lbl
//    }()
    
    
    lazy var recordBtn: UIButton = {
        let btn = UIButton()
//        self.addSubview(btn)
        btn.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        btn.setTitle("", for: UIControl.State.normal)
        btn.titleLabel?.font = textFont15
        btn.backgroundColor = CommonUtil.color(hex: itemColor)
        //        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        return btn
    }()
    lazy var stopyBtn: UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        btn.setImage(UIImage(named: "stopRecord"), for: UIControl.State.normal)
        btn.setTitle("", for: UIControl.State.normal)
        btn.titleLabel?.font = textFont15
        btn.backgroundColor = CommonUtil.color(hex: itemColor)
        //        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    lazy var videoPath: String = {
        let p = String()
        return p
    }()
    
//    lazy var cancelBtn: UIButton = {
//        let lbl = UIButton()
//        self.addSubview(lbl)
//        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        lbl.titleLabel?.font = textFont17
//        lbl.setTitle("X", for: UIControl.State.normal)
//        return lbl
//    }()
//    lazy var comfirmBtn: UIButton = {
//        let lbl = UIButton()
//        self.addSubview(lbl)
//        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        lbl.titleLabel?.font = textFont17
//        lbl.setTitle("P", for: UIControl.State.normal)
//        return lbl
//    }()
    
    
    
    lazy var textView: UITextView = {
        let tex = UITextView()
        self.addSubview(tex)
        tex.isEditable = false
        tex.font = textFont17
        tex.text = "都是风景"
        tex.textAlignment = .left
        tex.backgroundColor = UIColor.white
        tex.textColor = UIColor.black
        return tex
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timerCountLbl.text = "00:00:00"
        dateLbl.text = ""
        locationLbl.text = ""
        textView.text = ""
        textView.textColor = UIColor.black
        recordBtn.setTitle("", for: UIControl.State.normal)
        stopyBtn.setTitle("", for: UIControl.State.normal)
        
        
        recordBtn.addTarget(self, action: #selector(recordAction(sender:)), for: UIControl.Event.touchUpInside)
        stopyBtn.addTarget(self, action: #selector(stopAction(sender:)), for: UIControl.Event.touchUpInside)
//        textView.text = ""
    }
    
    func refreshTextNull() {
        textView.text = ""
    }
    
    func refreshTextView(text:String) {
        textView.text = text
    }
    
    func refreshCurentDate(text:String) {
        dateLbl.text = text
    }
    func refreshLocation(text:String) {
        locationLbl.text = text
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        timerCountLbl.frame = CGRectMake(20, 20, self.frame.width/2, 44)
        dateLbl.frame = CGRectMake(20, timerCountLbl.frame.height + timerCountLbl.frame.origin.y + 0, self.frame.width, 44)
        locationLbl.frame = CGRectMake(20, dateLbl.frame.height + dateLbl.frame.origin.y  + 0, self.frame.width, 50)
        textView.frame = CGRectMake(20, locationLbl.frame.height + locationLbl.frame.origin.y + 10, self.frame.width - 40, 400)
        
        recordBtn.frame = CGRectMake(self.frame.size.width/2-50/2, self.frame.size.height - (50 + 30), 50, 50)
        stopyBtn.frame = CGRectMake(self.frame.size.width - (50 + 20), self.frame.size.height - (50 + 30), 50, 50)
        
    }
    @objc func recordAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.recordBlock?(dic);
    }
    @objc func stopAction(sender:UIButton) {
        var dic = Dictionary<String, Any>()
        
        dic["duration"] = timerCountLbl.text
        dic["date"] = dateLbl.text
        dic["location"] = locationLbl.text
        dic["title"] = textView.text
        
        self.stopBlock?(dic);
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
