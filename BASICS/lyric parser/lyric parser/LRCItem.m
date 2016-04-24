//
//  LRCItem.m
//  lyric parser
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LRCItem.h"

@implementation LRCItem 

- (instancetype)initWithTime:(NSInteger)time Lyric:(NSString *)lyric {
    if (self = [super init]) {
        _time = time;
        _lyric = lyric;
    }
    return self;
}

-(NSInteger)time {
    return _time;
}
-(NSString *)lyric {
    return _lyric;
}

-(BOOL)timeCompare:(LRCItem *)item {
    return _time > item.time;
}

@end
