//
//  ShowHelper.swift
//  TextScan
//
//  Created by Apple on 2023/11/10.
//

import UIKit

//放大图片的时间
private let showBigDuration = 0.6
//缩放图片的时间
private let showOriginalDuration = 0.6

class ShowHelper: NSObject {
    /// 图片imageView的原始frame
     private static var originalFrame = CGRect()
      private override init() {
          super.init()
      }
    
    
}

extension ShowHelper {
//类方法
    class func show(imageView: UIImageView) {
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showBigImage(sender:)))
        imageView.addGestureRecognizer(tap)
    }
   
    //private私有方法。。。
   @objc private class func showBigImage(sender: UITapGestureRecognizer) {
//swift里面我不喜欢用强制解析(!)----套用一句话----你每用一个！，就会杀死一只猫
//同时也为了去掉金字塔类型的判断。。。我用guard / guard let来代替if/ if let
    guard let imageV = sender.view as? UIImageView else {
        fatalError("it is not UIImageView")
    }
    guard let image = imageV.image else {
        return
    }
    guard let window = UIApplication.shared.delegate?.window else {
        return
    }
//originalFrame重新归零
    originalFrame = CGRect()
       let oldFrame = imageV.convert(imageV.bounds, to: window)
    let backgroundView = UIView(frame: UIScreen.main.bounds)
       backgroundView.backgroundColor = UIColor.black
    backgroundView.alpha = 0.0
//赋值originalFrame
    originalFrame = oldFrame
    let newImageV = UIImageView(frame: oldFrame)
    newImageV.contentMode = .scaleAspectFit
    newImageV.image = image
    backgroundView.addSubview(newImageV)
    window?.addSubview(backgroundView)
    
       UIView.animate(withDuration: showBigDuration) {
        let width = UIScreen.main.bounds.size.width
        let height = image.size.height * width / image.size.width
        let y = (UIScreen.main.bounds.size.height - image.size.height * width / image.size.width) * 0.5
        newImageV.frame = CGRectMake(0, y, width, height)
        backgroundView.alpha = 1
    }
    let tap2 = UITapGestureRecognizer(target: self, action: #selector(ShowHelper.showOriginal(sender:)))
    backgroundView.addGestureRecognizer(tap2)
    }
    //private私有方法。。。
    @objc private class func showOriginal(sender: UITapGestureRecognizer) {
        guard let backgroundView = sender.view else {
            return
        }
        guard let imageV = backgroundView.subviews.first else {
            return
        }
//大图的frame变为原来的frame，backgroundView的透明度为0，同时backgroundView从父视图移除
        UIView.animate(withDuration: showOriginalDuration, animations: {
            imageV.frame = originalFrame
            backgroundView.alpha = 0.0
            }) { finished in
                backgroundView.removeFromSuperview()
        }
    }
}

