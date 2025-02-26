//
//  TSEditImgLanguageCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/22.
//

import UIKit

class TSEditImgLanguageCell: UITableViewCell {
    
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title.text = ""
        title.textColor = UIColor.black
        self.contentView.backgroundColor = UIColor.white
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRectMake(self.contentView.frame.width/2-100/2, self.contentView.frame.height/2-30/2, 100, 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
