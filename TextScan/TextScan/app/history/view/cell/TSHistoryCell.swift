//
//  TSHistoryCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSHistoryCell: BaseTableCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = UIColor.black

    }
    
    override func setCellDataByCellVo(baseTableCellVo: BaseTableCellVo) {
        textLabel?.text = String(format: baseTableCellVo.cellDataDic["lbl2"] as! String)
        
//        detailTextLabel?.text = String(format: baseTableCellVo.cellDataDic["lbl2"] as! String)
        
        
//        let dic1 = imgArray.first as! Dictionary<String,String>
        
        let path = NSHomeDirectory() + "/Documents/images/" + String(format: baseTableCellVo.cellDataDic["lbl1"] as! String)
        let getImg = UIImage(contentsOfFile: path)
        
        self.imageView?.image = getImg
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
