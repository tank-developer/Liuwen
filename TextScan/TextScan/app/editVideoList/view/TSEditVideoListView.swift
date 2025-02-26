//
//  TSEditVideoListView.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSEditVideoListView: BaseTableView {
    
    
    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        btn.backgroundColor = UIColor.red
        btn.setTitle("Delete", for: UIControl.State.normal)

        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        
        
//        self.deleteBtn.setTitle("删除", for: UIControl.State.normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let vc = CommonUtil.getVCfromView(views: self) as! UIViewController
        let barHeight = CommonUtil.getNavigationHeight(vc: vc)
        let statusHeight = CommonUtil.getStatusHeight()
        let height = statusHeight + barHeight
        
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height)
        
        baseTableView.frame = CGRectMake(0,  headerView.frame.height +  headerView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT - (44 + height))
        deleteBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)
        
    }

}
