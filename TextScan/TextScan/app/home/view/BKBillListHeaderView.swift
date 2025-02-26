//
//  BKBillListHeaderView.swift
//  CalendarWidget
//
//  Created by Apple on 2023/9/13.
//

import UIKit

class BKBillListHeaderView: UIView {
    // APP颜色
//    #define KAPPCOLOR [UIColor colorWithHexString:@"#87C4ED"]
//    //#define KAPPCOLOR [UIColor colorWithHexString:@"#3CB371"]
    
    lazy var bgImageView: UIImageView = {
        let img = UIImageView()
        self.addSubview(img)
        img.contentMode = UIView.ContentMode.scaleAspectFit
        return img
    }()
    
    lazy var backBtn: UIButton = {
        let back = UIButton()
        self.addSubview(back)
        return back
    }()

    lazy var historyBtn: UIButton = {
        let back = UIButton()
        self.addSubview(back)
        return back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        bgImageView.image = UIImage.init(named: "Witch-cuate")
        self.backgroundColor = CommonUtil.color(hex: itemColor)
        backBtn.isHidden = true
        backBtn.setBackgroundImage(UIImage(named: "left"), for: UIControl.State.normal)
        
        historyBtn.setImage(UIImage.init(named: ""), for: UIControl.State.normal)
        self.backgroundColor = CommonUtil.color(hex: itemColor)
        
        historyBtn.isHidden = true
    }
    
    func refreshLeftBtn(imagename:String) {
        backBtn.isHidden = false
        backBtn.setImage(UIImage(named: imagename), for: UIControl.State.normal)
    }
    func refreshRight(imagename:String) {
        historyBtn.isHidden = false
        historyBtn.setImage(UIImage.init(named: imagename), for: UIControl.State.normal)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backBtn.frame = CGRectMake(10, self.frame.height/2-30/2 + 6, 40, 40)
        historyBtn.frame = CGRectMake(self.frame.width - 50, self.frame.height/2-30/2 + 6, 40, 40)

        let vc = CommonUtil.getVCfromView(views: self) as! UIViewController
        
        let navBarHeight = CommonUtil.getNavigationHeight(vc: vc)
        let statusHeight = CommonUtil.getStatusHeight()
        let height = statusHeight + navBarHeight
        let hei = CommonUtil.kBottomSafeHeight + CommonUtil.kNavigationBarHeight;
        var y:CGFloat = 0
        var heights:CGFloat = 0
        
        if CommonUtil.isFullScreen {
            y = height - 40
            heights = 65
        }else{
            y = 0
            heights = 20
        }
        bgImageView.frame = CGRectMake(0, y, self.frame.width,  self.frame.height - (heights))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- 把#ffffff颜色转为UIColor
    func color(hex:String)->UIColor{
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
}
