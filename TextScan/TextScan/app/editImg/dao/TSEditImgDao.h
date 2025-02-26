//
//  TSEditImgDao.h
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSEditImgDao : NSObject
@property (nonatomic,copy)NSString *daoId;

@property (nonatomic,copy)NSString *path;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *location;
//@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *date;
@end

NS_ASSUME_NONNULL_END
