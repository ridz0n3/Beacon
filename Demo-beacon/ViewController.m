//
//  ViewController.m
//  Demo-beacon
//
//  Created by ME-Tech Mac User 1 on 10/12/15.
//  Copyright (c) 2015 Me-tech. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconTableViewController.h"

@interface ViewController ()<ESTBeaconManagerDelegate>
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *region;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_IOSBEACON_PROXIMITY_UUID
                                                     identifier:@"EstimoteSampleRegion"];
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;

    [self.beaconManager startRangingBeaconsInRegion:self.region];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
    
    [super viewDidDisappear:animated];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count > 0)
    {
        for (int i=0; i<beacons.count; i++) {
            CLBeacon *firstBeacon = [beacons objectAtIndex:i];
            
            if ([[self textForProximity:firstBeacon.proximity] isEqualToString:@"Near"] || [firstBeacon.major isEqual:@"2793"]) {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                BeaconTableViewController *descController = (BeaconTableViewController*)[storyboard instantiateViewControllerWithIdentifier: @"beaconVC"];
                [self.navigationController pushViewController:descController animated:YES];
                
            }else{
                NSLog(@"no");
            }
        }
        
        //self.imageView.image    = [self imageForProximity:firstBeacon.proximity];
    }
}

#pragma mark -

- (NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return @"Far";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

/*- (UIImage *)imageForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return [UIImage imageNamed:@"far_image"];
            break;
        case CLProximityNear:
            return [UIImage imageNamed:@"near_image"];
            break;
        case CLProximityImmediate:
            return [UIImage imageNamed:@"immediate_image"];
            break;
            
        default:
            return [UIImage imageNamed:@"unknown_image"];
            break;
    }
}*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
