//
//  TSTextDetailVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/19.
//

import UIKit

class TSTextDetailVC: BaseTemplateVC {

    lazy var textDetailVo: TSTextDetailVo = {
        let vo = TSTextDetailVo()
        return vo
    }()
    
    var editImgVo:TSEditImgVo!
    
    var textDetailView:TSTextDetailView!
    
    var textDic:Dictionary<String,String>!
    
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        self.textDetailView = TSTextDetailView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseView: self.textDetailView)
        self.textDetailView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        self.textDetailView.headerView.setupBackImagename(imagename: "left")
        self.textDetailView.headerView.setupTitleText(title: "Detail")
        self.textDetailView.headerView.backBtn.addTarget(self, action: #selector(backAction(sender:)), for: UIControl.Event.touchUpInside)
        self.textDetailView.textview.text = textDic["title"]
        self.textDetailView.headerView.setupOutputBtnImg(img: "copy")
//        self.textDetailView.headerView.setupRightImg(img: "inspection")
        self.textDetailView.headerView.outputBtn.addTarget(self, action: #selector(outputAction(sender:)), for: UIControl.Event.touchUpInside)
//        self.textDetailView.headerView.rightBtn.addTarget(self, action: #selector(checkAction(sender:)), for: UIControl.Event.touchUpInside)
        
//        self.textDetailView.bottomView.bImage.image = selectorImage
//        self.textDetailView.downBottomView()
//        self.textDetailView.bottomView.cancelBtn.addTarget(self, action: #selector(cancelAction(button:)), for: UIControl.Event.touchUpInside)
        
    }
    
    func getBaseTableView() -> (BaseView) {
        return self.textDetailView
    }
    
    override func getVCName() -> (String) {
        return "TSTextDetailVC"
    }
    
    @objc func backAction(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func outputAction(sender:UIButton){
        
        UIPasteboard.general.string = self.textDetailView.textview.text
        SVProgressHUD.showSuccess(withStatus: "Successfully copied")
    }

}
