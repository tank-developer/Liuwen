//
//  TSVoiceListSettingCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSVoiceListSettingCell: BaseTableCell {

    lazy var fileTitle: UILabel = {
        let file = UILabel()
        self.contentView.addSubview(file)
        file.font = textFont20
        file.textColor = UIColor.black
        return file
    }()
    
    lazy var more: UIButton = {
        let file = UIButton()
        self.contentView.addSubview(file)
        return file
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        fileTitle.text = "File"
        more.setImage(UIImage.init(named: "historyList"), for: UIControl.State.normal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fileTitle.frame = CGRectMake(20, self.frame.height/2-50/2, 50, 50)
        more.frame = CGRectMake(self.frame.width - 70, self.frame.height/2-50/2, 50, 50)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
