//
//  TSSettingVo.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSSettingVo: BaseTableViewVo {
    
    
    var settingService:TSSettingService!
    public var videoCellVoArray = NSMutableArray()

    override init() {
        super.init()
    }
    
    func initByDic(dic:Dictionary<String,Any>) -> Self! {
        self.settingService = TSSettingService()
        self.cellVoArray = self.settingService.getInfoArray(dic: dic)
        self.reloadDataArray()
        return self
    }
    
    func reloadDataArray() -> () {
        let totalCount = CommonUtil.getArrayCount(inArray: self.cellVoArray)
        self.dataArray.removeAllObjects()
        self.dataArray = NSMutableArray.init(capacity: totalCount)
        CommonUtil.addDataToNSMutableArray(trgArray: self.dataArray, inArray: self.cellVoArray)
    }
    
}
