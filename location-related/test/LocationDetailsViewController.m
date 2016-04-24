//
//  LocationDetailsViewController.m
//  test
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LocationDetailsViewController.h"
//#import <Foundation/Foundation.h>
#import "CategoryPickerViewController.h"
#import "HudView.h"
#import "Location.h"

@interface LocationDetailsViewController () <UITextViewDelegate>{
    NSString *_descriptionText;
    NSString *_categoryName;
    NSDate *_date;
}

@property(nonatomic, weak)IBOutlet UITextView *descriptionTextView;
@property(nonatomic, weak)IBOutlet UILabel *categoryLabel;
@property(nonatomic, weak)IBOutlet UILabel *latitudeLabel;
@property(nonatomic, weak)IBOutlet UILabel *longtitudeLabel;
@property(nonatomic, weak)IBOutlet UILabel *addressLabel;
@property(nonatomic, weak)IBOutlet UILabel *dateLabel;


@end

@implementation LocationDetailsViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _descriptionText = @"";
        _categoryName = @"No Category";
        _date = [NSDate date];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptionTextView.text = _descriptionText;
    self.categoryLabel.text = _categoryName;
    self.dateLabel.text = [self formatDate:_date];
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.latitude];
    self.longtitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.longitude];
    
    if (self.placemark) {
        self.addressLabel.text = [self stringFromPlaceMark:self.placemark];
    }else {
        self.addressLabel.text = @"No Address Found";
    }
    
    self.dateLabel.text = [self formatDate:[NSDate date]];
    
    // 虚拟键盘的关闭优化
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

-(void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath != nil && indexPath.section == 0 && indexPath.row== 0) {
        return;
    }
    
    [self.descriptionTextView resignFirstResponder];
}

- (NSString *)stringFromPlaceMark : (CLPlacemark *)placemark {
    return [NSString stringWithFormat:@"%@ %@, %@, %@ %@, %@",placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country];
}

- (NSString *)formatDate:(NSDate *)theDate {
    // lazy loading : 直到真正需要对象的时候再创建
    // 加static，即便方法结束了该值依然存在，这样创建一次可以重复使用，因为nsdateformatter创建的消耗比较大
    // 作用于是local的，不过生命周期很长，
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return [formatter stringFromDate:theDate];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    // 第二个section的第二项 即address
    }else if (indexPath.section == 2 && indexPath.row == 2) {
        CGRect rect = CGRectMake(100, 10, 205, 10000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        // 顶部10points，底部10points，共20 所以这里＋20
        return self.addressLabel.frame.size.height + 20;
    }else return 44;
    
    
}

- (void)closeScreen {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)done:(id)sender {
//    NSLog(@"Description: %@", _descriptionText);
//    
//    [self closeScreen];
    HudView *hudView = [HudView hudInView:self.navigationController.view animated:YES];
    hudView.text = @"Tagged";
    
    //1 创建core data管理的对象的方式
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    //2
    location.locationDescription = _descriptionText;
    location.category = _categoryName;
        // 使用@将经纬度信息转变为NSNumber类型
    location.latitude = @(self.coordinate.latitude);
    location.longtitude = @(self.coordinate.longitude);
    location.date = _date;
    location.placemark = self.placemark;
    //3
    NSError *error;
        // output parameter
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"ERROR:%@", error);
        abort();
    }
    
    
    [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.6];
}

- (IBAction)cancel:(id)sender {
    [self closeScreen];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickCategory"]) {
        
        CategoryPickerViewController *controller = segue.destinationViewController;
        controller.selectedCategoryName = _categoryName;
        
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        return indexPath;
    }else return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.descriptionTextView becomeFirstResponder];
    }
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text {
    
    _descriptionText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _descriptionText = textView.text;
}



#pragma mark - ConnectionWithCategoryPicker
-(IBAction)CategoryPickerDidPickCategory:(UIStoryboardSegue *)segue {
    
    CategoryPickerViewController *viewController = segue.sourceViewController;
    
    _categoryName = viewController.selectedCategoryName;
    self.categoryLabel.text = _categoryName;
}











@end
