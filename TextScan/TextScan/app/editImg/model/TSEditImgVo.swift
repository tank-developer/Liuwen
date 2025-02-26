//
//  TSEditImgVo.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSEditImgVo: BaseTemplateVo {
    
    var editImgService:TSEditImgService!
    
    override init() {
        super.init()
        editImgService = TSEditImgService()
        
    }
    
    func insertDB(Dic:Dictionary<String,String> , daoId:Int) {
        let billIdentifierNSNumber = daoId as NSNumber
        let billIdentifierString : String = billIdentifierNSNumber.stringValue
        editImgService.insert(dic: Dic, daoId: billIdentifierString)
    }
    
    func queryFromDB() -> Array<Dictionary<String,String>>{
        let array = editImgService.queryAll()
        return array
    }
    
    
    func deleteEditImgBy(dic:Dictionary<String,Any>) -> Bool{
        let result = editImgService.deleteEditImg(dic: dic)
        return result
    }
    
}
