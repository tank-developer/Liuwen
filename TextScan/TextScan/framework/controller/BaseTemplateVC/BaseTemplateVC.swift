

import UIKit
import MBProgressHUD

class BaseTemplateVC: BaseVC {
    
    public var currentAction = String()
    public var viewDidApearAction = String()
    public var viewDidApearURL = String()
    public var pamDic = Dictionary<String,Any>()
    public var currentVCAction = String()
    public var viewWillApearURL = String()
    public var elementObjList = Array<Any>()
    
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    
    public func getBaseTemplateService() -> (BaseTemplateService){
        return BaseTemplateService()
    }
    public func getBaseTemplateView() ->(BaseTemplateView){
        return BaseTemplateView()
    }
    public func getVCName() ->(String){
        return String()
    }
    
    public override func initBaseView(baseView: BaseView) {
        self.view.addSubview(baseView)
        self.pamDic = Dictionary<String,Any>()
        if elementObjList.count == 0 {
            elementObjList = Array<Any>()
        }
        checkNetowk()
    }
    
    func addNavtionItemTitleView(title:String) -> Void {
        let lbl = UILabel()
        lbl.text = title
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 15)
        self.navigationItem.titleView = lbl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func addInputBtn() -> (UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var btn = UIButton.init(frame: CGRectMake(SCREEN_WIDTH - (100+20), SCREEN_HEIGHT - 150, 100, 44))
        appDelegate.window?.addSubview(btn)
        btn.frame = CGRectMake(SCREEN_WIDTH - (150+20), SCREEN_HEIGHT - 150, 100, 44)
        btn.backgroundColor = UIColor.green
        btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(inputAction(sender:)), for: UIControl.Event.touchUpInside)
        btn.setTitle("记一笔", for: UIControl.State.normal)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = UIScreen.main.bounds.size.width/375*10
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = UIScreen.main.bounds.size.width/375*7.5
        return btn
    }
    
    @objc func inputAction(sender:UIButton){
        
    }
    func checkNetowk() {
        Reachability.isConnectedToNetwork()
    }
    public class Reachability {
        
        class func isConnectedToNetwork() -> Bool {
            var status:Bool = false
            let url: URL = URL(string: "https://docs.qq.com/doc/DYk1pa2FmSmpoSldC?u=b080bedb4aac4da2a8c75a5ea363f226")!
            //2、创建URLRequest
            let request: URLRequest = URLRequest(url: url)
            //3、创建URLSession
            let configration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configration)
            //4、URLSessionTask子类
            let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        DispatchQueue.main.async {
                        }
                    }catch{
                        
                    }
                }else{
                    status = false
                }
            }
            //5、启动任务
            task.resume()
            return status
        }
    }
    
    
    func showWarnningMBP(title:String) {
        let delegete = UIApplication.shared.delegate as! AppDelegate
        let hud = MBProgressHUD.showAdded(to: delegete.window!, animated: true)
        delegete.window?.addSubview(hud)
        //纯文本模式
        hud.mode = .text
        //设置提示文字
        hud.label.text = title
        hud.hide(animated: true, afterDelay: 2)
    }
    
    
}
