//
//  WSPayManager.swift
//  CalendarWidget
//
//  Created by Apple on 2023/11/7.
//

import UIKit
import StoreKit

class WSPayManager: NSObject , SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    static var `default`:WSPayManager = WSPayManager()
    private var proId:String!
    
    //沙盒验证地址
    let url_receipt_sandbox = "https://sandbox.itunes.apple.com/verifyReceipt"
    //生产环境验证地址
    let url_receipt_itunes = "https://buy.itunes.apple.com/verifyReceipt"
    
    //21008表示生产换使用  21007表示测试环境使用
    var state = 21008
    var resultBlock:(_ result:String)->Void = { (_ result:String)->Void in
        print("交易结果：", result)
    }
    
    func doPay() {
        if SKPaymentQueue.canMakePayments() == false {
            return
        }
        
        SKPaymentQueue.default().add(self)
        self.proId = "com.oneyear.vip"
        let set = Set<String>.init([self.proId])
        
        let request = SKProductsRequest.init(productIdentifiers: set)
        request.delegate = self
        request.start()
    }
    
    //MARK:购买成功验证凭证
    func completePay(transaction:SKPaymentTransaction) {
        print(transaction)
        //获取交易凭证
        let recepitUrl = Bundle.main.appStoreReceiptURL
        let data = try! Data.init(contentsOf: recepitUrl!)
        if recepitUrl == nil {
            self.resultBlock("交易凭证为空")
            print("交易凭证为空")
            return
        }

        //客户端验证
        verify(data: data,transaction: transaction)

        //注销交易
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    // SKProductsRequestDelegate
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let productArray = response.products
        if productArray.count == 0 {
            print("此商品id没有对应的商品")
            return
        }
        var product:SKProduct!
        for pro in productArray {
            if pro.productIdentifier == proId {
                product = pro
                break
            }
        }
        print(product.description)
        print(product.localizedTitle)
        print(product.localizedDescription)
        print(product.price)
        print(product.productIdentifier)
        let payment = SKMutablePayment.init(product: product)
        payment.quantity = 1
        SKPaymentQueue.default().add(payment)
    }
    
    //MARK:客户端验证
    func verify(data:Data,transaction:SKPaymentTransaction)  {
        let base64Str = data.base64EncodedString(options: .endLineWithLineFeed)
        let params = NSMutableDictionary()
        params["receipt-data"] = base64Str
        let body = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        var request = URLRequest.init(url: URL.init(string: state == 21008 ? url_receipt_itunes : url_receipt_sandbox)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        request.httpMethod = "POST"
        request.httpBody = body
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            let dict = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
            print(dict)
            SKPaymentQueue.default().finishTransaction(transaction)
            let status = dict["status"] as! Int
            switch(status){
            case 0:
                self.resultBlock("购买成功")
                break
            case 21007:
                self.state = 21007
                self.verify(data: data!, transaction: transaction)
                break
            default:
                self.resultBlock("验证失败")
                break
            }
            //移除监听
            SKPaymentQueue.default().remove(self)
        }
        task.resume()
    }
    
    // MARK: SKPaymentTransactionObserver
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for tran in transactions {
            switch tran.transactionState {
            case .purchased://购买完成
                SKPaymentQueue.default().finishTransaction(tran)
                completePay(transaction: tran)
                break
            case.purchasing://商品添加进列表
                break
            case.restored://已经购买过该商品
                SKPaymentQueue.default().finishTransaction(tran)
                break
            case.failed://购买失败
                SKPaymentQueue.default().finishTransaction(tran)
                break
            default:
                break
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
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("paymentQueueRestoreCompletedTransactionsFinished")
        print(queue)
        //2023-09-30 06:32:37 +0000
        if queue.transactions.count > 0{
            print("恢复成功")
            let skpTransaction = queue.transactions.first!
            let date = skpTransaction.transactionDate
            var dic = Dictionary<String,Any>()
            dic["date"] = date
//            self.handleProductResetSuccessBlock!(dic)
        }else{
            print("请购买会员")
            let dic = Dictionary<String,Any>()
//            self.handleProductResetNotThingBlock!(dic)
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoreCompletedTransactionsFailedWithError")
        let dic = Dictionary<String,Any>()
//        self.handleProductResetFailureBlock!(dic)
    }
    
    
}

let WSPayManagerInstance = WSPayManager.default
