//
//  TSPhotosCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit

class TSPhotosCell: UICollectionViewCell {
    
    lazy var img:UIImageView = {
        let title = UIImageView()
        contentView.addSubview(title)//scaleAspectFit
        title.contentMode = .scaleAspectFit
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        img.image = UIImage(named: "")
//        ShowHelper.show(imageView: img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
