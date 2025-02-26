//
//  TSEditVideoListVo.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSEditVideoListVo: BaseTableViewVo {
    
    var editVideoListService:TSEditVideoListService!

    override init() {
        super.init()
    }
    
    func initByDic(dic:Dictionary<String,Any>) -> Self! {
        self.editVideoListService = TSEditVideoListService()
        self.cellVoArray = self.editVideoListService.getInfoArray(dic: dic)
        self.reloadDataArray()
        return self
    }
    
    func reloadDataArray() -> () {
        let totalCount = CommonUtil.getArrayCount(inArray: self.cellVoArray)
        self.dataArray.removeAllObjects()
        self.dataArray = NSMutableArray.init(capacity: totalCount)
        CommonUtil.addDataToNSMutableArray(trgArray: self.dataArray, inArray: self.cellVoArray)

    }
    func dateStrToTimeInterval(dateStr: String) -> Int  {
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
          let date = dateformatter.date(from: dateStr)
          let dateTimeInterval:TimeInterval = date!.timeIntervalSince1970
          return Int(dateTimeInterval)
    }
    
    func refreshCellVo(arr:Array<Dictionary<String,String>>)  {
        self.cellVoArray.removeAllObjects()
        let TSEditVideoListCell = "TSEditVideoListCell"
        var dbDic = Dictionary<String, Any>()
        
        let newVideoArr = arr.sorted { dic0, dic1 in
            let date0 = dic0["date"] as! String
            let date1 = dic1["date"] as! String
            let timeTem0 = self.dateStrToTimeInterval(dateStr: date0)
            let timeTem1 = self.dateStrToTimeInterval(dateStr: date1)
            
            return timeTem0 > timeTem1
        }
        
        for (index,obj) in newVideoArr.enumerated(){
            var daoDic = obj as Dictionary<String,Any>
            var dic = obj
            let path = dic["path"] as! String
            let title = dic["title"] as! String
            let duration = dic["duration"] as! String
            let location = dic["location"] as! String
            let date = dic["date"] as! String
            
            cellVoArray.add(YYCreator.createCommon11LblCellVo(cellName: TSEditVideoListCell, lbl1: path, lbl2: title, lbl3: duration, lbl4: location, lbl5: date, lbl6: daoDic["date"] as! String, lbl7: "count", lbl8: "手动记账", lbl9: "count", lbl10: "count", lbl11: "name", dbDic: dic))
        }
        self.reloadDataArray()
    }
    
}
/*
 dict["title"] = dao.title
 dict["date"] = dao.date
 dict["location"] = dao.location
 dict["duration"] = dao.duration
 dict["path"] = dao.path
 dict["date"] = dao.date
 dict["daoId"] = dao.daoId
 */
