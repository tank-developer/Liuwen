//
//  ViewController.swift
//  TextScan
//
//  Created by Apple on 2023/11/9.
//

import UIKit
import Vision


class ViewController: UIViewController {

    var resultingText = ""
    var requests = Array<VNRecognizeTextRequest>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fo()
    }
    
    func aaa(){
//        var vc = DBCropImageController()
//        vc.lineColor = UIColor.white
//        vc.isShowShaw = true
//        vc.lineWidth = 2
//        vc.isFixCropArea = false
//        vc.image = UIImage.init(named: "test")!
//        vc.clippedBlock = {(clippedImage:UIImage) in
//
//        }
//        vc.cancelClipBlock = {
//
//        }
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    }
    func sss() {
        // 扫描框
//        let cardIOView:CardIOView = CardIOView.init()
//        cardIOView.languageOrLocale = "zh-Hans"
//        //cardIOView.scanOverlayView.isHidden = true
//        cardIOView.guideColor = UIColor.red
//        cardIOView.hideCardIOLogo = true
//        cardIOView.delegate = self
//        self.view.addSubview(cardIOView)
//        cardIOView.frame = self.view.bounds
    }
//    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
//        if (cardInfo != nil) {
//            // The full card number is available as info.cardNumber, but don't log that!
//            print(cardInfo.cardNumber as Any)
//
//        }else {
//            print("User cancelled payment info")
//        }
//
//        cardIOView.removeFromSuperview()
//    }
    
    
    
    
    func fo() {
        
        do{
            let supportLanguageArray = try VNRecognizeTextRequest.supportedRecognitionLanguages(for: .accurate, revision: VNRecognizeTextRequestRevision1)
              print(supportLanguageArray)
        }catch{
            
        }
        let textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            // 把识别的文字全部连成一个string
            let maximumCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                self.resultingText += candidate.string + "\n"
                print(self.resultingText)

            }
        }
        textRecognitionRequest.recognitionLanguages = ["zh-Hans"]
        
        textRecognitionRequest.recognitionLevel = .accurate
        self.requests = [textRecognitionRequest]
            
        let image = UIImage(named: "test2")
      
        if let cgImage = image?.cgImage {
             let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
             
             do {
                 try requestHandler.perform(self.requests)
             } catch {
                 print(error)
             }
        }
    }
}

