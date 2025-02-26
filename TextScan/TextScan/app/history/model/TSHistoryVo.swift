//
//  TSHistoryVo.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSHistoryVo: BaseTableViewVo {
    
    
    var historyService:TSHistoryService!

    
    override init() {
        super.init()
    }
    
    func initByDic(dic:Dictionary<String,Any>) -> Self! {
        self.historyService = TSHistoryService()
        self.cellVoArray = self.historyService.getInfoArray(dic: dic)
        
        self.reloadDataArray()
        return self
    }
    
    func reloadDataArray() -> () {
        let totalCount = CommonUtil.getArrayCount(inArray: self.cellVoArray)
        self.dataArray.removeAllObjects()
        self.dataArray = NSMutableArray.init(capacity: totalCount)
        CommonUtil.addDataToNSMutableArray(trgArray: self.dataArray, inArray: self.cellVoArray)
    }
    
    func refreshCellvo(imgArr:Array<Dictionary<String,String>>) {
        self.cellVoArray.removeAllObjects()
        let TSHistoryCell = "TSHistoryCell"
        
        for (index,obj) in imgArr.enumerated(){
            let path = obj["path"];
            let title = obj["title"];

            self.cellVoArray.add(YYCreator.createCommon11LblEditCellVo(cellName: TSHistoryCell, lbl1: path ?? "", lbl2: title ?? "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: obj))
        }
        self.reloadDataArray()
    }
}
