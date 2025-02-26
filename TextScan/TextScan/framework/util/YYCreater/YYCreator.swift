
import UIKit
//import Kingfisher

class YYCreator: NSObject {
    
    class func createIconCellViewMap(cellName:String,cellIcon:String,cellLabel:String,cellValue:String) -> (Dictionary<String,Any>) {
        var hallMap = Dictionary<String,Any>()
        hallMap["cellIcon"] = cellIcon
        hallMap["cellLabel"] = cellLabel
        hallMap["cellValue"] = cellValue
        return hallMap
    }
    
    class func createIconCellViewMap(cellIcon:String,cellLabel:String,cellValue:String) -> Dictionary<String, Any> {
        var hallMap = Dictionary<String,Any>()
        hallMap["cellIcon"] = cellIcon
        hallMap["cellLabel"] = cellLabel
        hallMap["cellValue"] = cellValue
        return hallMap
    }
    
    class func createIconCellVo(cellName:String,cellIcon:String,cellLabel:String,cellValue:String,dbDic:Dictionary<String, Any>) -> (BaseTableCellVo) {
        let cellVoDic = YYCreator.createIconCellViewMap(cellIcon: cellIcon, cellLabel: cellLabel, cellValue: cellValue)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        return cellVo
    }
    
    class func createCommon3LblCellVo(cellName:String,lbl1:String,lbl2:String,lbl3:String,dbDic:Dictionary<String,Any>) -> BaseTableCellVo {
        let cellVoDic = YYCreator .createCommon3LblCellViewMap(lbl1: lbl1, lbl2: lbl2, lbl3: lbl3)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        return cellVo
    }
    class func createCommon3LblEditCellVo(cellName:String,lbl1:String,lbl2:String,lbl3:String,dbDic:Dictionary<String,Any>) -> BaseTableCellVo {
        let cellVoDic = YYCreator.createCommon3LblCellViewMap(lbl1: lbl1, lbl2: lbl2, lbl3: lbl3)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        cellVo.isEditable = "YES";
        return cellVo
    }
    class func createCommon3LblCellViewMap(lbl1:String,lbl2:String,lbl3:String) -> Dictionary<String,Any> {
        var hallMap = Dictionary<String,Any>()
        hallMap["lbl1"] = lbl1
        hallMap["lbl2"] = lbl2
        hallMap["lbl3"] = lbl3
        return hallMap
    }
    
//    class func setCommon3LblViewMap(homeCell:HomeCell,vo:BaseTableCellVo){
//        homeCell.titleLbl.text = vo.cellDataDic["lbl1"] as? String
//        homeCell.detailLbl.text = vo.cellDataDic["lbl3"] as? String
//        let url = vo.cellDataDic["lbl2"] as! String
////        homeCell.icon.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "flower"), options: nil) { (receviveeSize, totalSize) in}
//    }
    
    class func createCommon11LblCellVo(cellName:String,lbl1:String,lbl2:String,lbl3:String,lbl4:String,lbl5:String,lbl6:String,lbl7:String,lbl8:String,lbl9:String,lbl10:String,lbl11:String,dbDic:Dictionary<String,Any>) -> BaseTableCellVo {
        let cellVoDic = YYCreator .createCommon11LblCellViewMap(lbl1: lbl1, lbl2: lbl2, lbl3: lbl3, lbl4: lbl4, lbl5: lbl5, lbl6: lbl6, lbl7: lbl7, lbl8: lbl8, lbl9: lbl9, lbl10: lbl10, lbl11: lbl11)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        
        return cellVo
    }
    
    class func createCommon11LblCellViewMap(lbl1:String,lbl2:String,lbl3:String,lbl4:String,lbl5:String,lbl6:String,lbl7:String,lbl8:String,lbl9:String,lbl10:String,lbl11:String) -> Dictionary<String,Any> {
        var hallMap = Dictionary<String,Any>()
        hallMap["lbl1"] = lbl1
        hallMap["lbl2"] = lbl2
        hallMap["lbl3"] = lbl3
        hallMap["lbl4"] = lbl4
        hallMap["lbl5"] = lbl5
        hallMap["lbl6"] = lbl6
        hallMap["lbl7"] = lbl7
        hallMap["lbl8"] = lbl8
        hallMap["lbl9"] = lbl9
        hallMap["lbl10"] = lbl10
        hallMap["lbl11"] = lbl11
        
        return hallMap
    }
    
    
    class func createCommon11AnyObjCellVo(cellName:String,lbl1:Any,lbl2:Any,lbl3:Any,lbl4:Any,lbl5:Any,lbl6:Any,lbl7:Any,lbl8:Any,lbl9:Any,lbl10:Any,lbl11:Any,dbDic:Dictionary<String,Any>) -> BaseTableCellVo {
        let cellVoDic = YYCreator .createCommon11AnyObjCellViewMap(lbl1: lbl1, lbl2: lbl2, lbl3: lbl3, lbl4: lbl4, lbl5: lbl5, lbl6: lbl6, lbl7: lbl7, lbl8: lbl8, lbl9: lbl9, lbl10: lbl10, lbl11: lbl11)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        return cellVo
    }
    class func createCommon11AnyObjCellViewMap(lbl1:Any,lbl2:Any,lbl3:Any,lbl4:Any,lbl5:Any,lbl6:Any,lbl7:Any,lbl8:Any,lbl9:Any,lbl10:Any,lbl11:Any) -> Dictionary<String,Any> {
        var hallMap = Dictionary<String,Any>()
        hallMap["lbl1"] = lbl1
        hallMap["lbl2"] = lbl2
        hallMap["lbl3"] = lbl3
        hallMap["lbl4"] = lbl4
        hallMap["lbl5"] = lbl5
        hallMap["lbl6"] = lbl6
        hallMap["lbl7"] = lbl7
        hallMap["lbl8"] = lbl8
        hallMap["lbl9"] = lbl9
        hallMap["lbl10"] = lbl10
        hallMap["lbl11"] = lbl11
        
        return hallMap
    }
    
    
    class func createCommon11LblEditCellVo(cellName:String,lbl1:String,lbl2:String,lbl3:String,lbl4:String,lbl5:String,lbl6:String,lbl7:String,lbl8:String,lbl9:String,lbl10:String,lbl11:String,dbDic:Dictionary<String,Any>) -> BaseTableCellVo {
        let cellVoDic = YYCreator .createCommon11LblCellViewMap(lbl1: lbl1, lbl2: lbl2, lbl3: lbl3, lbl4: lbl4, lbl5: lbl5, lbl6: lbl6, lbl7: lbl7, lbl8: lbl8, lbl9: lbl9, lbl10: lbl10, lbl11: lbl11)
        let cellVo = BaseTableCellVo.init(cellName: cellName, cellDataDic: cellVoDic, dbDic: dbDic)
        cellVo.isEditable = "YES"
        return cellVo
    }
    
}
