//
//  MMKVUtil.swift
//  CalendarWidget
//
//  Created by Apple on 2023/9/22.
//

import UIKit

class MMKVUtil: NSObject {
    static let shared = MMKVUtil()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    func setupLocation(ele:String) {
        let def = UserDefaults.standard
        def.set(ele, forKey: "location")
        def.synchronize()
    }
    func getlocation() -> String{
        let def = UserDefaults.standard
//        let ele = def.object(forKey: "day") as? String
        var ele = ""
        if let e = def.object(forKey: "location"){
            ele = e as! String
        }else{
            print("def.object(forKey: day)=== nil")
        }
        def.synchronize()
        
        return ele
    }
    
    func setupPathEle(ele:String) {
        let def = UserDefaults.standard
        def.set(ele, forKey: "path")
        def.synchronize()
    }
    func getPathEle() -> String{
        let def = UserDefaults.standard
//        let ele = def.object(forKey: "day") as? String
        var ele = ""
        if let e = def.object(forKey: "path"){
            ele = e as! String
        }else{
            print("def.object(forKey: day)=== nil")
        }
        def.synchronize()
        
        return ele
        
    }
    
    func removePathEle(){
        let def = UserDefaults.standard
        def.removeObject(forKey: "path")
        def.synchronize()
    }
    
    func setupMonthEle(ele:String) {
        let def = UserDefaults.standard
        def.set(ele, forKey: "month")
        def.synchronize()
    }
    func getMonthEle() -> String{
        let def = UserDefaults.standard
//        let ele = def.object(forKey: "month") as! String
        var ele = ""
        if let e = def.object(forKey: "month"){
            ele = e as! String
        }else{
            print("def.object(forKey: month)=== nil")
        }
        def.synchronize()
        return ele 
    }
    
    func removeMonthEle(){
        let def = UserDefaults.standard
        def.removeObject(forKey: "month")
        def.synchronize()
    }
    
}
