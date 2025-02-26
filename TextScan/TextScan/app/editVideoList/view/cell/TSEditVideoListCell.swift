//
//  TSEditVideoListCell.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSEditVideoListCell: BaseTableCell {
    
    lazy var durationLbl: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = textFont13
        lbl.textColor = UIColor.black
        return lbl
    }()
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = textFont13
        lbl.textColor = UIColor.black

        return lbl
    }()
    lazy var location: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = textFont17
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.durationLbl.text = "00:00"
        self.dateLbl.text = "11月12日 12:14"
        self.location.text = "琼海市"
        self.contentView.backgroundColor = UIColor.white
    }
    
    override func setCellDataByCellVo(baseTableCellVo: BaseTableCellVo) {
        let title = baseTableCellVo.cellDataDic["lbl4"] as! String
        let duration = baseTableCellVo.cellDataDic["lbl3"] as! String
        let dateLbl = baseTableCellVo.cellDataDic["lbl5"] as! String
        
        self.location.text = title
        
        self.durationLbl.text = duration
        self.dateLbl.text = dateLbl

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        durationLbl.frame = CGRectMake(20, 10, 80, 25)
        dateLbl.frame = CGRectMake(durationLbl.frame.width + durationLbl.frame.origin.y, 10, 150, 25)
        location.frame = CGRectMake(20, durationLbl.frame.height + durationLbl.frame.origin.y, 200, 50)
        
        let line = CALayer()
        self.layer.addSublayer(line)
        line.frame = CGRectMake(20, location.frame.height + location.frame.origin.y, self.frame.width - 40, 0.7)
        line.backgroundColor = UIColor.lightGray.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
