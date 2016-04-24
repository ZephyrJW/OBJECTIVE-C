//
//  LocationDetailsViewController.h
//  test
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDetailsViewController : UITableViewController

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,strong)CLPlacemark *placemark;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
