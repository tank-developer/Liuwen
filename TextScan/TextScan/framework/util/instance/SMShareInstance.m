//
//  SMShareInstance.m
//  SimpleDiary
//
//  Created by Apple on 2022/4/7.
//

#import "SMShareInstance.h"

@interface SMShareInstance()<NSCopying,NSMutableCopying>

@end

@implementation SMShareInstance


static SMShareInstance* single;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.deleteBillArray = [[NSMutableArray alloc] init];
        self.deleteDateBillArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;   //①onceToken = 0;
    dispatch_once(&onceToken, ^{
        NSLog(@"%ld",onceToken);        //②onceToken = 140734731430192
        single = [[SMShareInstance alloc] init];
    });
    NSLog(@"%ld",onceToken);            //③onceToken = -1;
    return single;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [SMShareInstance shareInstance] ;
}
 
-(id) copyWithZone:(NSZone *)zone
{
    return [SMShareInstance shareInstance] ;//return _instance;
}
 
-(id) mutablecopyWithZone:(NSZone *)zone
{
    return [SMShareInstance shareInstance] ;
}

-(void)increase{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *count = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"count"]];
    NSInteger countInt = [count integerValue];
    countInt++;
    
    [userDefault setObject:[NSString stringWithFormat:@"%ld",(long)countInt] forKey:@"count"];
    [userDefault synchronize];
    
    NSLog(@"countInt:%ld",(long)countInt);            //③onceToken = -1;
}

-(NSInteger)getCount{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *count = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"count"]];
    NSInteger countInt = [count integerValue];
    return countInt;
}

-(void)addDeleteBillStatus:(NSMutableDictionary *)dic{
    NSString *ids = [dic objectForKey:@"daoId"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *daoId = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"daoId"]];
    [daoId stringByAppendingString:[NSString stringWithFormat:@"%@,",ids]];
    [userDefault setObject:daoId forKey:@"daoId"];
    [userDefault synchronize];

}
-(NSString *)getDeleteBillArr{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *count = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"daoId"]];
    [userDefault synchronize];
    return count;
}

@end
