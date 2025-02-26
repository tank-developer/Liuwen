//
//  TSHistoryView.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSHistoryView: BaseTableView {
    
    

    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let vc = CommonUtil.getVCfromView(views: self) as! UIViewController
        let barHeight = CommonUtil.getNavigationHeight(vc: vc)
        let statusHeight = CommonUtil.getStatusHeight()
        let height = statusHeight + barHeight
        
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height)
        self.baseTableView.frame = CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT - height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
