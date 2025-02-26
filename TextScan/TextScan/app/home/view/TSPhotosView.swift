//
//  TSPhotosView.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit

class TSPhotosView: BaseTemplateView {
    //全局变量
    var screen_width:CGFloat! = UIScreen.main.bounds.size.height
    var screen_height:CGFloat! = UIScreen.main.bounds.size.width
    
    
    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    
    lazy var collectionView:UICollectionView = {
        //1, 流布局
        let layout = UICollectionViewFlowLayout.init()
            //2, 设置每个item的大小
        layout.itemSize = CGSize(width: 60, height: 85)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //3, 垂直和水平滑动
        //        UICollectionViewScrollDirection.vertical  省略写法  .vertial
        //        UICollectionViewScrollDirection.horizontal  省略写法  .horizontal
//        layout.scrollDirection = .vertical
        //4, 每个item之间的最小距离 inter 之间
        layout.minimumInteritemSpacing = 5
            
        //5, 每行之间的最小距离
        layout.minimumLineSpacing = 5
            
        //6, 定义collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screen_width, height: 200), collectionViewLayout: layout)
        
        //7, 注册collectionViewCell
        collectionView.register(TSPhotosCell.self, forCellWithReuseIdentifier: "TSPhotosCell")
        
        //11, 分页显示效果
//        collectionView.isPagingEnabled = true
            
        collectionView.backgroundColor = UIColor.white
            
        self.addSubview(collectionView)

        return collectionView
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
        
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height)
        collectionView.frame = CGRectMake(0, headerView.frame.height + headerView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT - height)
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
