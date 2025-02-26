//
//  TSEditVideoListService.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSEditVideoListService: BaseTableViewService {
    func getInfoArray(dic:Dictionary<String,Any>) -> (NSMutableArray) {
        
        let TSEditVideoListCell = "TSEditVideoListCell"
        
        
        var reArray = NSMutableArray()
        var dbDic = Dictionary<String, Any>()
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSEditVideoListCell, lbl1: "count", lbl2: "count", lbl3: "count", lbl4: "count", lbl5: "count", lbl6: "count", lbl7: "count", lbl8: "手动记账", lbl9: "count", lbl10: "count", lbl11: "name", dbDic: dbDic))
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSEditVideoListCell, lbl1: "count", lbl2: "count", lbl3: "count", lbl4: "count", lbl5: "count", lbl6: "count", lbl7: "count", lbl8: "", lbl9: "count", lbl10: "count", lbl11: "name", dbDic: dbDic))
        
        return reArray
    }
}
