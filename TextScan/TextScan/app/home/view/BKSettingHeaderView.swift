//
//  BKSettingHeaderView.swift
//  CalendarWidget
//
//  Created by Apple on 2023/9/22.
//

import UIKit

class BKSettingHeaderView: UIView {
    
    lazy var backBtn: UIButton = {
        let back = UIButton()
        self.addSubview(back)
        return back
    }()
    
    lazy var titleLbl: UILabel = {
        let back = UILabel()
        self.addSubview(back)
        back.textAlignment = .center
        back.textColor = UIColor.white
        back.font = textFont18
        return back
    }()
    
    lazy var rightBtn: UIButton = {
        let right = UIButton()
        self.addSubview(right)
        right.setTitleColor(UIColor.white, for: UIControl.State.normal)
        right.titleLabel?.font = textFont20
        return right
    }()
    
    lazy var outputBtn: UIButton = {
        let right = UIButton()
        self.addSubview(right)
        right.setTitleColor(UIColor.white, for: UIControl.State.normal)
        right.titleLabel?.font = textFont20
        right.backgroundColor = UIColor.clear
        return right
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = CommonUtil.color(hex: itemColor)
        backBtn.isHidden = true
        backBtn.setImage(UIImage(named: "left"), for: UIControl.State.normal)
        
        titleLbl.text = ""
        
        outputBtn.backgroundColor = UIColor.clear
        outputBtn.isHidden = true
        
        rightBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        rightBtn.isHidden = true
        
    }
    
    func setupOutputBtnImg(img:String) -> Void {
        outputBtn.isHidden = false
        outputBtn.setImage(UIImage.init(named: img), for: UIControl.State.normal)
    }
    
    func setupOutputBtntitle(title:String) -> Void {
        outputBtn.isHidden = false
        outputBtn.setTitle(title, for: UIControl.State.normal)
    }
    
    
    func setupBackHide(hide:Bool) -> Void {
        backBtn.isHidden = hide
    }
    func setupBackImagename(imagename:String) -> Void {
        backBtn.isHidden = false
        backBtn.setImage(UIImage(named: imagename), for: UIControl.State.normal)
    }
    
    func setupTitleText(title:String) -> Void {
        titleLbl.isHidden = false
        titleLbl.text = title
    }
    
    
    func setupRightImg(img:String) -> Void {
        rightBtn.isHidden = false
        rightBtn.setImage(UIImage.init(named: img), for: UIControl.State.normal)
    }
    func setupRightTitle(title:String) -> Void {
        rightBtn.isHidden = false
        rightBtn.setTitle(title, for: UIControl.State.normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backBtn.frame = CGRectMake(10, self.frame.height/2-30/2 + 6, 40, 40)
        titleLbl.frame = CGRectMake(self.frame.width/2-100/2, self.frame.height/2-44/2 + 10, 100, 44)
        outputBtn.frame = CGRectMake(titleLbl.frame.width + titleLbl.frame.origin.x + 10, self.frame.height/2-40/2 + 10, 40, 40)
        rightBtn.frame = CGRectMake(self.frame.width - (40 + 10), self.frame.height/2-40/2 + 10, 40, 40)
        
        
    }
}
