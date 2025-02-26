//
//  TSEditVideoAlertView.swift
//  TextScan
//
//  Created by Apple on 2023/11/20.
//

import UIKit

class TSEditVideoAlertView: UIView {
    
    typealias Comfirmlock = (_ dic:Dictionary<String, Any>)->Void;
    var comfirmlock : Comfirmlock?;
    
    typealias CancelBlock = (_ dic:Dictionary<String, Any>)->Void;
    var cancelBlock : CancelBlock?;
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont15
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        return lbl
    }()
    lazy var descriLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont15
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black

        return lbl
    }()
    
    lazy var cancelBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var comfirmBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Notice"
        descriLbl.text = "Delete or not?"
        cancelBtn.setTitle("Not yet", for: UIControl.State.normal)
        comfirmBtn.setTitle("Delete", for: UIControl.State.normal)
        cancelBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        comfirmBtn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        comfirmBtn.titleLabel?.font = textFont15
        cancelBtn.titleLabel?.font = textFont15
        
        cancelBtn.addTarget(self, action: #selector(cancelAction(sender:)), for: UIControl.Event.touchUpInside)
        comfirmBtn.addTarget(self, action: #selector(comfirmAction(sender:)), for: UIControl.Event.touchUpInside)
        self.backgroundColor = UIColor.white
        
    }
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRectMake(self.frame.width/2-60/2, 0, 60, 30)
        descriLbl.frame = CGRectMake(self.frame.width/2-200/2, title.frame.height + title.frame.origin.y, 200, 30)
        
        cancelBtn.frame = CGRectMake(0, descriLbl.frame.height + descriLbl.frame.origin.y + 20, self.frame.width/2, 44)
        comfirmBtn.frame = CGRectMake(self.frame.width/2, descriLbl.frame.height + descriLbl.frame.origin.y + 20, self.frame.width/2, 44)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.cancelBlock?(dic);
    }
    @objc func comfirmAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.comfirmlock?(dic);
    }
}
