//
//  IAPTool.h
//  CalendarWidget
//
//  Created by Apple on 2023/9/29.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef enum {
//    kIAPPurchSuccess = 0,       // 购买成功
//    kIAPPurchFailed = 1,        // 购买失败
//    kIAPPurchCancle = 2,        // 取消购买
//    KIAPPurchVerFailed = 3,     // 订单校验失败
//    KIAPPurchVerSuccess = 4,    // 订单校验成功
//    kIAPPurchNotArrow = 5,      // 不允许内购
//}IAPPurchType;
//
//typedef void (^IAPCompletionHandle)(IAPPurchType type,NSData *data);


@interface IAPTool : NSObject
//- (void)startPurchWithID:(NSString *)purchID completeHandle:(IAPCompletionHandle)handle;

@end

NS_ASSUME_NONNULL_END
