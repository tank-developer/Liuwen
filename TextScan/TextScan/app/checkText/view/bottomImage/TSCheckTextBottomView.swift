//
//  TSCheckTextBottomView.swift
//  TextScan
//
//  Created by Apple on 2023/11/13.
//

import UIKit

class TSCheckTextBottomView: UIView ,UIScrollViewDelegate{
    
    
    let maxScale: CGFloat = 3.0 // 最大缩放倍数

    let minScale: CGFloat = 0.5 // 最小倍数

    let scaleDuration = 0.38 // 缩放动画时间

    var lastScale: CGFloat = 1.0 // 最后一次的缩放比例

    var tapOffset: CGPoint? // 双击放大偏移的 point
    
    lazy var cancelBtn: UIButton = {
        let scr = UIButton()
        scr.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.addSubview(scr)
        return scr
    }()
    
    lazy var scrollView: UIScrollView = {
        let scr = UIScrollView()
        self.addSubview(scr)
        scr.delegate = self
        scr.minimumZoomScale = 0.5
        scr.maximumZoomScale = 10
        scr.contentMode = .scaleAspectFit

        return scr
    }()
    
    lazy var bImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit

        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cancelBtn.setTitle("X", for: UIControl.State.normal)
        
        scrollView.backgroundColor = UIColor.white
        bImage.backgroundColor = UIColor.clear
        
//        bImage.image = UIImage.init(named: "")
        
        scrollView.addSubview(bImage)
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(tap:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.frame = CGRectMake(10, 0, 44, 44)
        scrollView.frame = CGRectMake(0, cancelBtn.frame.height + cancelBtn.frame.origin.y, SCREEN_WIDTH, self.frame.height - 44)
        bImage.frame = scrollView.bounds
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bImage
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var frame = self.bImage.frame
        frame.origin.y = (scrollView.frame.size.height - bImage.frame.size.height) > 0 ? (scrollView.frame.size.height - bImage.frame.size.height) * 0.5 : 0
        
        frame.origin.x = (scrollView.frame.size.width - bImage.frame.size.width) > 0 ? (scrollView.frame.size.width - bImage.frame.size.width) * 0.5 : 0
        scrollView.contentSize = CGSize.init(width: bImage.frame.size.width + 30, height: bImage.frame.size.height + 30)
        

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

            bImage.transform = CGAffineTransform.init(scaleX: lastScale, y: lastScale)

            let imageW = bImage.frame.size.width
            let imageH = bImage.frame.size.height

            if lastScale > 1 {

                // 内边距是针对 scrollView 捏合缩放，图片居中设置的边距
                scrollView.contentInset = UIEdgeInsets.zero // 内边距清空

                // 修改中心点
                bImage.center = CGPoint.init(x: imageW / 2, y: imageH / 2)
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

            let imgViewSize = bImage.frame.size
            let scrollViewSize = scrollView.bounds.size

            // 垂直内边距
            let paddingV = imgViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imgViewSize.height) / 2 : 0

            // 水平内边距
            let paddingH = imgViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imgViewSize.width) / 2 : 0

            scrollView.contentInset = UIEdgeInsets.init(top: paddingV, left: paddingH, bottom: paddingV, right: 0)
            bImage.center = CGPoint.init(x: imgViewSize.width / 2, y: imgViewSize.height / 2)

        }
    /** 计算双击放大偏移量 */
        fileprivate func calculateOffset(tapPoint: CGPoint) {

            let viewSize = self.bounds.size
            let imgViewSize = bImage.bounds.size

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
