//
//  TSSettingService.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSSettingService: BaseTableViewService {
    func getInfoArray(dic:Dictionary<String,Any>) -> (NSMutableArray) {
        
        let TSSettingCell = "TSSettingCell"
        let TSSettingVersionCell = "TSSettingVersionCell"
        let TSSettingAppsCell = "TSSettingAppsCell"

        let infoDictionary : [String : Any] = Bundle.main.infoDictionary!

        let minorVersion : Any = infoDictionary["CFBundleVersion"] as Any // 版本号(内部标示)
        let mainVersion : Any = infoDictionary["CFBundleShortVersionString"] as Any // 主程序版本号

        
        var reArray = NSMutableArray()
        var dbDic = Dictionary<String, Any>()
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSSettingCell, lbl1: "Privacy Policy", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSSettingVersionCell, lbl1: "Version", lbl2: mainVersion as! String, lbl3: "count", lbl4: "count", lbl5: "count", lbl6: "count", lbl7: "count", lbl8: "", lbl9: "count", lbl10: "count", lbl11: "name", dbDic: dbDic))
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSSettingCell, lbl1: "Share", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSSettingAppsCell, lbl1: "More Apps", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))

        return reArray
    }
    
}
