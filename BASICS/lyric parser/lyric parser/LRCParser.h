//
//  LRCParser.h
//  lyric parser
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCParser : NSObject {
    NSMutableArray *_items;
    NSString *_title;
    NSString *_artist;
    NSString *_album;
    NSString *_byEditor;
    NSString *_offset; //整体偏移量
}

- (instancetype)initWithFile:(NSString *)file;

- (NSString *)title;
- (NSString *)artist;
- (NSString *)album;
- (NSString *)byEditor;

- (NSString *)wordsByTime:(NSInteger)time; // 根据时间返回对应的歌词

@end
