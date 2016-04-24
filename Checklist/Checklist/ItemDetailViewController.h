//
//  AddItemTableViewController.h
//  Checklist
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

// chpter 9
@class ItemDetailViewController;
@class ChecklistItem;
// 协议只是一堆方法的名称, 不实现, 但是任何遵守该协议的对象都必须实现这些方法
@protocol itemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;


@end
//chapter 9


@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (weak, nonatomic) id <itemDetailViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong)ChecklistItem *itemToEdit;

- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;
@end
