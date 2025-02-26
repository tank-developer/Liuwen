//
//  SingletonClass.swift
//  CalendarWidget
//
//  Created by Apple on 2023/9/16.
//

import UIKit

class SingletonClass: NSObject {
    
    static let shared = SingletonClass()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    // Optional
    func reset() {
        // Reset all properties to default value
    }
    
    func increase() -> Void {
        var userDef = UserDefaults.standard
        var count = userDef.object(forKey: "count")
        if let c = count{
            count = count as! Int + 1
        }else{
            count = 1
        }
        
        userDef.setValue(count, forKey: "count")
        userDef.synchronize()
        print(count)
    }
    
    func getCount() -> Int {
        var userDef = UserDefaults.standard
        var count = userDef.value(forKey: "count")
        if let c = count{
            return count as! Int
        }
        return 0
    }
    
    
    
    
    func saveLastSyncTime() {
        let timeTemp = CommonUtil.getTime1000Temp()
        let def = UserDefaults.standard
        def.setValue(timeTemp, forKey: "timeTemp")
        def.synchronize()
    }
    func queryLastSyncTime() -> String {
        let def = UserDefaults.standard
        var timeTemp = String()
        if let time = def.object(forKey: "timeTemp"){
            timeTemp = time as! String
        }else{
            timeTemp = "0"
        }
        def.synchronize()
        return timeTemp
    }
    
    func saveLastSyncTime2() {
        let timeTemp = CommonUtil.getTime1000Temp()
        let def = UserDefaults.standard
        def.setValue(timeTemp, forKey: "timeTemp2")
        def.synchronize()
    }
    func queryLastSyncTime2() -> String {
        let def = UserDefaults.standard
        var timeTemp = String()
        if let time = def.object(forKey: "timeTemp2"){
            timeTemp = time as! String
        }else{
            timeTemp = "0"
        }
        def.synchronize()
        return timeTemp
    }
    
    
    
    func addDeleteBillStatus(dic:Dictionary<String,String>) {
        var idStr = ""
        if let ids = dic["daoId"]{
            idStr = ids
        }
        let def = UserDefaults.standard
        var daoId = ""
        if let billId = def.object(forKey: "billId"){
            var biid = billId as! String
            daoId.append(biid)
            daoId.append(",")
        }else{
            daoId = ""
        }
        daoId.append(idStr)
        def.set(daoId, forKey: "billId")
        def.synchronize()
    }
    func getDeleteBillArr() -> String {
        let def = UserDefaults.standard
        var daoId = ""
        if let billId = def.object(forKey: "billId"){
            daoId = billId as! String
        }else{
            daoId = ""
        }
//        let daoId = String(format: "%@", arguments: def.object(forKey: "billId") as! [any CVarArg])
        return daoId
    }
    
    
    func removeBillArr() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "billId")
        def.synchronize()
    }
    
    func addDeleteDateBillStatus(dic:Dictionary<String,String>) {
        var idStr = ""
        if let ids = dic["daoId"]{
            idStr = ids
        }
        let def = UserDefaults.standard
        var daoId = ""
        if let billId = def.object(forKey: "dateBillId"){
//            daoId = billId as! String
            var biid = billId as! String
            daoId.append(biid)
            daoId.append(",")
            
        }else{
            daoId = ""
        }
        daoId.append(idStr)
        def.set(daoId, forKey: "dateBillId")
        def.synchronize()
    }
    func getDeleteDateBillArr() -> String {
        let def = UserDefaults.standard
        var daoId = ""
        if let dateBillId = def.object(forKey: "dateBillId"){
            daoId = dateBillId as! String
        }else{
            daoId = ""
        }
        return daoId
    }
    func removeDateBillArr() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "dateBillId")
        def.synchronize()
    }
    
    //存储VIP的状态
    func saveVip() {
        let def = UserDefaults.standard
        def.setValue("vip", forKey: "vip")
        def.synchronize()
    }
    //取出VIP的状态
    func getVip() -> String{
        let def = UserDefaults.standard
        var vipp = ""
        if let vip = def.object(forKey: "vip"){
            vipp = vip as! String
        }
        def.synchronize()
        return vipp
    }
    
    //存储VIP的当前时间戳
    func saveVipTemp() {
        let date2 = CommonUtil.getNextYear()
        let date = String(format: "%@ 00:00:00", date2)
        let dateForm = self.stringConvertDate(string: date)
        let dateStamp:TimeInterval = dateForm.timeIntervalSince1970
        let dateInt:Int = Int(dateStamp)
        let dateString = String(dateInt)
        let def = UserDefaults.standard
        def.setValue(dateString, forKey: "vipTemp")
        def.synchronize()
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    //取出购买成功的时间戳
    func getVipTemp() -> String {
        let def = UserDefaults.standard
        var vipp = ""
        if let vip = def.object(forKey: "vipTemp"){
            vipp = vip as! String
        }
        def.synchronize()
        return vipp
    }
    
    //恢复购买成功存储时间戳
    func saveResetVipTempByDate(date:Date) {
        let nextYearDate = CommonUtil.getNextYearByYear(date: date)
        let dateStamp:TimeInterval = nextYearDate.timeIntervalSince1970
        let dateInt:Int = Int(dateStamp)
        let dateString = String(dateInt)

        let def = UserDefaults.standard//1696055557
        def.setValue(dateString, forKey: "vipTemp")
        def.synchronize()
    }
    
    //取出恢复购买成功的时间戳
    func getResetVipTemp() -> String {
        let def = UserDefaults.standard
        var vipp = ""
        if let vip = def.object(forKey: "vipTemp"){
            vipp = vip as! String
        }
        def.synchronize()
        return vipp
    }
    
    func saveColor(color:String)  {
        let def = UserDefaults.standard
        def.setValue(color, forKey: "color")
        def.synchronize()
    }
    
    func getColor() -> String{
        let def = UserDefaults.standard
        var vipp = itemColor
        if let vip = def.object(forKey: "color"){
            vipp = vip as! String
        }
        def.synchronize()
        return vipp
    }
    func savePopPrivateAlertView(status:String)  {
        let def = UserDefaults.standard
        def.setValue(status, forKey: "private")
        def.synchronize()
    }
    
    func getPopPrivateAlertView() -> String{
        let def = UserDefaults.standard
        var vipp = ""
        if let vip = def.object(forKey: "private"){
            vipp = vip as! String
        }
        def.synchronize()
        return vipp
    }
    
    
}
