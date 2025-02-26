
import UIKit

class CommonUtil: NSObject {
    
    class func getArrayCount(inArray:NSMutableArray) -> (NSInteger){
        if inArray == nil || inArray.count == 0 {
            return 0
        }
        let selRow = NSNumber.init(value: inArray.count)
        return selRow.intValue
    }
    
//    class func addDataToNSMutableArray(trgArray:Array<Any>,inArray:Array<Any>) -> (Array<Any>) {
//        var arr = trgArray
//        if arr.isEmpty || inArray.isEmpty {
//            let array = Array<Any>()
//            return array
//        }
//        arr.removeAll()
//        for item in inArray {
//            arr.append(item)
//        }
//        return arr
//    }
    
    
    class func addDataToNSMutableArray(trgArray:NSMutableArray,inArray:NSMutableArray) {
        if trgArray.isKind(of: NSNull.self) || inArray.isKind(of: NSNull.self){
            return
        }
        for idx in 0..<inArray.count {
            trgArray.add(inArray[idx])
        }
    }
    
    
    // MARK:- 把#ffffff颜色转为UIColor
    class func color(hex:String)->UIColor{
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }

        if (cString.count != 6) {
            return UIColor.red
        }

        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)

        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
    class func getCurrentDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: now) // 将 Date 对象转换为字符串
        return dateString
    }
    class func getCurrentTime() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        let dateString = dateFormatter.string(from: now) // 将 Date 对象转换为字符串
        return dateString
    }
    
    class func getYesterdayDate() -> String {
        // 获取当前日期
        let todayDate = Date()
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: todayDate) ?? todayDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: yesterday)
    }
    
    class func getNextYear() -> String {
        // 获取当前日期
        let todayDate = Date()
        let yesterday = Calendar.current.date(byAdding: .year, value: +1, to: todayDate) ?? todayDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: yesterday)
    }
    
//    class func getSomeYearBy(date:Date) -> String {
//        // 获取当前日期
////        let todayDate = Date()
//        let yesterday = Calendar.current.date(byAdding: .year, value: +1, to: todayDate) ?? todayDate
//        let formatter = DateFormatter()
////        formatter.dateFormat = "yyyy-MM-dd"
////        formatter.dateFormat = "YYYY-MM-dd HH:mm"
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        return formatter.string(from: yesterday)
//    }
    
    class func getNextYearByYear(date:Date) -> Date {
        // 获取当前日期
//        let todayDate = Date()
        let yesterday = Calendar.current.date(byAdding: .year, value: +1, to: date) ?? date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let yeseerDayStrin = formatter.string(from: yesterday)
        
        
//        let dateFormatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateNew = formatter.date(from: yeseerDayStrin)
        return dateNew ?? Date()
    }
    
    class func getCurrentYear() -> String {
        let dateString = getCurrentDate()
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString) // 将字符串转换为 Date 对象
        let dateArr = dateString.components(separatedBy: "-") as! Array<String>
        let year = String(format: "%@", dateArr.first!)
        let month = String(Int(dateArr[1]) ?? 0)
        return year
    }
    
    class func getCurrentMonth() -> String {
        let dateString = getCurrentDate()
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString) // 将字符串转换为 Date 对象
        let dateArr = dateString.components(separatedBy: "-") as! Array<String>
        let year = String(format: "%@", dateArr.first!)
        let month = String(Int(dateArr[1]) ?? 0)
        return month
    }
    class func getCurrentDay() -> String {
        let dateString = getCurrentDate()
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString) // 将字符串转换为 Date 对象
        let dateArr = dateString.components(separatedBy: "-") as! Array<String>
//        let year = String(format: "%@", dateArr.first!)
        let day = String(Int(dateArr[2]) ?? 0)
        return day
    }
    //计算当月天数
    class func getCurentMonthDays() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: Date())
        return range!.count
    }
    //计算任意月份天数
    class func daysCount(year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            let isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
            return isLeapYear ? 29 : 28
        default:
            fatalError("非法的月份:\(month)")
        }
    }
    
    class func getIdentifier() -> Int{
        //创建
        let general = SnowflakeSwift(IDCID: 4, machineID: 30)
        //生成唯一ID
        let id = general.nextID()
        let idInt = Int(id ?? 0)
        return idInt
    }
    
    class func getIdentifier2() -> Int {
        //创建
        let general = SnowflakeSwift(IDCID: 5, machineID: 31)
        //生成唯一ID
        let id = general.nextID()
        let idInt = Int(id ?? 0)
        return idInt
    }
    /// 获取当前 毫秒级 时间戳 - 13位
    class func getTime1000Temp() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        let Strmillisecond = String(millisecond)
        return Strmillisecond
    }
    /// 获取当前 秒级 时间戳 - 10位
    class func getTimeTemp() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let Strmillisecond = String(timeStamp)
        return Strmillisecond
    }
    
    //MARK:- 时间戳转成字符串
    class func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let millisecond = CLongLong(round(timeInterval/1000))

        let date:Date = Date.init(timeIntervalSince1970: TimeInterval(millisecond))
          let formatter = DateFormatter.init()
          if dateFormat == nil {
              formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          }else{
              formatter.dateFormat = dateFormat
          }
          return formatter.string(from: date as Date)
      }
    
    
    class func getTabbarHeight(vc:UIViewController) -> CGFloat{
        var tabBarHeight: CGFloat

        if let tabBar = vc.tabBarController?.tabBar {
            tabBarHeight = tabBar.frame.height
        } else {
            tabBarHeight = 0.0  // 或者你可以设定一个默认的高度
        }
        return tabBarHeight
    }
    
    class func getNavigationHeight(vc:UIViewController) -> CGFloat{
        var navigationBarHeight: CGFloat
        if let navigationBar = vc.navigationController?.navigationBar.frame.size.height {
            navigationBarHeight = navigationBar
        } else {
            navigationBarHeight = 0.0  // 或者你可以设定一个默认的高度
        }
        return navigationBarHeight
    }
    
    class func getStatusHeight() -> CGFloat {
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    //根据view获取当前的viewcontroller
    class func getVCfromView(views:UIView) -> UIViewController? {

        for view in sequence(first: views.superview, next: {$0?.superview}){

            if let responder = view?.next{

                if responder.isKind(of: UIViewController.self){

                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    
    
    class func weekdayString(with temp: Double) -> String {
        let millisecond = CLongLong(round(temp/1000))
        let date:Date = Date.init(timeIntervalSince1970: TimeInterval(millisecond))
        
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        let weekday = components.weekday ?? 1 // 默认是星期一，如果 date 是空的话
        let weekArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        let weekStr = weekArray[weekday - 1]
        return weekStr
    }
    
    
    class var isFullScreen: Bool {
        if #available(iOS 11, *) {
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }
              
              if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                  print(unwrapedWindow.safeAreaInsets)
                  return true
              }
        }
        return false
    }
    
    class var kNavigationBarHeight: CGFloat {
       //return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
       return isFullScreen ? 88 : 64
    }
    
    class var kBottomSafeHeight: CGFloat {
       //return UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
       return isFullScreen ? 34 : 0
    }
    
    
    class func getAllFilePath(_ dirPath: String) -> [String]? {
        var filePaths = [String]()
        
        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: dirPath)
            
            for fileName in array {
                var isDir: ObjCBool = true
                
                let fullPath = "\(dirPath)/\(fileName)"
                
                if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if !isDir.boolValue {
                        filePaths.append(fullPath)
                    }
                }
            }
            
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        
        return filePaths;
    }
    
    
}
