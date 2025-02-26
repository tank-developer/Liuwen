//
//  TSVoiceListDao.h
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

#import <Foundation/Foundation.h>
#import "CWModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSVoiceListDao : NSObject
@property (nonatomic,copy)NSString *daoId;

@property (nonatomic,copy)NSString *path;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *location;
@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *date;


@end

NS_ASSUME_NONNULL_END
