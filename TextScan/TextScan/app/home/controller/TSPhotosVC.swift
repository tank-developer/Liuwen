//
//  TSPhotosVC.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import Photos
import VisionKit




class TSPhotosVC: BaseTemplateVC ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VNDocumentCameraViewControllerDelegate{
    
    lazy var photosVo:TSPhotosVo = {
        let vo = TSPhotosVo()
        return vo
    }()
    lazy var photosService:TSPhotosService = {
        let service = TSPhotosService()
        return service
    }()
    
    var photosView:TSPhotosView!
    
    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>?
    var imagesResults:NSMutableArray?

    /// 带缓存的图片管理对象
    var imageManager:PHCachingImageManager!
    ///缩略图大小
    var assetGridThumbnailSize:CGSize!
    
    //全局变量
    var screen_width:CGFloat! = UIScreen.main.bounds.size.height
    var screen_height:CGFloat! = UIScreen.main.bounds.size.width
    
    func initFloatyBtn() {
        var btn = UIButton()
        btn.addTarget(self, action: #selector(floatAction(sener:)), for: UIControl.Event.touchUpInside)
        btn.frame = CGRectMake(SCREEN_WIDTH - (70 + 10), SCREEN_HEIGHT - (70 + 90), 70, 70)
        let appledele = UIApplication.shared.delegate as! AppDelegate
        self.photosView.addSubview(btn)
        btn.backgroundColor = CommonUtil.color(hex: itemColor)
        btn.setImage(UIImage.init(named: "viewfinder"), for: UIControl.State.normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        btn.layer.cornerRadius = 35
        btn.layer.masksToBounds = true
    }
    @objc func floatAction(sener:UIButton) {
//        camera()
        popScaneCameraView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        let cellSize = (self.photosView.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        assetGridThumbnailSize = CGSize(width:cellSize.width*scale ,
                                        height:cellSize.height*scale)
    }
    
    override func initBaseView() {
        self.navigationController?.navigationBar.isHidden = true
        
        self.photosView = TSPhotosView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        super.initBaseView(baseView: self.photosView)
        self.photosView.backgroundColor = UIColor.red
        self.view.backgroundColor = UIColor.red
        self.photosView.headerView.setupBackImagename(imagename: "setup")
//        self.photosView.headerView.
        self.photosView.headerView.setupRightImg(img: "history")
        
        self.photosView.headerView.rightBtn.addTarget(self, action: #selector(historyAction(sender:)), for: UIControl.Event.touchUpInside)
        
        let dic = Dictionary<String, Any>()
//        self.requestWithURL(url: urlStr, pamDic: dic, loadingText: "", requestType: Request.POST)
        self.imagesResults = NSMutableArray()
        
        self.photosView.headerView.setupTitleText(title: "Album")
        
        self.photosView.headerView.backBtn.addTarget(self, action: #selector(setupAction(btn:)), for: UIControl.Event.touchUpInside)
      
        
        refreshAlbum()
        

        
        
        //10, 设置delegate
        self.photosView.collectionView.delegate = self
        self.photosView.collectionView.dataSource = self
        
        initFloatyBtn()
        location()
        
    }
    
    func getBaseTableView() -> (BaseView) {
        return self.photosView
    }
    
    override func getVCName() -> (String) {
        return "TSPhotosVC"
    }
    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    //MARK: -
     //MARK: collection datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
     //必选方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.assetsFetchResults?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TSPhotosCell", for: indexPath) as!TSPhotosCell
        let dic = self.assetsFetchResults?[indexPath.row]
        if let asset = self.assetsFetchResults?[indexPath.row] {
            //获取缩略图
            self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                        contentMode: PHImageContentMode.aspectFill,
                        options: nil) { (image, nfo) in
                        cell.img.image = image
                
            }
        }
        return cell
    }
    // 单元格点击响应
    func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let myAsset = self.assetsFetchResults![indexPath.row]
        let size = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT)
        var vc = TSEditImgVC()
//        vc.selectorAsset = myAsset
        
        // 新建一个默认类型的图像管理器imageManager
          let imageOptions = PHImageRequestOptions()
          imageOptions.resizeMode = .none
          // 缩略图的质量为高质量
          imageOptions.deliveryMode = .highQualityFormat

          PHImageManager.default().requestImage(for: myAsset, targetSize: CGSize(width: SCREEN_WIDTH*2, height: SCREEN_HEIGHT*2), contentMode: PHImageContentMode.aspectFill, options: imageOptions, resultHandler: { (image, info) -> Void in
                  if image != nil {
                      vc.selectorImage = image!
//                      vc.modalPresentationStyle = .fullScreen
                      vc.hidesBottomBarWhenPushed = true
                      self.navigationController?.pushViewController(vc, animated: true)
                  }
          })
    }
    
    @objc func historyAction(sender:UIButton) {
        let vc = TSHistoryVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func setupAction(btn:UIButton) {
        let vc = TSSettingVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    func location() {
        LocationManager.shared.requestLocation()
        
    }
    
    
    
    //调用照相机方法
    func camera(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.sourceType = UIImagePickerController.SourceType.camera
        self.present(pick, animated: true, completion: nil)
        
    }
    
    func popScaneCameraView() {
        if #available(iOS 13.0, *) {
            if VNDocumentCameraViewController.isSupported{
                let vc = VNDocumentCameraViewController()
                vc.delegate = self
                self.present(vc, animated: true)
            }
        }else{
            camera()
        }
    }
    func photoLibrary(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(pick, animated: true, completion: nil)
    }
    
    
    //定义两个图片获取方法
    //UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        print(image as Any)
        UIImageWriteToSavedPhotosAlbum(image!,self,#selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    @objc func image(image:UIImage, didFinishSavingWithError error : NSError?, contextInfo : AnyObject) {
        
        if (error != nil) {
            print(error!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //VNDocumentCameraViewControllerDelegate
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for i in 0..<scan.pageCount {
            let img = scan.imageOfPage(at: i)
            UIImageWriteToSavedPhotosAlbum(img,self,#selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        self.dismiss(animated: true) {
            self.refreshAlbum()
        }
    }
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error.localizedDescription)
        
    }
    
    
    func refreshAlbum() {
        //申请权限
        PHPhotoLibrary.requestAuthorization({ (status) in
            if status != .authorized {
                return
            }
            
            //则获取所有资源
            let allPhotosOptions = PHFetchOptions()
            //按照创建时间倒序排列
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                                 ascending: false)]
            //只获取图片
            allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                     PHAssetMediaType.image.rawValue)
            self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                     options: allPhotosOptions)
             
            // 初始化和重置缓存
            self.imageManager = PHCachingImageManager()
            self.resetCachedAssets()
             
            //collection view 重新加载数据
            DispatchQueue.main.async{
                self.photosView.collectionView.reloadData()
            }
        })
    }
}
