//
//  DaoUtil.m
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

#import "DaoUtil.h"

@interface DaoUtil()<NSCopying,NSMutableCopying>

@end

@implementation DaoUtil

static DaoUtil* _instance = nil;
 
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    }) ;
    return _instance ;
}
+(id) allocWithZone:(struct _NSZone *)zone
{
    return [DaoUtil shareInstance] ;
}
 
-(id) copyWithZone:(NSZone *)zone
{
    return [DaoUtil shareInstance] ;//return _instance;
}
 
-(id) mutablecopyWithZone:(NSZone *)zone
{
    return [DaoUtil shareInstance] ;
}
-(BOOL)insertToDb:(TSVoiceListDao *)dao{
    BOOL result = [CWSqliteModelTool insertOrUpdateModel:dao];
    return result;
}
-(NSArray *)queryAll{
    NSArray *result = [CWSqliteModelTool queryAllModels:[TSVoiceListDao class]];
    return result;
}
-(BOOL )deleteVoiceItemByDic:(TSVoiceListDao *)dao{
    BOOL result = [CWSqliteModelTool deleteModel:dao];
    return result;
}



-(BOOL)insertToEditImgDao:(TSEditImgDao *)dao{
    BOOL result = [CWSqliteModelTool insertOrUpdateModel:dao];
    return result;
}
-(NSArray *)queryAllEditImgDao{
    NSArray *result = [CWSqliteModelTool queryAllModels:[TSEditImgDao class]];
    return result;
}
-(BOOL )deleteEditImgByDic:(TSEditImgDao *)dao{
    BOOL result = [CWSqliteModelTool deleteModel:dao];
    return result;
}



@end
