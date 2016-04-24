//
//  main.m
//  class structure
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDFraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LXDFraction *f1 = [[LXDFraction alloc]init];
        [f1 setNumerator:5 Denominator:4];
        [f1 show];
        
//      LXDFraction
// 对于加方法直接用类名调用 扩个中括号 就这吧
        LXDFraction *f2 = [LXDFraction fractionWithNumerator:96 Denominator:128];
        [f2 show];
        
//      [f2 addFraction:f1];
//      [f2 show];
        
        LXDFraction *f3 =  [LXDFraction addfraction:f1 another:f2];
        [f3 show];
    }
    return 0;
}
