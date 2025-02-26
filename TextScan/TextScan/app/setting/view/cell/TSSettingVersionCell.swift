//
//  TSSettingVersionCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/18.
//

import UIKit

class TSSettingVersionCell: BaseTableCell {
    
    lazy var versionLbl: UILabel = {
        let img = UILabel()
        self.contentView.addSubview(img)
        img.textColor = UIColor.black
        img.font = textFont18
        img.textAlignment = .right
        return img
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = textFont18
        self.textLabel?.textColor = UIColor.black
    }
    
    override func setCellDataByCellVo(baseTableCellVo: BaseTableCellVo) {
        self.textLabel?.text = String(format: baseTableCellVo.cellDataDic["lbl1"] as! String)
        versionLbl.text = String(format: baseTableCellVo.cellDataDic["lbl2"] as! String)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        versionLbl.frame = CGRectMake(self.contentView.frame.width - (70), self.contentView.frame.height/2-20/2, 60, 20)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
