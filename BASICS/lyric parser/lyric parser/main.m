//
//  main.m
//  lyric parser
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRCParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LRCParser *parser = [[LRCParser alloc]initWithFile:@"/Users/mac/Desktop/课件/day19/歌词LRC文件/春天里.lrc"];
        
        NSLog(@">>>>%@",[parser wordsByTime:10]);
        NSLog(@">>>>%@",[parser wordsByTime:-99999]);
        NSLog(@">>>>%@",[parser wordsByTime:87655]);

    }
    return 0;
}
