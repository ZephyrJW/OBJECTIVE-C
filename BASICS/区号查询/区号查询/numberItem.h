//
//  numberItem.h
//  区号查询
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface numberItem : NSObject 



-(instancetype)initWithRegion:(NSString *)region Number:(NSString *)number;

-(NSString *)region;
-(NSString *)number;

@end
