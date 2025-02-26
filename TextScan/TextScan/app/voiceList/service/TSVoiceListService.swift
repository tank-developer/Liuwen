//
//  TSVoiceListService.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSVoiceListService: BaseTableViewService {
    
    func getInfoArray(dic:Dictionary<String,Any>) -> (NSMutableArray) {
        
        
        let TSVoiceListBannerCell = "TSVoiceListBannerCell"
        let TSVoiceListSettingCell = "TSVoiceListSettingCell"
        let TSVoiceListCell = "TSVoiceListCell"
        
        
        var reArray = NSMutableArray()
        var dbDic = Dictionary<String, Any>()
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSVoiceListBannerCell, lbl1: "", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSVoiceListSettingCell, lbl1: "", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        
        return reArray
    }
    
    
    func getVideoList() -> (NSMutableArray) {
        let TSVoiceListCell = "TSVoiceListCell"
        let reArray = NSMutableArray()
        let dbDic = Dictionary<String, Any>()
        
        reArray.add(YYCreator.createCommon11LblCellVo(cellName: TSVoiceListCell, lbl1: "", lbl2: "", lbl3: "", lbl4: "", lbl5: "", lbl6: "", lbl7: "", lbl8: "", lbl9: "", lbl10: "", lbl11: "", dbDic: dbDic))
        return reArray
    }
    
    func insert(dic:Dictionary<String,String>,daoId:String) -> Void {
        let date = dic["date"]
        let path = dic["path"]
        let daoId = daoId
        let title = dic["title"]
        let location = dic["location"]
        let duration = dic["duration"] 

        
        
        let dao = TSVoiceListDao()
    
        dao.date = date!
        dao.path = path!
        dao.daoId = daoId
        dao.title = title!
        dao.location = location!
        dao.duration = duration!
        
        DaoUtil.shareInstance().insert(toDb: dao)
        
    }
    
    
    func queryAll() -> Array<Dictionary<String,String>> {
        let arr = DaoUtil.shareInstance().queryAll()
        var pArray = Array<Dictionary<String,String>>.init()
        for (index,obj) in arr.enumerated(){
            var dao = obj as! TSVoiceListDao
            var dict: Dictionary<String, String> = [:]
            dict["title"] = dao.title
            dict["date"] = dao.date
            dict["location"] = dao.location
            dict["duration"] = dao.duration
            dict["path"] = dao.path
            dict["date"] = dao.date
            dict["daoId"] = dao.daoId

            pArray.append(dict)
        }
        return pArray
    }
    
    func deleteItemBy(dic:Dictionary<String,Any>) -> Bool {
//        let arr = DaoUtil.shareInstance().queryAll()
        var dao = TSVoiceListDao()
        dao.title = dic["title"] as! String
        dao.date = dic["date"] as! String
        dao.location = dic["location"] as! String
        dao.duration = dic["duration"] as! String
        dao.path = dic["path"] as! String
        dao.date = dic["date"] as! String
        dao.daoId = dic["daoId"] as! String
        var result = DaoUtil.shareInstance().deleteVoiceItem(byDic: dao)
        return result
    }
    
    /*
     {
         var pArray = Array<Any>.init()
         let arr =  CWSwiftHandleOCObject.shareInstance().queryAllModelWhereDate(ele)
         for (index,obj) in arr.enumerated(){
             var dao = obj as! BKBillListDao
             var dict: Dictionary<String, String> = [:]
             dict["count"] = dao.count
             dict["type"] = dao.type
             dict["title"] = dao.title
             dict["icon"] = dao.icon
             dict["remark"] = dao.remark
             dict["date"] = dao.date
             dict["year"] = dao.year
             dict["month"] = dao.month
             dict["day"] = dao.day
             dict["daoId"] = String(dao.daoId)
             dict["timeTemp"] = String(dao.timeTemp)

             pArray.append(dict)
         }
         print(pArray)
         return pArray
     }
     */
}
