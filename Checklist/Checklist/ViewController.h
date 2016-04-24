//
//  ViewController.h
//  Checklist
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
//代理要知道被代理对象的信息


@interface ViewController : UITableViewController<itemDetailViewControllerDelegate>


@end