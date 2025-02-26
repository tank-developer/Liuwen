//
//  DaoUtil.h
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

#import <Foundation/Foundation.h>
#import "TSVoiceListDao.h"
#import "CWSqliteModelTool.h"
#import "TSEditImgDao.h"

NS_ASSUME_NONNULL_BEGIN

@interface DaoUtil : NSObject
+(instancetype)shareInstance;
-(BOOL)insertToDb:(TSVoiceListDao *)dao;
-(BOOL)insertToEditImgDao:(TSEditImgDao *)dao;

-(BOOL )deleteVoiceItemByDic:(TSVoiceListDao *)dao;


-(NSArray *)queryAll;
-(NSArray *)queryAllEditImgDao;
-(BOOL )deleteEditImgByDic:(TSEditImgDao *)dao;

@end

NS_ASSUME_NONNULL_END
