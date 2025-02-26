//
//  BKPrivateAlertView.swift
//  CalendarWidget
//
//  Created by Apple on 2023/10/3.
//

import UIKit

class BKPrivateAlertView: UIView {
    typealias CancelBlock = (_ dic:Dictionary<String, Any>)->Void;
    var cancelBlock : CancelBlock?;
    
    typealias ComfirmBlock = (_ dic:Dictionary<String, Any>)->Void;
    var comfirmBlock : ComfirmBlock?;
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.textColor = UIColor.black
        lbl.textAlignment = .center
        lbl.font = textFont18
        return lbl
    }()
    lazy var descriptLbl: UITextView = {
        let lbl = UITextView()
        self.addSubview(lbl)
        lbl.isEditable = false
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        lbl.font = textFont15
        lbl.backgroundColor = UIColor.white
        return lbl
    }()
    lazy var privateBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        return lbl
    }()
    
    lazy var cancelBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        return lbl
    }()
    lazy var comfirmBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLbl.text = "隐私协议"
        descriptLbl.text = "在使用溜溜记账app之前，为了保护你的使用权利，请先阅读用户隐私协议。如果年同意请点击\"同意\"开始接受我们的服务"
        privateBtn.setTitle("《隐私协议》", for: UIControl.State.normal)
        
        cancelBtn.setTitle("不同意", for: UIControl.State.normal)
        comfirmBtn.setTitle("同意", for: UIControl.State.normal)
        self.backgroundColor = UIColor.white
        
        cancelBtn.addTarget(self, action: #selector(cancelAction(sender:)), for: UIControl.Event.touchUpInside)
        comfirmBtn.addTarget(self, action: #selector(comfirmAction(sender:)), for: UIControl.Event.touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLbl.frame = CGRectMake(self.frame.width/2-200/2, 5, 200, 44)
        descriptLbl.frame = CGRectMake(self.frame.width/2-230/2, titleLbl.frame.height + titleLbl.frame.origin.y + 5, 230, 100)
        privateBtn.frame = CGRectMake(self.frame.width/2-130/2, descriptLbl.frame.height + descriptLbl.frame.origin.y + 5, 130, 44)
        cancelBtn.frame = CGRectMake(0, privateBtn.frame.height + privateBtn.frame.origin.y + 5, self.frame.width/2, 44)
        comfirmBtn.frame = CGRectMake(self.frame.width/2, privateBtn.frame.height + privateBtn.frame.origin.y + 5, self.frame.width/2, 44)
    }
    
    
    @objc func cancelAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.cancelBlock?(dic);
    }
    @objc func comfirmAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.comfirmBlock?(dic);
    }
}
