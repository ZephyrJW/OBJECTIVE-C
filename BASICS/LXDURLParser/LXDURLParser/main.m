//
//  main.m
//  LXDURLParser
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDURLParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LXDURLParser *parser = [[LXDURLParser alloc]initWithURL:@"ftp://123:456@127.0.0.1/xxx"];
        
        NSLog(@"协议: %@", [parser protocol]);
        NSLog(@"用户名: %@", [parser user]);
        NSLog(@"密码: %@", [parser password]);
        NSLog(@"主机: %@", [parser host]);
        NSLog(@"端口: %@", [parser port]);
        NSLog(@"路径: %@", [parser path]);
        NSLog(@"参数: %@", [parser parameters]);

        
    }
    return 0;
}
