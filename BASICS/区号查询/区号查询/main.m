//
//  main.m
//  区号查询
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "numberParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        numberParser *p = [[numberParser alloc]initWithFile:@"/Users/mac/Desktop/课件/day19/作业区号查询"];
        
        NSLog(@"%@",[p numberForRegion:@"海口"]);
        
        NSLog(@"%@",[p regionForNumber:@"021"]);
    }
    return 0;
}
