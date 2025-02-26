//
//  TSVoiceListBannerCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSVoiceListBannerCell: BaseTableCell {

    lazy var banner: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.image = UIImage.init(named: "banner")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        banner.image = UIImage.init(named: "banner")
        self.contentView.backgroundColor = CommonUtil.color(hex: itemColor)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banner.frame = self.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
