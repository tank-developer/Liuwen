

import UIKit
import Alamofire

enum Request {
    case GET
    case POST
    case DOWNLOAD
    case UPLOAD
}

class BaseVC: CoreVC {
    
    public var requestWithURLMsg = String()
    public var requestWithURLDic = Dictionary<String,Any>()
    public var requestWithURLRstCode = String()
    public var errorMsg = NSError()
    public var requestURL = String()
    
    public func initBaseView(baseView:BaseView){
        self.view.addSubview(baseView)
    }
    public func initBaseVo(baseVo:BaseVo){
        var vo = baseVo//转为变量
        vo = BaseVo.init()
    }
    public func initBaseView(){
    }
    public func initBaseVo(){
        
    }
    public func initService(){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBaseVo()
        initBaseView()
        initService()
    }
}

extension BaseVC{
    //默认是post
    public func requestWithURL(url:String,pamDic:Dictionary<String,Any>,loadingText:String,requestType:Request){
        switch requestType {
        case .GET:
            requestGetWithURLWithLoadingText(url: "", pamDic: pamDic, loadingText: "")
            break
        case .POST:
            requestPostWithURLWithLoadingText(url: url, pamDic: pamDic, loadingText: loadingText)
            break
        case .DOWNLOAD:
            requestDownloadWithURLWithLoadingText(url: "", loadingText: "")
            break
        case .UPLOAD:
            requestUploadWithURLWithLoadingText(url: url, loadingText: "")
            break
        }
    }
    /**
     * 上传
     */
    private func requestUploadWithURLWithLoadingText(url:String,loadingText:String) {
        let imgArr:Array = [UIImage.init(named: "headimg"),UIImage.init(named: "headimg")]
        uploadData()
    }
    //下载
    private func requestDownloadWithURLWithLoadingText(url:String,loadingText:String) {
//        let videoUrl = "http://onapp.yahibo.top/public/videos/video.mp4"
        AF.download(url).downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }.responseData { response in
            if let data = response.value {
                _ = UIImage(data: data)
            }
        }
    }
    
    private func requestGetWithURLWithLoadingText(url:String,pamDic:Dictionary<String,Any>,loadingText:String){
        //get
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Accept", value: "application/json")
        ]
        AF.request(url,method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                self.requestWithURLDic = json as! [String : Any]
                self.handleRequestWithURLSuccess(url: url)
                break
            case .failure(let error):
                print("error:\(error)")
                self.errorMsg = error as NSError
                self.handleRequestWithURLFailure(url: url)
                break
            }
        }
    }
    
    private func requestPostWithURLWithLoadingText(url:String,pamDic:Dictionary<String,Any>,loadingText:String){
        //post
        let headers: HTTPHeaders = [
//            HTTPHeader(name: "Authorization", value: "Basic VXNlcm5hbWU6UGFzc3dvcmQ="),
            HTTPHeader(name: "Accept", value: "application/json")
        ]
        AF.request(url,method: .post, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                self.requestWithURLDic = json as! [String : Any]
                self.handleRequestWithURLSuccess(url: url)
                break
            case .failure(let error):
                print("error:\(error)")
                self.errorMsg = error as NSError
                self.handleRequestWithURLFailure(url: url)
                break
            }
        }
    }
    
    //json--->>NSDictionary
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
     
        let jsonData:Data = jsonString.data(using: .utf8)!
     
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    @objc public func handleRequestWithURLProgress(url:String){
        
    }
    @objc public func handleRequestWithURLFailure(url:String){
        
    }
    @objc public func handleRequestWithURLSuccess(url:String){
        
    }
    
    
    
    //------------------------------------------------upload----------------------------------------------------------------------------------------------------
    private func uploadData() -> Void {
        struct HTTPBinResponse: Decodable { let url: String }
        let data = Data("data".utf8)
        AF.upload(data, to: "https://httpbin.org/post").responseDecodable(of: HTTPBinResponse.self) { response in
            debugPrint(response)
        }
    }
    
    private func uploadFile() -> Void {
        struct HTTPBinResponse: Decodable { let url: String }

        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")

        AF.upload(fileURL!, to: "https://httpbin.org/post").responseDecodable(of: HTTPBinResponse.self) { response in
            debugPrint(response)
        }
    }
    
   private func uploadMultipartData() -> Void {
        struct HTTPBinResponse: Decodable { let url: String }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("one".utf8), withName: "one")
            multipartFormData.append(Data("two".utf8), withName: "two")
        }, to: "https://httpbin.org/post")
            .responseDecodable(of: HTTPBinResponse.self) { response in
                debugPrint(response)
        }
    }
}
