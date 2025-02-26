//
//  TSEditImgView.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import WebKit
import Photos

class TSEditImgView: BaseTemplateView ,UIScrollViewDelegate{
    
    
    let maxScale: CGFloat = 3.0 // 最大缩放倍数

    let minScale: CGFloat = 0.5 // 最小倍数

    let scaleDuration = 0.38 // 缩放动画时间

    var lastScale: CGFloat = 1.0 // 最后一次的缩放比例

    var tapOffset: CGPoint? // 双击放大偏移的 point
    
    
    
    
    var editView:LyEditImageView!
    
    lazy var headerView:BKSettingHeaderView = {
        let title = BKSettingHeaderView()
        self.addSubview(title)
        return title
    }()
    
    lazy var scrollView: UIScrollView = {
        let scr = UIScrollView()
        self.addSubview(scr)
        scr.delegate = self
        scr.minimumZoomScale = 0.5
        scr.maximumZoomScale = 10
        
        return scr
    }()
    
    //scaleAspectFit
    lazy var bgImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
//        scrollView.addSubview(img)
        return img
    }()
    
    lazy var scanBtn: UIButton = {
        let btn = UIButton.init()
        self.addSubview(btn)
        btn.setImage(UIImage.init(named: "scan"), for: UIControl.State.normal)
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    lazy var inputBtn: UIButton = {
        let btn = UIButton.init()
//        self.addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.backgroundColor = UIColor.white
        
        bgImg.backgroundColor = UIColor.clear
        scrollView.addSubview(bgImg)
        scanBtn.backgroundColor =  CommonUtil.color(hex: itemColor)
        inputBtn.backgroundColor = UIColor.white
        
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(tap:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        
    }
    func refreImg(img:UIImage) {
        
    }
    
    func getImg() -> UIImage {
        let croppedImage = editView.getCroppedImage()
        return croppedImage
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let vc = CommonUtil.getVCfromView(views: self) as! UIViewController
        let barHeight = CommonUtil.getNavigationHeight(vc: vc)
        let statusHeight = CommonUtil.getStatusHeight()
        let height = statusHeight + barHeight
        
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height)
        scrollView.frame = CGRectMake(0, headerView.frame.height + headerView.frame.origin.y + 10, SCREEN_WIDTH, 400)
        bgImg.frame = scrollView.bounds
        scanBtn.frame = CGRectMake(self.frame.width/2-50/2, scrollView.frame.height+scrollView.frame.origin.y + 20, 50, 50)
//        inputBtn.frame = CGRectMake(scanBtn.frame.width + scanBtn.frame.origin.x + 20, bgImg.frame.height+bgImg.frame.origin.y + 20, 50, 50)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bgImg
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var frame = self.bgImg.frame
        frame.origin.y = (scrollView.frame.size.height - bgImg.frame.size.height) > 0 ? (scrollView.frame.size.height - bgImg.frame.size.height) * 0.5 : 0
        
        frame.origin.x = (scrollView.frame.size.width - bgImg.frame.size.width) > 0 ? (scrollView.frame.size.width - bgImg.frame.size.width) * 0.5 : 0
        scrollView.contentSize = CGSize.init(width: bgImg.frame.size.width + 30, height: bgImg.frame.size.height + 30)
        

    }
    
    /** 单击复原 */
        @objc func singleTap(tap: UITapGestureRecognizer) {
            UIView.animate(withDuration: scaleDuration) {
                self.setZoom(scale: 1.0)
            }
        }

        /** 双击放大 */
        @objc func doubleTap(tap: UITapGestureRecognizer) {
            // 获取点击的位置
            let point = tap.location(in: self)
            // 根据点击的位置计算偏移量
            calculateOffset(tapPoint: point)

            if lastScale > 1 {
                lastScale = 1
            } else {
                lastScale = maxScale
                // 单击手势放在这里
                let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(singleTap(tap:)))
                addGestureRecognizer(singleTap)
            }
            UIView.animate(withDuration: scaleDuration) {
                self.setZoom(scale: self.lastScale)
            }
        }
    
    /** 设置缩放比例 */
        fileprivate func setZoom(scale: CGFloat) {

            // 缩放比例限制（在最大最小中间）
            lastScale = max(min(scale, maxScale), minScale)

            bgImg.transform = CGAffineTransform.init(scaleX: lastScale, y: lastScale)

            let imageW = bgImg.frame.size.width
            let imageH = bgImg.frame.size.height

            if lastScale > 1 {

                // 内边距是针对 scrollView 捏合缩放，图片居中设置的边距
                scrollView.contentInset = UIEdgeInsets.zero // 内边距清空

                // 修改中心点
                bgImg.center = CGPoint.init(x: imageW / 2, y: imageH / 2)
                scrollView.contentSize = CGSize.init(width: imageW, height: imageH)

                if let offset = tapOffset {
                    scrollView.contentOffset = offset
                }
            } else {
                calculateInset()
                scrollView.contentSize = CGSize.zero
            }
        }
    /** 计算内边距 */
        fileprivate func calculateInset() {

            let imgViewSize = bgImg.frame.size
            let scrollViewSize = scrollView.bounds.size

            // 垂直内边距
            let paddingV = imgViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imgViewSize.height) / 2 : 0

            // 水平内边距
            let paddingH = imgViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imgViewSize.width) / 2 : 0

            scrollView.contentInset = UIEdgeInsets.init(top: paddingV, left: paddingH, bottom: paddingV, right: 0)
            bgImg.center = CGPoint.init(x: imgViewSize.width / 2, y: imgViewSize.height / 2)

        }
    /** 计算双击放大偏移量 */
        fileprivate func calculateOffset(tapPoint: CGPoint) {

            let viewSize = self.bounds.size
            let imgViewSize = bgImg.bounds.size

            // 计算最大偏移 x y
            let maxOffsetX = imgViewSize.width * maxScale - viewSize.width
            let maxOffsetY = imgViewSize.height * maxScale - viewSize.height

            var tapX: CGFloat = tapPoint.x
            var tapY: CGFloat = tapPoint.y

            if imgViewSize.width == viewSize.width {
                // 将 tap superview 的 point 转换 tap 到 imageView 上的距离
                tapY = tapPoint.y - (viewSize.height - imgViewSize.height) / 2
            } else {
                tapX = tapPoint.x - (viewSize.width - imgViewSize.width) / 2
            }

            // 计算偏移量
            let offsetX = (tapX * maxScale - (self.superview?.center.x)!)
            let offsetY = (tapY * maxScale - (self.superview?.center.y)!)

            // 判断偏移量是否超出限制（0, maxOffset）
            let x = min(max(offsetX, 0), maxOffsetX)
            let y = min(max(offsetY, 0), maxOffsetY)
            tapOffset = CGPoint.init(x: x, y: y)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
