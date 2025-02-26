

import UIKit

class BaseTableViewVo: BaseTemplateVo {
    
    public var cellVoArray = NSMutableArray()
    public var dataArray:NSMutableArray = NSMutableArray()

//    override init() {
//        super.init()
//        if self.dataArray == nil {
//            self.dataArray = Array<Any>()
//        }
//    }
    
    
    func initIconCellDataArray(cellName:String,cellIcon:String,cellLabel:String,cellValue:String) -> () {
        if dataArray == nil {
            dataArray = NSMutableArray()
        }
        let dbDic = Dictionary<String,Any>()
        let cellVo = YYCreator.createIconCellVo(cellName: cellName, cellIcon: cellIcon, cellLabel: cellLabel, cellValue: cellValue, dbDic: dbDic)
//        self.dataArray.append(cellVo)
        self.dataArray.add(cellVo)
        
    }
    
}


