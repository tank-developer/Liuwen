//
//  TSVoiceListDao.m
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

#import "TSVoiceListDao.h"

@implementation TSVoiceListDao

#pragma mark 返回主键信息
+ (NSString *)primaryKey {
    return @"daoId";
}

//// 忽略的成员变量
//+ (NSArray *)ignoreColumnNames {
//    // 不想将学校评分存入数据库
//    return @[@"grade"];
//}

@end
