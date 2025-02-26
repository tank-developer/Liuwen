
import UIKit

class BaseTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setChildViewController(TSPhotosVC(), title: "Album", imageName: "album")
        setChildViewController(TSVoiceListVC(), title: "Voice", imageName: "acoustic")
//        setChildViewController(TSSettingVC(), title: "设置", imageName: "avatar")
        
//        var i = 0
//              for family: String in UIFont.familyNames {
//                  print("\(i)---项目字体---\(family)")
//                  for names: String in UIFont.fontNames(forFamilyName: family) {
//                      print("== \(names)")
//                  }
//                  i += 1
//              }
        
    }
    
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        let navHomeVC = UINavigationController.init(rootViewController:childController)

        //设置 tabbar 文字和图片
        childController.title = title
        
//        childController.tabBarItem.image = UIImage(named: imageName + "nor")
//        childController.tabBarItem.selectedImage = UIImage(named: imageName + "pressed")
        
        var homeNomalImge = UIImage.init(named: imageName)

        var homeSelectImge = UIImage.init(named: imageName)
        
        homeSelectImge = homeSelectImge?.withRenderingMode(.alwaysOriginal)//解决UITabBarItem选中图片默认为蓝色的方法
        childController.tabBarItem.image = UIImage.init(named: imageName)
        childController.tabBarItem.selectedImage = homeSelectImge
        //添加导航控制器为 childController 的子控制器
        self.addChild(navHomeVC)
        
//        let colors = SingletonClass.shared.getColor()
        
        let normalColor = UIColor.darkGray
        let selectColor = UIColor.black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: textFont15 as Any, NSAttributedString.Key.foregroundColor:normalColor], for: UIControl.State.normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: textFont15 as Any, NSAttributedString.Key.foregroundColor:selectColor], for: UIControl.State.selected)

        
        UITabBar.appearance().barTintColor = CommonUtil.color(hex: bgViewColor)
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor.white
        
        
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        let attributes = [
            NSAttributedString.Key.font : textFont15,
            NSAttributedString.Key.foregroundColor : UIColor.white,
                                  ]
        let selectAttributes = [
            NSAttributedString.Key.font : textFont15,
            NSAttributedString.Key.foregroundColor : UIColor.white,]
    }
}
