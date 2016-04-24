//
//  HudView.m
//  test
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HudView.h"

@implementation HudView

// convenience constructor
+(instancetype)hudInView:(UIView *)view animated:(BOOL)animated {
    HudView *hudView = [[HudView alloc]initWithFrame:view.bounds];
    hudView.opaque = NO;
    
    [view addSubview:hudView];
    view.userInteractionEnabled = NO;
    
    [hudView showAnimated:animated];
    return hudView;
}

-(void)drawRect:(CGRect)rect {
    const CGFloat boxWidth = 96.0f;
    const CGFloat boxLength = 96.0f;
    
    // 创建出显示hud的小格子
    CGRect boxRect = CGRectMake(roundf((self.bounds.size.width-boxWidth)/2.0f), roundf((self.bounds.size.height-boxLength)/2.0f), boxWidth, boxLength);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:boxRect cornerRadius:10.0f];
    [[UIColor colorWithWhite:0.3f alpha:0.8f]setFill];
    [roundedRect fill];
    
    // 创建图片对象并在point绘制这个图像
    UIImage *image = [UIImage imageNamed:@"Checkmark"];
    
    CGPoint imagePoint = CGPointMake((self.center.x-roundf(image.size.width/2.0f)), self.center.y-roundf(image.size.height/2.0f)-boxLength/8.f);
    [image drawAtPoint:imagePoint];
    
    // 绘制格子内的文本内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    CGSize textSize = [self.text sizeWithAttributes:attributes];
    
    CGPoint textPoint = CGPointMake(self.center.x-roundf(textSize.width/2.0f), self.center.y-roundf(textSize.height/2.0f)+boxLength/4.0f);
    
    [self.text drawAtPoint:textPoint withAttributes:attributes];
}

-(void)showAnimated:(BOOL)animated {
    if (animated) {
        // 完全透明
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0f;
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
