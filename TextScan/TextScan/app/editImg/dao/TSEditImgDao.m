//
//  TSEditImgDao.m
//  TextScan
//
//  Created by Apple on 2023/11/12.
//

#import "TSEditImgDao.h"

@implementation TSEditImgDao
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
