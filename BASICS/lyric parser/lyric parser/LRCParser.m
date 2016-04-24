//
//  LRCParser.m
//  lyric parser
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LRCParser.h"
#import "LRCItem.h"

@implementation LRCParser

-(instancetype)initWithFile:(NSString *)file {
    if (self = [super init]) {
        //一定要先init
        _items = [[NSMutableArray alloc]init];
        [self analyzeLRC:file];
    }
    return self;
}

- (void) analyzeLRC:(NSString *)file {
    NSString *lrc = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [lrc componentsSeparatedByString:@"\n"];
    
    for (NSString *string in array) {
        if ([string length] == 0) continue;
        
        NSRange range = [string rangeOfString:@"ti:"];
        if (range.location != NSNotFound) {
            _title = [self contentsByString:string];
            continue;
        }
        
        range = [string rangeOfString:@"al:"];
        if (range.location != NSNotFound) {
            _album = [self contentsByString:string];
            continue;
        }
        
        range = [string rangeOfString:@"ar:"];
        if (range.location != NSNotFound) {
            _artist = [self contentsByString:string];
            continue;
        }
        
        range = [string rangeOfString:@"by:"];
        if (range.location != NSNotFound) {
            _byEditor = [self contentsByString:string];
            continue;
        }
        
        range = [string rangeOfString:@"offset:"];
        if (range.location != NSNotFound) {
            _offset = [self contentsByString:string];
            continue;
        }
        // 进入歌词部分
        
        NSArray *tmp = [string componentsSeparatedByString:@"]"];
        NSString *words = [tmp lastObject];
        for (NSInteger i = 0 ; i< [tmp count]-1; i++) {
            NSArray *subArray = [tmp[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[:."]];
            NSInteger time = [subArray[[subArray count]-1] integerValue] + [subArray[[subArray count]-2] integerValue]*1000 + [subArray[[subArray count]-3] integerValue]*60000 ;
            
            LRCItem *item = [[LRCItem alloc]initWithTime:time Lyric:words];
            [_items addObject:item];
        }
        
    }
    [_items sortUsingSelector:@selector(timeCompare:)];
    for (LRCItem *item in _items) {
        NSLog(@"%ld, %@", item.time, item.lyric);
    }
}

- (NSString *)contentsByString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":]" ]];
    return array[[array count]-2];
}

//_items里已经装好词条了


- (NSString *)wordsByTime:(NSInteger)time {
    NSString *words = nil;
    for (NSInteger i = 0; i < [_items count]; i++) {
        //LRCItem *item = _items[i];
        if (time < [_items[i] time]) {
            if (i == 0) {
                words = [_items[0] lyric];
            } else {
                words = [_items[i-1] lyric];
            }
            break;
        }
    }
    
    if (words == nil) {
        words = [[_items lastObject] lyric];
    }
    
    return words;
}

-(NSString *)title {
    return _title;
}
-(NSString *)artist {
    return _artist;
}
-(NSString *)album {
    return _album;
}
-(NSString *)byEditor {
    return _byEditor;
}

@end
