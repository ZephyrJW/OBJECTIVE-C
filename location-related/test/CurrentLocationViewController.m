//
//  FirstViewController.m
//  test
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import "LocationDetailsViewController.h"

@interface CurrentLocationViewController () {
    CLLocationManager *_locationManager;
    CLLocation *_location;
    // BOOL类型的变量不需要 *
    BOOL _updatingLocation;
    NSError *_lastLocationError;
    
    CLGeocoder *_geocoder;
    CLPlacemark *_placemark;
    BOOL _perfromingReverseGeocoding;
    NSError *_lastGeocodingError;
}

@end

@implementation CurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
    [self configureGetButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    NSLog(@"did clicked");
    if (_updatingLocation) {
        [self stopLocationManager];
    }else {
        _location = nil;
        _lastLocationError = nil;
        _placemark = nil;
        _lastGeocodingError = nil;
        
        [self startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
   }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"TagLocation"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LocationDetailsViewController *controller = (LocationDetailsViewController *)navigationController.topViewController;
        
        controller.coordinate = _location.coordinate;
        controller.placemark = _placemark;
        controller.managedObjectContext = self.managedObjectContext;
    }
}

- (void)configureGetButton {
    if (_updatingLocation) {
        [self.getButton setTitle:@"stop" forState:UIControlStateNormal];
    }else {
        [self.getButton setTitle:@"press button for location" forState:UIControlStateNormal];
    }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _locationManager = [[CLLocationManager alloc]init];
        _geocoder = [[CLGeocoder alloc]init];
    }
    return self;
}


#pragma mark -CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
//    NSLog(@"didupdate");
//}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    
    NSLog(@"定位失败: %@", error);
    
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    
    [self stopLocationManager];
    _lastLocationError = error;
    
    [self updateLabels];
    [self configureGetButton];
}

- (void)didTimeOut:(id)obj {
    NSLog(@" *** timeout");
    
    if (_location == nil) {
        [self stopLocationManager];
        _lastLocationError = [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
        [self updateLabels];
        [self configureGetButton];
    }
}

- (void)stopLocationManager {
    if (_updatingLocation) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

- (void)startLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager startUpdatingLocation];
        _updatingLocation = YES;
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
    }
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"当前位置: %@",newLocation);
    
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    CLLocationDistance distance = MAXFLOAT;
    
    if (_location) {
        distance = [newLocation distanceFromLocation:_location];
    }
    
    
    if (_location == nil || _location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        _lastLocationError = nil;
        _location = newLocation;
        [self updateLabels];
        
        if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
            NSLog(@"complete");
            [self stopLocationManager];
            [self configureGetButton];
        }
        if (distance > 0) {
            _perfromingReverseGeocoding = NO;
        }
        
        if (!_perfromingReverseGeocoding) {
            NSLog(@"***going to geocode");
            _perfromingReverseGeocoding = YES;
            
            // 下面是一个block语句: 通过^符号，就知道后面是块语句,^后面的()里的内容是参数
            // 块语句都是在CLGeocoder即_geocoder完成了reverse geocoding(或出错)的时候才执行
            [_geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error){
                NSLog(@"***Found placemarks:%@, error:%@",placemarks, error);
                
                _lastGeocodingError = error;
                if (error == nil && [placemarks count] > 0) {
                    _placemark = [placemarks lastObject];
                }else {
                    _placemark = nil;
                }
                
                _perfromingReverseGeocoding = NO;
                [self updateLabels];
            }];
        }
    }else if (distance < 1.0) {
        NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:_location.timestamp];
        if (timeInterval > 10) {
            NSLog(@"***强制完成");
            [self stopLocationManager];
            [self updateLabels];
            [self configureGetButton];
        }
    }
    
    
}

- (void)updateLabels {
    if (_location != nil) {
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.latitude];
        self.longtitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.longitude];
        self.tagButton.hidden = NO;
        self.messageLabel.text = @"";
        
        if (_placemark != nil) {
            self.addressLabel.text = [self stringFromPlace:_placemark];
        } else if (_perfromingReverseGeocoding){
            self.addressLabel.text = @"searching....";
        }else if (_lastGeocodingError != nil) {
            self.addressLabel.text = @"error detected";
        }else {
            self.addressLabel.text = @"are you on MARS?";
        }
        
        
    }else {
        self.latitudeLabel.text = @"";
        self.longtitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        self.messageLabel.text = @"Press the button to start";
        
        NSString *statusMessage;
        if (_lastLocationError != nil) {
            if ([_lastLocationError.domain isEqualToString:kCLErrorDomain] && _lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"user diables this function!";
            }else {
                statusMessage = @"sorry, something went wrong";
            }
        }else if (![CLLocationManager locationServicesEnabled]) {
            statusMessage = @"user disables location services";
        }else if (_updatingLocation) {
            statusMessage = @"searching";
        }else {
            statusMessage = @"press the button to begin";
        }
        self.messageLabel.text = statusMessage;
    }

}

-(NSString *)stringFromPlace:(CLPlacemark *)placemark {
    return [NSString stringWithFormat:@"%@ %@\n%@ %@ %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode ];
}





@end
