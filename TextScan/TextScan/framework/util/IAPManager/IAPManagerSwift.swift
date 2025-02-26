//
//  IAPManagerSwift.swift
//  CalendarWidget
//
//  Created by Apple on 2023/9/30.
//

import UIKit
import SwiftyStoreKit
import StoreKit

class IAPManagerSwift: NSObject ,SKPaymentTransactionObserver{
    
//    let prodictID:String = "com.oneyear.vip"
    let prodictID:String = "com.yearauto.vip"

    
    static let shared = IAPManagerSwift()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {
        
    }
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    typealias HandleProductSuccessBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductSuccessBlock : HandleProductSuccessBlock?;
    
    typealias HandleProductFailureBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductFailureBlock : HandleProductFailureBlock?;
    
    
    //购买
    typealias HandleProductBuySuccessBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductBuySuccessBlock : HandleProductBuySuccessBlock?;
    
    typealias HandleProductBuyFailureBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductBuyFailureBlock : HandleProductBuyFailureBlock?;
    
    
    //恢复购买
    typealias HandleProductResetSuccessBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductResetSuccessBlock : HandleProductResetSuccessBlock?;
    
    typealias HandleProductResetFailureBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductResetFailureBlock : HandleProductResetFailureBlock?;
    
    typealias HandleProductResetNotThingBlock = (_ dic:Dictionary<String, Any>)->Void;
    var handleProductResetNotThingBlock : HandleProductResetNotThingBlock?;
    
    func getList() {
        //获取商品信息
        SwiftyStoreKit.retrieveProductsInfo([prodictID]) { result in
            if let product = result.retrievedProducts.first {
                //返回的retrievedProducts数组Set<SKProduct>
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                    var dic = Dictionary<String,Any>()
                    self.handleProductSuccessBlock!(dic)
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
                    var dic = Dictionary<String,Any>()
                    self.handleProductFailureBlock!(dic)
            }
            else {
                print("Error: \(result.error)")
                var dic = Dictionary<String,Any>()
                self.handleProductFailureBlock!(dic)
            }
        }
//        SKPaymentQueue.default().add(self)
    }
    func buyVipWith(product:SKProduct)  {
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: false) { result in
            switch result {
            case .success(let product):
                //atomically true 表示走服务器获取最后支付结果
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                print("Purchase Success: \(product.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                case .privacyAcknowledgementRequired:
                    print("privacyAcknowledgementRequired")
                    break
                case .unauthorizedRequestData:
                    break
                case .invalidOfferIdentifier:
                    break
                case .invalidSignature:
                    break
                case .missingOfferParams:
                    break
                case .invalidOfferPrice:
                    break
                case .overlayCancelled:
                    break
                case .overlayInvalidConfiguration:
                    break
                case .overlayTimeout:
                    break
                case .ineligibleForOffer:
                    break
                case .unsupportedPlatform:
                    break
                case .overlayPresentedInBackgroundScene:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func buyVipWith(priductID:String) {
        
        if !SwiftyStoreKit.canMakePayments {
            print("您的手机没有打开程序内付费购买")
            return
        }
        
        SwiftyStoreKit.purchaseProduct(priductID) { result in
            //            print("reslut:%@",result)
            switch result {
            case .success(let product):
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
//                            self.handleTransaction(transaction: product.transaction) { result in
//
//                            }
                let downloads = product.transaction.downloads
                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                }
//                print("Purchase Success: \(product.productId)")
//                print("Purchase originalPurchaseDate: \(product.originalPurchaseDate)")
                let dateStamp:TimeInterval = product.originalPurchaseDate.timeIntervalSince1970
                let dateStr:Int = Int(dateStamp)
                var dic = Dictionary<String,Any>()
                dic["originalPurchaseDate"] = product.originalPurchaseDate
                self.handleProductBuySuccessBlock!(dic)
//                self.handleProductBuyFailureBlock!(dic)
                //移除监听
//                SKPaymentQueue.default().remove(self)
                
                self.verifyReceipt()
            case .error(let error):
                switch error.code {
                case .unknown:
                    print("Unknown error. Please contact support")
                    var dic = Dictionary<String,Any>()

                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .clientInvalid:
                    print("Not allowed to make the payment")
                    var dic = Dictionary<String,Any>()

                    self.handleProductBuyFailureBlock!(dic)

                    break
                case .paymentCancelled:
                    break
                case .paymentInvalid:
                    print("The purchase identifier was invalid")
                    var dic = Dictionary<String,Any>()

                    self.handleProductBuyFailureBlock!(dic)

                    break
                case .paymentNotAllowed:
                    print("The device is not allowed to make the payment")
                    var dic = Dictionary<String,Any>()

                    self.handleProductBuyFailureBlock!(dic)

                    break
                case .storeProductNotAvailable:
                    print("The product is not available in the current storefront")
                    var dic = Dictionary<String,Any>()

                    self.handleProductBuyFailureBlock!(dic)

                    break
                case .cloudServicePermissionDenied:
                    print("Access to cloud service information is not allowed")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)

                    break
                case .cloudServiceNetworkConnectionFailed:
                    print("Could not connect to the network")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .cloudServiceRevoked:
                    print("User has revoked permission to use this cloud service")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .privacyAcknowledgementRequired:
                    print("privacyAcknowledgementRequired")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .unauthorizedRequestData:
                    print("unauthorizedRequestData")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .invalidOfferIdentifier:
                    print("invalidOfferIdentifier")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .invalidSignature:
                    print("invalidSignature")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .missingOfferParams:
                    print("missingOfferParams")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .invalidOfferPrice:
                    print("invalidOfferPrice")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .overlayCancelled:
                    print("overlayCancelled")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .overlayInvalidConfiguration:
                    print("overlayInvalidConfiguration")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .overlayTimeout:
                    print("overlayTimeout")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .ineligibleForOffer:
                    print("ineligibleForOffer")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .unsupportedPlatform:
                    print("unsupportedPlatform")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                case .overlayPresentedInBackgroundScene:
                    print("overlayPresentedInBackgroundScene")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                @unknown default:
                    print("@unknown")
                    var dic = Dictionary<String,Any>()
                    self.handleProductBuyFailureBlock!(dic)
                    break
                }
            }
        }
    }
    
    func verifyReceipt() {
        // 本地验证（SwiftyStoreKit 已经写好的类） AppleReceiptValidator
        // .production 苹果验证  .sandbox 本地验证
        let receipt = AppleReceiptValidator(service: .production)
        SwiftyStoreKit.verifyReceipt(using: receipt) { result in
//            print("result==:%@",result)
        }
    }
    
    //2.处理交易
    func handleTransaction(transaction:PaymentTransaction,completeHandle:@escaping ((Bool) -> Void)) {
        //获取receipt
        SwiftyStoreKit.fetchReceipt(forceRefresh:false) { result in
            
            switch result {
                
            case .success(let receiptData):
                
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                
//                print("获取校验字符串Fetch receipt success:\n\(encryptedReceipt)")
                
                SwiftyStoreKit.finishTransaction(transaction)
                completeHandle(true)
            case .error(let error):
                print(" --- Fetch receipt failed: \(error)")
                completeHandle(false)
            }
            
        }
        
    }
    //恢复内购
    func restorePurchases2() {
        SwiftyStoreKit.restorePurchases { result in
            let faile = result.restoreFailedPurchases
            print("reslut:%@",result)
            //失败
            if let product = result.restoreFailedPurchases.first {
                print("restoreFailedPurchases")
                var dic = Dictionary<String,Any>()
                self.handleProductResetFailureBlock!(dic)
            }
            print(result.restoredPurchases.count)
            //成功
            if let product = result.restoredPurchases.first {
                for purchase in result.restoredPurchases {
                    self.handleTransaction(transaction:purchase.transaction) { res in

                    }
                }
                var dic = Dictionary<String,Any>()
                dic["date"] = product.originalPurchaseDate
                self.handleProductResetSuccessBlock!(dic)
            }else{
                print("Nothing to Restore")
                var dic = Dictionary<String,Any>()
                self.handleProductResetNotThingBlock!(dic)
            }
        }
    }
    
    
    /*
     https://juejin.cn/post/7204751926515400759
     恢复购买
     非消耗型 和 自动续期订阅 需要提供恢复购买的功能，例如创建一个恢复按钮，不然审核很可能会被拒绝。

     消耗型项目 和 非续期订阅 苹果不会提供恢复的接口，不要调用上述方法去恢复，否则也可能被拒。
     */
    //恢复购买
    func restorePurchases() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    //返回数据后，回调
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("did receive answer from server") // this never gets fired
        for transaction in transactions {
            
               switch transaction.transactionState {

               case SKPaymentTransactionState.purchased:
                   print("Transaction completed successfully.")
                   SKPaymentQueue.default().finishTransaction(transaction)
                   
               case SKPaymentTransactionState.failed:
                   print("Transaction Failed");
                   SKPaymentQueue.default().finishTransaction(transaction)
                   let dic = Dictionary<String,Any>()
                   self.handleProductBuyFailureBlock!(dic)
               case SKPaymentTransactionState.restored:
                   
                   let prodID = transaction.payment.productIdentifier as String
                   print(prodID)
                   if prodID == prodictID {
                       print("Purchase restored")
                       let date = transaction.transactionDate
                       var dic = Dictionary<String,Any>()
                       dic["date"] = date
                       self.handleProductResetSuccessBlock!(dic)
                       SKPaymentQueue.default().finishTransaction(transaction)
                       SKPaymentQueue.default().remove(self)
                       
                   } else {
                       print("Puchase restaured but no compatible products were found")
                   }
               default:
                   print(transaction.transactionState.rawValue)
               }
           }
    }
    
    //恢复完成后回调
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("paymentQueueRestoreCompletedTransactionsFinished")
        print(queue)
        //2023-09-30 06:32:37 +0000
//        if queue.transactions.count > 0{
//            print("恢复成功")
//            let skpTransaction = queue.transactions.first!
//            let date = skpTransaction.transactionDate
//            var dic = Dictionary<String,Any>()
//            dic["date"] = date
//            self.handleProductResetSuccessBlock!(dic)
//        }else{
//            print("请购买会员")
//            let dic = Dictionary<String,Any>()
//            self.handleProductResetNotThingBlock!(dic)
//        }
    }
    //如果点击“取消”，调用方法
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoreCompletedTransactionsFailedWithError")
        let dic = Dictionary<String,Any>()
        self.handleProductResetFailureBlock!(dic)
    }
}
