//
//  TSVoicePlayView.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSVoicePlayView: BaseTemplateView {
    
    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    
    lazy var durationLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont13
        lbl.textColor = UIColor.black

        return lbl
    }()
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont13
        lbl.backgroundColor = UIColor.white
        lbl.textColor = UIColor.black
        
        return lbl
    }()
    lazy var location: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont25
        lbl.backgroundColor = UIColor.white
        lbl.textColor = UIColor.black

        return lbl
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = textFont13
        lbl.backgroundColor = UIColor.white
        lbl.textColor = UIColor.black

        return lbl
    }()
    
    lazy var textView: UITextView = {
        let tex = UITextView()
        self.addSubview(tex)
        tex.isEditable = false
        tex.font = textFont17
        tex.textAlignment = .center
        tex.textColor = UIColor.black
        tex.backgroundColor = UIColor.white
        return tex
    }()
    
    lazy var bottomView: TSVoicePlayBottomView = {
        let tex = TSVoicePlayBottomView()
        self.addSubview(tex)
        return tex
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.durationLbl.text = "00:00:00"
        self.dateLbl.text = "11月12日 12:14"
        self.timeLbl.text = "00:00:00"
        
        self.location.text = "琼海市"
        textView.text = "大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和大海大海大海和"
        bottomView.backgroundColor = UIColor.white
        self.headerView.backgroundColor = CommonUtil.color(hex: itemColor)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let vc = CommonUtil.getVCfromView(views: self) as! UIViewController
        let barHeight = CommonUtil.getNavigationHeight(vc: vc)
        let statusHeight = CommonUtil.getStatusHeight()
        let height = statusHeight + barHeight
        
        // 64 + 25 + 50 + 60
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height)
        
        
        durationLbl.frame = CGRectMake(20, headerView.frame.height + headerView.frame.origin.y + 20, 80, 25)
        dateLbl.frame = CGRectMake(durationLbl.frame.width + durationLbl.frame.origin.x, headerView.frame.height + headerView.frame.origin.y + 20, 150, 25)
        timeLbl.frame = CGRectMake(SCREEN_WIDTH - (80 + 10), headerView.frame.height + headerView.frame.origin.y + 20, 80, 25)
        
        location.frame = CGRectMake(20, durationLbl.frame.height + durationLbl.frame.origin.y, 300, 50)
        
        
        let line = CALayer()
        self.layer.addSublayer(line)
        line.frame = CGRectMake(20, location.frame.height + location.frame.origin.y, self.frame.width - 40, 1)
        line.backgroundColor = UIColor.lightGray.cgColor
        
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80)
        
        textView.frame = CGRectMake(20, location.frame.height + location.frame.origin.y + 20, self.frame.width - 40, self.frame.height - 219 + 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
