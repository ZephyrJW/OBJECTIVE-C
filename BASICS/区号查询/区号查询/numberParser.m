//
//  numberParser.m
//  区号查询
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "numberParser.h"
#import "numberItem.h"


@implementation numberParser {
    NSMutableArray *_numbers;
}

- (instancetype)initWithFile:(NSString *)file {
    if (self = [super init]) {
        _numbers = [[NSMutableArray alloc]init];
        [self analyzeNumbers:file];
    }
    return self;
}

- (void)analyzeNumbers:(NSString *)file {
//    NSString *info = [[NSString alloc]initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSString *info = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [info componentsSeparatedByString:@"\n"];
    
    for (NSString *string in array) {
        NSArray *subArray = [string componentsSeparatedByString:@" "];
        if ([subArray count] < 2) {
            continue;
        }
        
        numberItem *item = [[numberItem alloc]initWithRegion:subArray[0] Number:subArray[1]];
        [_numbers addObject:item];
    }
}

-(NSString *)numberForRegion:(NSString *)region {
    NSString *res = nil;
    for (numberItem *item in _numbers) {
        NSLog(@"%@, %@", item.region, item.number);
        NSRange range = [item.region rangeOfString:region];
        if (range.location != NSNotFound) {
            res = item.number;
            break;
        }
    }
    return res;
}

-(NSString *)regionForNumber:(NSString *)number {
    NSString *res = nil;
    for (numberItem *item in _numbers) {
        if ([number isEqualToString:item.number]) {
            res = item.region;
            break;
        }
    }
    return res;
}


@end
