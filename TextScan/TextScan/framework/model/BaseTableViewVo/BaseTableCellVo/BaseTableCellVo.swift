

import UIKit

class BaseTableCellVo: BaseVo {
    
    public var cellDataDic:Dictionary<String,Any> = Dictionary<String,Any>()
    public var dbDic:Dictionary<String,Any> = Dictionary<String,Any>()
    public var cellName:String = String()
    public var cellAction:String = String()
    public var cellKey:String = String()
    public var isEditable:String = String()
    
    init(cellName:String,cellDataDic:Dictionary<String,Any>,dbDic:Dictionary<String,Any>) {
        
        self.cellDataDic = cellDataDic
        self.cellName = cellName
        
        if dbDic.isEmpty {
            self.dbDic = Dictionary<String,Any>()
        }else{
            self.dbDic = dbDic
        }
    }
    
    
}
