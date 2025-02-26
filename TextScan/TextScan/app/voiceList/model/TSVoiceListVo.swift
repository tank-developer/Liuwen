//
//  TSVoiceListVo.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

class TSVoiceListVo: BaseTableViewVo {
    
    var voiceListService:TSVoiceListService!
    public var videoCellVoArray = NSMutableArray()

    override init() {
        super.init()
    }
    
    func initByDic(dic:Dictionary<String,Any>) -> Self! {
        self.voiceListService = TSVoiceListService()
        self.cellVoArray = self.voiceListService.getInfoArray(dic: dic)
        self.videoCellVoArray = self.voiceListService.getVideoList()
        
        self.reloadDataArray()
        return self
    }
    
    func reloadDataArray() -> () {
        let totalCount = CommonUtil.getArrayCount(inArray: self.cellVoArray) + CommonUtil.getArrayCount(inArray: self.videoCellVoArray)
        self.dataArray.removeAllObjects()
        self.dataArray = NSMutableArray.init(capacity: totalCount)
        CommonUtil.addDataToNSMutableArray(trgArray: self.dataArray, inArray: self.cellVoArray)
        CommonUtil.addDataToNSMutableArray(trgArray: self.dataArray, inArray: self.videoCellVoArray)
    }
    
    func insertVoiceDao(dic:Dictionary<String,String>,daoid:Int) {
        
        let billIdentifierNSNumber = daoid as NSNumber
        let billIdentifierString : String = billIdentifierNSNumber.stringValue
        
        voiceListService.insert(dic: dic, daoId: billIdentifierString)
    }
    
    func dateStrToTimeInterval(dateStr: String) -> Int  {
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
          let date = dateformatter.date(from: dateStr)
          let dateTimeInterval:TimeInterval = date!.timeIntervalSince1970
          return Int(dateTimeInterval)
    }
    
    func refreshCellVo(videoArr:Array<Dictionary<String,String>>) {
        self.videoCellVoArray.removeAllObjects()
        let TSVoiceListCell = "TSVoiceListCell"
        let dbDic = Dictionary<String, Any>()
        let newVideoArr = videoArr.sorted { dic0, dic1 in
            let date0 = dic0["date"] as! String
            let date1 = dic1["date"] as! String
            let timeTem0 = self.dateStrToTimeInterval(dateStr: date0)
            let timeTem1 = self.dateStrToTimeInterval(dateStr: date1)
            
            return timeTem0 > timeTem1
        }
        for (index,obj) in newVideoArr.enumerated(){
            var dic = obj
            let path = dic["path"] as! String
            let title = dic["title"] as! String
            let duration = dic["duration"] as! String
            let location = dic["location"] as! String
            let date = dic["date"] as! String
            
            videoCellVoArray.add(YYCreator.createCommon11LblCellVo(cellName: TSVoiceListCell, lbl1: path, lbl2: title, lbl3: duration, lbl4: location, lbl5: date, lbl6: "count", lbl7: "count", lbl8: "手动记账", lbl9: "count", lbl10: "count", lbl11: "name", dbDic: dic))
        }
        self.reloadDataArray()
    }
    
    
    func queryAll() -> Array<Dictionary<String,String>> {
        let arr = voiceListService.queryAll()
        return arr
    }
    
    
}
