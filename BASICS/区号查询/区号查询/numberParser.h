//
//  numberParser.h
//  区号查询
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface numberParser : NSObject 

- (instancetype)initWithFile:(NSString *)file;

-(NSString *)numberForRegion:(NSString *)region;

-(NSString *)regionForNumber:(NSString *)number;

@end
