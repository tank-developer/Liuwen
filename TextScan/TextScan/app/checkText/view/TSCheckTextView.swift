//
//  TSCheckTextView.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSCheckTextView: BaseTemplateView {

    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    lazy var textview:UITextView = {
        let title = UITextView()
        self.addSubview(title)
        title.font = textFont17
        title.textColor = UIColor.black
        title.backgroundColor = UIColor.white
        return title
    }()
    
    lazy var bottomView: TSCheckTextBottomView = {
        let v = TSCheckTextBottomView()
        self.addSubview(v)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerView)
        self.addSubview(textview)
        self.addSubview(bottomView)
    }
    
    func upBottomView() {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64)
        textview.frame = CGRectMake(0, headerView.frame.height + headerView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 64)
        bottomView.frame = CGRectMake(0, textview.frame.height + textview.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 10)
    }
    func downBottomView() {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64)
        textview.frame = CGRectMake(0, headerView.frame.height + headerView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
        bottomView.frame = CGRectMake(0, textview.frame.height + textview.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 10)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64)
//        textview.frame = CGRectMake(0, headerView.frame.height + headerView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
//        bottomView.frame = CGRectMake(0, textview.frame.height + textview.frame.origin.y, SCREEN_WIDTH, SCREEN_WIDTH/2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
