//
//  ChecklistItem.h
//  Checklist
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>
//之前不再supporting files这个文件夹中，不能创建
@property(nonatomic, copy) NSString *text;
@property(nonatomic, assign)BOOL checked;
//为什么添加属性变量而不是实例变量: 实例变量只存在于对象的内部，无法跨越时空被其他对象访问和使用, 在.h中说明他们是公用接口的一部分
//定义的属性变量和Interface Builder中的视觉元素关联在一起时才需要添加IBOutlet.

- (void)toggleChecked;

@end
