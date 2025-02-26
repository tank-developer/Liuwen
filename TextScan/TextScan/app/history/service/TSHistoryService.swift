//
//  TSHistoryService.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSHistoryService: BaseTableViewService {
    func getInfoArray(dic:Dictionary<String,Any>) -> (NSMutableArray) {
        
        
        let TSHistoryCell = "TSHistoryCell"
        
        
        var reArray = NSMutableArray()
        var dbDic = Dictionary<String, Any>()
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSHistoryCell, lbl1: "", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        return reArray
    }
    
}
