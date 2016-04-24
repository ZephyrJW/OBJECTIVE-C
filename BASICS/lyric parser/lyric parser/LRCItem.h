//
//  LRCItem.h
//  lyric parser
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCItem : NSObject {
    NSInteger _time;  // 毫秒 ms
    NSString *_lyric;
}

- (instancetype)initWithTime:(NSInteger)time Lyric:(NSString *)lyric;

- (NSInteger)time;
- (NSString *)lyric;

- (BOOL)timeCompare:(LRCItem *)item;

@end
