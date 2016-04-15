//
//  main.m
//  introduction、 类的结构
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
  @interface 类名 : 父类的名字 {
    成员变量（属性）
  }
  成员函数
  @end
 */

// 类名命名规则: 每个单词的首字母都要大写
@interface LXDPerson : NSObject {
// 类中的成员变量,前面加一个_, 和局部变量、全局变量区分
    char _name[20];
    int _age;
}

// 成员函数--方法，命名规范: 第一个单词小写，后面首字母大写。
// 仅仅是声明而已, 参数列完直接打出;
- (void) setAge : (int)age;
- (int) age;

- (void) setName : (const char*)name;
- (const char*) name;

- (void) setAge:(int)age name:(const char *)name;
// - (void) setAge:(int)age :(const char *)name; 也可以,省略了age后的name,但是注意,':'是万万不能省去的

- (void) showSelf;

@end

@implementation LXDPerson

- (void) setAge:(int)age {
    _age = age;
}

- (int) age {
    return _age;
}

- (void) setName:(const char *)name {
    strcpy(_name, name);
}

- (const char *) name {
    return _name;
}

- (void) setAge:(int)age name:(const char *)name {
    _age = age;
    strcpy(_name, name);
}

- (void) showSelf {
    //NSLog 是一个C函数, command加左键以确认
    NSLog(@"name: %s, age: %d", _name, _age);
}

@end

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        /*
        NSString *text = [NSString stringWithFormat:@"so what ?"];
        NSLog(@"%@",text);
        NSLog(@"\nHello, World!\n");
        NSLog(@"%x", 160);
        NSLog(@"%o", 80);
         */
        
        // 定义了变量之后需要给它分配一个堆(存储空间)哦
        LXDPerson *person1 = [[LXDPerson alloc]init];
        /* 
         等价于: 
         Student *stu = [Student alloc];
         stu = [stu init];
         */
        
        [person1 setAge:15 name:"Mingming"];
        [person1 showSelf];
        
    }
    return 0;
}
