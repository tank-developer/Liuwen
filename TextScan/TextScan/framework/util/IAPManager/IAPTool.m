//
//  IAPTool.m
//  CalendarWidget
//
//  Created by Apple on 2023/9/29.
//

#import "IAPTool.h"

//#define kBombs @"IAPDemo.bombs"//10 个炸弹(消耗品)

#define oneYearVip @"com.oneyear.vip"//10 个炸弹(消耗品)

#define lifeVip @"com.vip.life" //雷射子弹 (非消耗品)

@interface IAPTool ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>{
    NSMutableDictionary *_productDict;
}
//@property (nonnull,strong) IAPCompletionHandle handle;

@end

@implementation IAPTool

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _productDict = [NSMutableDictionary dictionary];
//
//        //添加定单状态的监听
//        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//
//        //去服务器查看哪些商品是可卖
//       [self requestProductFormServer];
//    }
//    return self;
//}
//-(void)requestProductFormServer{
//    //去服务器查看哪些商品是可卖
//    NSSet *set = [NSSet setWithObjects:oneYearVip,lifeVip, nil];
//    
//    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
//    
//    
//    request.delegate = self;
//    
//    //开始请求
//    [request start];
//
//}
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
//    
//    //返回可卖的商品
//    NSArray *products = response.products;
//    for (SKProduct *product in products) {
//        NSLog(@"ID%@ price:%@",product.productIdentifier ,product.price);
//        
//        _productDict[product.productIdentifier] = product;
//        
//        if ([product.productIdentifier isEqualToString: oneYearVip]) {
//        }
//        
//        if ([product.productIdentifier isEqualToString: lifeVip]) {
//        }
//    }
//    
//    NSLog(@"%@",_productDict);
//
//    
//}
//
//
//- (void)startPurchWithID:(NSString *)purchID completeHandle:(IAPCompletionHandle)handle{
//    if (purchID) {
//        if ([SKPaymentQueue canMakePayments]) {
//            // 开始购买服务
//            //炮弹商品
//            SKProduct *product = _productDict[oneYearVip];
//            //生成一个雷射子弹的定单
//            SKPayment *payment = [SKPayment paymentWithProduct:product];
//            
//            //付款 (把定单放在一个定单队列)
//            [[SKPaymentQueue defaultQueue] addPayment:payment];
//            //    //添加定单状态的监听
//            //    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//            
//            
//        }else{
//            [self handleActionWithType:kIAPPurchNotArrow data:nil];
//        }
//    }
//    
//}
//#pragma mark - Private Method
//- (void)handleActionWithType:(IAPPurchType)type data:(NSData *)data{
//#if DEBUG
//    switch (type) {
//        case kIAPPurchSuccess:
//            NSLog(@"购买成功");
//            break;
//        case kIAPPurchFailed:
//            NSLog(@"购买失败");
//            break;
//        case kIAPPurchCancle:
//            NSLog(@"用户取消购买");
//            break;
//        case KIAPPurchVerFailed:
//            NSLog(@"订单校验失败");
//            break;
//        case KIAPPurchVerSuccess:
//            NSLog(@"订单校验成功");
//            break;
//        case kIAPPurchNotArrow:
//            NSLog(@"不允许程序内付费");
//            break;
//        default:
//            break;
//    }
//#endif
//    if(self.handle){
//        self.handle(type,data);
//    }
//}
//
//- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
//    
//}



@end
