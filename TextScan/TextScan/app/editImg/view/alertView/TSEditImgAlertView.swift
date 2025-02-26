//
//  TSEditImgAlertView.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSEditImgAlertView: UIView {
    
    
    typealias CancelBlock = (_ dic:Dictionary<String, Any>)->Void;
    var cancelBlock : CancelBlock?;
    
    typealias ComfirmBlock = (_ dic:Dictionary<String, Any>)->Void;
    var comfirmBlock : ComfirmBlock?;
    
    typealias CheckBlock = (_ dic:Dictionary<String, Any>)->Void;
    var checkBlock : CheckBlock?;
    
    
    lazy var cancelBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        lbl.setTitle("cancel", for: UIControl.State.normal)
        return lbl
    }()
    lazy var comfirmBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
//        lbl.setTitle("✓", for: UIControl.State.normal)
        lbl.setTitle("copy", for: UIControl.State.normal)
        return lbl
    }()
    lazy var checkBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        lbl.setTitle("Check", for: UIControl.State.normal)
        return lbl
    }()
    
    lazy var textView: UITextView = {
        let tex = UITextView()
        self.addSubview(tex)
        tex.isEditable = false
        tex.font = textFont17
        tex.textAlignment = .left
        tex.textColor = UIColor.black
        tex.backgroundColor = UIColor.white
        return tex
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cancelBtn.addTarget(self, action: #selector(cancelAction(sender:)), for: UIControl.Event.touchUpInside)
        comfirmBtn.addTarget(self, action: #selector(comfirmAction(sender:)), for: UIControl.Event.touchUpInside)
        checkBtn.addTarget(self, action: #selector(checkAction(sender:)), for: UIControl.Event.touchUpInside)

        textView.text = ""
    }
    
    func refreshTextView(text:String) {
        textView.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.frame = CGRectMake(10, 10, 64, 54)
        comfirmBtn.frame = CGRectMake(SCREEN_WIDTH - (54 + 5), 10, 54, 54)
        textView.frame = CGRectMake(0, cancelBtn.frame.height + cancelBtn.frame.origin.y, SCREEN_WIDTH, 400)
        checkBtn.frame = CGRectMake(SCREEN_WIDTH/2-54/2, textView.frame.height + textView.frame.origin.y, 54, 54)
        
    }
    @objc func cancelAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.cancelBlock?(dic);
    }
    @objc func comfirmAction(sender:UIButton) {
        var dic = Dictionary<String, Any>()
        dic["title"] = textView.text
        
        self.comfirmBlock?(dic);
    }
    @objc func checkAction(sender:UIButton) {
        var dic = Dictionary<String, Any>()
        dic["title"] = textView.text
        self.checkBlock?(dic);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
