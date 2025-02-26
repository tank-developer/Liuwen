//
//  TSEditImgLanguageAlertView.swift
//  TextScan
//
//  Created by Apple on 2023/11/22.
//

import UIKit

class TSEditImgLanguageAlertView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    
    lazy var languageArray: Array<Dictionary<String,String>> = {
        let arr = Array<Dictionary<String,String>>()
        return arr
    }()
    
    typealias CancelBlock = (_ dic:Dictionary<String, Any>)->Void;
    var cancelBlock : CancelBlock?;
    
    typealias ComfirmBlock = (_ dic:Dictionary<String, Any>)->Void;
    var comfirmBlock : ComfirmBlock?;
    
    typealias CheckBlock = (_ dic:Dictionary<String, Any>)->Void;
    var checkBlock : CheckBlock?;
    
    var selectDic:Dictionary<String,String>!
    
    lazy var cancelBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        lbl.setTitle("Cancel", for: UIControl.State.normal)
        return lbl
    }()
    lazy var comfirmBtn: UIButton = {
        let lbl = UIButton()
        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
//        lbl.setTitle("✓", for: UIControl.State.normal)
        lbl.setTitle("Comfirm", for: UIControl.State.normal)
        return lbl
    }()
    lazy var checkBtn: UIButton = {
        let lbl = UIButton()
//        self.addSubview(lbl)
        lbl.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lbl.titleLabel?.font = textFont17
        lbl.setTitle("Check", for: UIControl.State.normal)
        return lbl
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .grouped)
        table.backgroundColor = UIColor.white;
        self.addSubview(table)

        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cancelBtn.addTarget(self, action: #selector(cancelAction(sender:)), for: UIControl.Event.touchUpInside)
        comfirmBtn.addTarget(self, action: #selector(comfirmAction(sender:)), for: UIControl.Event.touchUpInside)
//        checkBtn.addTarget(self, action: #selector(checkAction(sender:)), for: UIControl.Event.touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //supports English, Chinese, Portuguese, French, Italian, German and Spanish
        
        var dic0 = Dictionary<String,String>()
        dic0["lan"] = "English"
        dic0["code"] = "en-US"
        
        var dic1 = Dictionary<String,String>()
        dic1["lan"] = "Chinese"
        dic1["code"] = "zh-Hans"
        
        var dic2 = Dictionary<String,String>()
        dic2["lan"] = "Japanese"
        dic2["code"] = "ja-JP"
        
        var dic3 = Dictionary<String,String>()
        dic3["lan"] = "Portuguese"
        dic3["code"] = "pt_PT"
        
        var dic4 = Dictionary<String,String>()
        dic4["lan"] = "French"
        dic4["code"] = "fr_FR"
        
        var dic5 = Dictionary<String,String>()
        dic5["lan"] = "Italian"
        dic5["code"] = "it_IT"
        
        var dic6 = Dictionary<String,String>()
        dic6["lan"] = "German"
        dic6["code"] = "de_DE"
        
        var dic7 = Dictionary<String,String>()
        dic7["lan"] = "Spanish"
        dic7["code"] = "es_ES"
        
        languageArray.append(dic0)
        languageArray.append(dic1)
        languageArray.append(dic2)
        languageArray.append(dic3)
        languageArray.append(dic4)
        languageArray.append(dic5)
        languageArray.append(dic6)
        languageArray.append(dic7)
        
        selectDic = Dictionary<String,String>()
        selectDic["lan"] = "Chinese"
        selectDic["code"] = "zh-Hans"
    }
    
    func refreshTextView(text:String) {
//        textView.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.frame = CGRectMake(10, 10, 64, 54)
        comfirmBtn.frame = CGRectMake(SCREEN_WIDTH - (80 + 5), 10, 80, 54)
        tableView.frame = CGRectMake(0, cancelBtn.frame.height + cancelBtn.frame.origin.y, SCREEN_WIDTH, 400)
        checkBtn.frame = CGRectMake(SCREEN_WIDTH/2-54/2, tableView.frame.height + tableView.frame.origin.y, 54, 54)
        
    }
    @objc func cancelAction(sender:UIButton) {
        let dic = Dictionary<String, Any>()
        self.cancelBlock?(dic);
    }
    @objc func comfirmAction(sender:UIButton) {
        self.comfirmBlock?(selectDic);
    }
    @objc func checkAction(sender:UIButton) {
        var dic = Dictionary<String, Any>()
//        dic["title"] = textView.text
//        self.checkBlock?(dic);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UITableViewDataSource
    // cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageArray.count
    }
    //supports English, Chinese, Portuguese, French, Italian, German and Spanish
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "TSEditImgLanguageCell"
        tableView.register(TSEditImgLanguageCell.self, forCellReuseIdentifier: cellid)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid) as? TSEditImgLanguageCell
        if cell == nil {
            cell = TSEditImgLanguageCell(style: .subtitle, reuseIdentifier: cellid)
        }
        let item = self.languageArray[indexPath.row]
        cell?.title.text = item["lan"]
        return cell!
    }
  
    //MARK: UITableViewDelegate
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDic = self.languageArray[indexPath.row]
    }
    
}
