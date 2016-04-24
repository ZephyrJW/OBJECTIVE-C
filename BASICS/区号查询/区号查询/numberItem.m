//
//  numberItem.m
//  区号查询
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "numberItem.h"

@implementation numberItem{
    NSString *_region;
    NSString *_number;
}



-(instancetype)initWithRegion:(NSString *)region Number:(NSString *)number {
    if (self = [super init]) {
        _region = region;
        _number = number;
    }
    return self;
}

- (NSString *)region {
    return _region;
}

- (NSString *)number {
    return _number;
}


@end
