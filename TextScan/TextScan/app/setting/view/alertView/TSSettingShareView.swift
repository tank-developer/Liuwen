//
//  TSSettingShareView.swift
//  TextScan
//
//  Created by Apple on 2023/11/18.
//

import UIKit

class TSSettingShareView: UIView {
    
    
    typealias CancelBlock = (_ dic:Dictionary<String, Any>)->Void;
    var cancelBlock : CancelBlock?;
    
    typealias ShareBlock = (_ dic:Dictionary<String, Any>)->Void;
    var shareBlock : ShareBlock?;
    
    lazy var shareView: UIView = {
        let share = UIView()
        self.addSubview(share)
        return share
    }()
    
    lazy var image: UIImageView = {
        let share = UIImageView()
        share.image = UIImage.init(named: "pumpkin")
        return share
    }()
    
    lazy var appLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage.init(named: "AppIcon")
        logo.layer.cornerRadius = 10
        logo.layer.borderColor = UIColor.lightGray.cgColor
        logo.layer.borderWidth = 0.5
        
        logo.layer.masksToBounds = true
        return logo
    }()
    lazy var appTitle: UILabel = {
        let title = UILabel()
        let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
        title.text = appName
        title.font = textFont17
        title.textColor = UIColor.black
        return title
    }()
    lazy var appDescrble: UILabel = {
        let title = UILabel()
        title.text = "Simple and efficient"
        title.font = textFont13
        title.textColor = UIColor.black

        return title
    }()
    lazy var appQRcode: UIImageView = {
        let title = UIImageView()
        title.image = UIImage.init(named: "downloadUrl")
//        title.layer.cornerRadius = 10
//        title.layer.borderColor = UIColor.lightGray.cgColor
//        title.layer.borderWidth = 0.5
        return title
    }()
    lazy var cancelBtn:UIButton = {
        let alert = UIButton()
        alert.setTitle("✕", for: UIControl.State.normal)
        alert.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.addSubview(alert)
        alert.titleLabel?.font = textFont18
        return alert
    }()
    lazy var shareBtn:UIButton = {
        let alert = UIButton()
        alert.setTitle("Share", for: UIControl.State.normal)
        alert.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.addSubview(alert)
        alert.titleLabel?.font = textFont18
        return alert
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cancelBtn.addTarget(self, action: #selector(cancelAction(sender:)), for: UIControl.Event.touchUpInside)
        shareBtn.addTarget(self, action: #selector(shareAction(sender:)), for: UIControl.Event.touchUpInside)
        
        shareView.backgroundColor = UIColor.white
        image.backgroundColor = UIColor.white
        
        appLogo.backgroundColor = UIColor.white
        appTitle.backgroundColor = UIColor.white
        appDescrble.backgroundColor = UIColor.white
        
        appQRcode.backgroundColor = UIColor.white
        
        shareView.addSubview(image)
        shareView.addSubview(appLogo)
        shareView.addSubview(appTitle)
        shareView.addSubview(appDescrble)
        shareView.addSubview(appQRcode)
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cancelBtn.frame = CGRectMake(10, 10, 44, 44)
        shareBtn.frame = CGRectMake(self.frame.width - 74, 10, 64, 44)
        
        shareView.frame = CGRectMake(SCREEN_WIDTH/2-300/2, shareBtn.frame.height + shareBtn.frame.origin.y, 300, 400)
        image.frame = CGRectMake(0, 0, 300, 300)
        
        appLogo.frame = CGRectMake(10, image.frame.height + image.frame.origin.y + 20, 50, 50)
        appTitle.frame = CGRectMake(appLogo.frame.width + appLogo.frame.origin.x + 10, image.frame.height + image.frame.origin.y + 20, 100, 25)
        appDescrble.frame = CGRectMake(appLogo.frame.width + appLogo.frame.origin.x + 10, appTitle.frame.height + appTitle.frame.origin.y + 0, 150, 25)
        
        appQRcode.frame = CGRectMake(shareView.frame.width - (50 + 10), appLogo.frame.origin.y + 0, 50, 50)
    }
    
    @objc func shareAction(sender:UIButton){
        /// 整个窗口截屏
//        let image = UIApplication.shared.keyWindow!.asImage()
        /// 某一个单独View截图
        let image = self.shareView.asImage()
        
        /// 将转换后的UIImage保存到相机胶卷中
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        var dic = Dictionary<String, Any>()
        dic["img"] = image
        self.shareBlock?(dic);

        
    }
    @objc func cancelAction(sender:UIButton){
        let dic = Dictionary<String, Any>()
        self.cancelBlock?(dic);
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//extension UIView {
//    //将当前视图转为UIImage
//    func asImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
//}
