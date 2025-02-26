//
//  TSVoicePlayBottomView.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSVoicePlayBottomView: UIView {
    
    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = CommonUtil.color(hex: itemColor)
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        self.addSubview(btn)
        return btn
    }()
    
    lazy var durationLbl: UILabel = {
        let btn = UILabel()
        btn.backgroundColor = UIColor.white
        self.addSubview(btn)
        btn.textColor = UIColor.black
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playBtn.setImage(UIImage.init(named: "play"), for: UIControl.State.normal)
    }
    
    func refreshPlayBtn(imagename:String) {
        playBtn.setImage(UIImage.init(named: imagename), for: UIControl.State.normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playBtn.frame = CGRectMake(self.frame.width/2-60/2, self.frame.height/2-60/2 - 0, 60, 60)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
