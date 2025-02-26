//
//  TSSettingCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/18.
//

import UIKit

class TSSettingCell: BaseTableCell {
    
    lazy var arrow: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = textFont18
        self.textLabel?.textColor = UIColor.black
        arrow.image = UIImage.init(named: "right")
    }
    
    override func setCellDataByCellVo(baseTableCellVo: BaseTableCellVo) {
        self.textLabel?.text = String(format: baseTableCellVo.cellDataDic["lbl1"] as! String)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrow.frame = CGRectMake(self.contentView.frame.width - (30), self.contentView.frame.height/2-20/2, 20, 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
