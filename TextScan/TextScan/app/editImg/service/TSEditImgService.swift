//
//  TSEditImgService.swift
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

import UIKit

class TSEditImgService: BaseTemplateService {

    
    func insert(dic:Dictionary<String,String>,daoId:String) -> Void {
        let date = dic["date"]
        let path = dic["path"]
        let daoId = daoId
        let title = dic["title"]
        let location = dic["location"]
        let duration = dic["duration"]
        
        let dao = TSEditImgDao()
        dao.date = date!
        dao.path = path!
        dao.daoId = daoId
        dao.title = title!
        dao.location = location!
        DaoUtil.shareInstance().insert(to: dao)
    }
    
    func queryAll() -> Array<Dictionary<String,String>> {
        let arr = DaoUtil.shareInstance().queryAllEditImgDao()
        var pArray = Array<Dictionary<String,String>>.init()
        for (index,obj) in arr.enumerated(){
            var dao = obj as! TSEditImgDao
            var dict: Dictionary<String, String> = [:]
            dict["title"] = dao.title
            dict["date"] = dao.date
            dict["location"] = dao.location
            dict["path"] = dao.path
            dict["daoId"] = dao.daoId
            
            pArray.append(dict)
        }
        return pArray
    }
    
    
    func deleteEditImg(dic:Dictionary<String,Any>) -> Bool {
        var dao = TSEditImgDao()
        dao.title = dic["title"] as! String
        dao.path = dic["path"] as! String
        dao.daoId = dic["daoId"] as! String
        var result = DaoUtil.shareInstance().deleteEditImg(byDic: dao)
        return result
    }
    
}
