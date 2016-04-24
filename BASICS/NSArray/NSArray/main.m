//
//  main.m
//  NSArray
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDDog.h"


// OC数组NSArray只能用来存放对象,任意类型的对象(指向对象的指针),不能保存基本数据类型
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1. 快速创建  -- @"one" is a address
        NSArray *array1 = @[@"one", @"two", @"three"];
        NSLog(@"%@", array1);
        // 2. 创建一个空的不可变的数组
        NSArray *array2 = [[NSArray alloc]init];
        NSLog(@"%@", array2);
        // 3.
        NSArray *array3 = [[NSArray alloc]initWithArray:array1];
        NSLog(@"%@", array3);
        // 4. 用一组对象，指向对象的指针来初始化数组
        // OC数组由链表实现，最后指向nil，但nil不属于这个数组的元素
        NSArray *array4 = [NSArray arrayWithObjects:@"one", array1, @"one", array2, @[@"1",@"2",@"3"],@"one", nil];
        NSLog(@"%@", array4);
        // 5.创建只有一个元素的数组，这个方法没有减方法
        NSArray *array5 = [NSArray arrayWithObject:array1];
        NSLog(@"%@", array5);
        
        
        // nsarray的方法:
        // 1. 获取数组内元素个数
        NSLog(@"%lu", [array4 count]);
        // 2. 获得某个index的对象元素
        NSLog(@"%@", [array4 objectAtIndex:1]);
        //NSLog(@"%@", [array4 objectAtIndex:[array4 count]]); 越界导致崩溃
        // 3. 通过对象元素来获得对应的index
        NSLog(@"%lu", [array4 indexOfObject:@"one"]); // 多个元素会返回第一个
        //返回某个区域中的对象的索引,区域内有多个元素时，同样返回第一个:
        NSLog(@"%lu", [array4 indexOfObject:@"one" inRange:NSMakeRange(0, 5)]);
        // 4. 快速获得数组中的第一个和最后一个元素
        NSLog(@"%@ %@", [array4 firstObject], [array4 lastObject]);
        NSLog(@"%@ %@", array4[0], array4[[array4 count]-1]);
        NSLog(@"%@ %@",[array4 objectAtIndex:0],[array4 objectAtIndex:[array4 count]-1]);
        // 5. 判断数组中是否含有某个元素
        if ([array4 containsObject:@"one hun"]) {
            NSLog(@"array4 contains!");
        }else NSLog(@"array4 does not contain!");
        // 6. 将字符串分割成数组，用字符串分割字符串(strtok 类似)
        // string中有多少个要分割的字符串，会分割出+1个数组元素
        NSString *string = @"where there is a will, there is a way";
        NSArray *res = [string componentsSeparatedByString:@" "];
        NSLog(@"%@", res);
        // 用字符集合来分割，返回一个不可变数组
        NSCharacterSet *seperateSet = [NSCharacterSet characterSetWithCharactersInString:@" ,!"];
        NSArray *res1 = [string componentsSeparatedByCharactersInSet:seperateSet];
        NSLog(@"%@", res1);
        // 数组拼接成字符串(用一个字符串，作为连接符号，这个数组中必须全部是字符串)
        NSLog(@"%@", [res componentsJoinedByString:@" "]);
        NSLog(@"%@", [res componentsJoinedByString:@"xxx"]);
        
        
        
/*--------------------------枚举相关--------------------------------------------------*/
        // 枚举器 NSEnumerator--可以快速遍历数组或字典中的元素
        NSEnumerator *numerator = [res objectEnumerator];
        NSString *tmp = nil;
        while (tmp = [numerator nextObject]) {
            NSLog(@"%@", tmp);
        }
        // 反序的枚举器
        numerator = [res reverseObjectEnumerator];
        while (tmp = [numerator nextObject]) {
            NSLog(@"%@", tmp);
        }
        // 以上我们用NSString tmp 接收， 因为我们知道这是一个只包含了字符串的数组，普遍一点的话:
        id obj = nil;
        numerator = [array4 objectEnumerator];
        while (obj = [numerator nextObject]) {
            NSLog(@"%@", obj);
        }
        // 快速枚举 forin
        for (NSString *str in res) {
            NSLog(@"%@", str);
        }
        
        for (id obj in array4) {
            NSLog(@"%@", obj);
        }
        
/*----------------------------NSMutableArray-------------------------------*/
        // 继承自NSArray的初始化:
        NSMutableArray *NSMA1 = [[NSMutableArray alloc]init]; // count : 0  -
        NSMutableArray *NSMA2 = [NSMutableArray array]; // +
        NSLog(@"%lu", [NSMA2 count]);
        // NSMutableArray 自己的方法，带capacity，和nsstring一样 可以超过capacity存储
        NSMutableArray *NSMA3 = [[NSMutableArray alloc]initWithCapacity:5];
        NSLog(@"%lu", [NSMA3 count]);

        // 可变数组常用方法
        // 1.在数组最后追加一个元素，内容是任意的一个对象 id类型的
        [NSMA1 addObject:@"one"];
        [NSMA1 addObject:array1];
        NSLog(@"%@", NSMA1);
        //将array1中的元素分别加入到NSMA1中
        [NSMA1 addObjectsFromArray:array1];
        NSLog(@"%@", NSMA1);
    
        // 插入 最多可以插入到nil所在的index，往后就崩溃了
        NSLog(@"before : %lu", [NSMA1 count]);
        [NSMA1 insertObject:@"insertitem" atIndex:0];
        NSLog(@"%@ %lu", NSMA1[0], [NSMA1 count]);
        
        // 替换
        [NSMA1 replaceObjectAtIndex:0 withObject:@"replacement"];
        NSLog(@"%@", NSMA1[0]);
        
        // 交换
        NSLog(@"before : %@ %@", NSMA1[0], NSMA1[1]);
        [NSMA1 exchangeObjectAtIndex:0 withObjectAtIndex:1];
        NSLog(@"after  : %@ %@", NSMA1[0], NSMA1[1]);
        
        // 删除
        NSLog(@"%@", NSMA1);
        [NSMA1 removeObjectAtIndex:1];
        NSLog(@"%@", NSMA1);
        // 将输入的object在数组中全部删除
        [NSMA1 removeObject:@"one"];
        NSLog(@"%@", NSMA1);
        [NSMA1 removeLastObject];
        NSLog(@"%@", NSMA1);
        [NSMA1 setArray:@[@"one", @"two", @"three"]];
        NSLog(@"%@", NSMA1);
        [NSMA1 removeAllObjects];
        NSLog(@"%@", NSMA1);


        // 排序
        NSMutableArray *testOrder = [[NSMutableArray alloc]initWithObjects:@"1", @"2", @"3", @"4",@"5", nil];
        
        for (NSInteger i = 0; i< [testOrder count]-1; i++) {
            for (NSInteger j = i+1; j< [testOrder count]; j++) {
                if ([testOrder[i] compare:testOrder[j]]/* == 1 NSOrderedAscending*/) {
                    [testOrder exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
        NSLog(@"%@", testOrder);
/*---------------------------------description-----------------------------*/
        LXDDog *xiaobai = [[LXDDog alloc]initWithAge:3 name:@"xiaoBai"];
        LXDDog *bolt = [[LXDDog alloc]initWithAge:4 name:@"bolt"];
        LXDDog *hachi = [[LXDDog alloc]initWithAge:18 name:@"hachi"];
        
        NSMutableArray *dogs = [[NSMutableArray alloc]init];
        [dogs addObject:xiaobai];
        [dogs addObject:bolt];
        [dogs addObject:hachi];
        // 每当输出%@类型的占位符的时候，都会调用该类的description来处理，如果没有定义，没关系，nsobject里面有，不过内置的这个函数输出的是该对象的type以及他们的地址。
        NSLog(@"%@", dogs);
        
        
        
        // 用数组的方法排序，该方法相当于c语言中得qsort。 后面@selector括号中得(ageCompare:)是在.h里面声明了的。
        // 这里的ageCompare:类似于c语言中函数的指针，不过oc不能用啊，因为这里的函数是成员函数
        // OC提供了SEL类型，这个类型得变量用来保存成员函数的首地址
        // ------------@selector 将后面得成员函数名转换成SEL类型的变量-------------------
        SEL sel = @selector(ageCompare:);
        [dogs sortUsingSelector:sel];
        NSLog(@"%@", dogs);
        [dogs sortUsingSelector:@selector(nameCompare:)];
        NSLog(@"%@", dogs);
        
        
     
        
        
    }    // end of auto-release pool
    return 0;
}
