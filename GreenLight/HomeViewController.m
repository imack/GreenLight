//
//  ViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"

#import "GHSidebarSearchViewController.h"
#import "GHRevealViewController.h"

@interface HomeViewController (){
    
    CLLocationManager *_locationManager;
    NSUUID *_uuid;
    BOOL _notifyOnDisplay;
}

@property (nonatomic, strong) GHRevealViewController *revealController;
@property (nonatomic, strong) GHSidebarSearchViewController *searchController;

@end

@implementation HomeViewController

@synthesize serviceLabel;
@synthesize enabledSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"ca.lunarluau.GreenLight"];
    region = [_locationManager.monitoredRegions member:region];
    if(region)
    {
        _uuid = region.proximityUUID;
        _notifyOnDisplay = region.notifyEntryStateOnDisplay;
        //self.onSwitch.on = true;
        [_locationManager startMonitoringForRegion:region];
    }
    else
    {
        // Default settings.
        _uuid =  [[NSUUID alloc] initWithUUIDString:LOKALO_UUID];
        _notifyOnDisplay = NO;
        //self.onSwitch.on = false;
    }
    
}

-(void) update:(NSString*)update{
    self.serviceLabel.text = update;
}


-(IBAction)toggleSwitch:(id)sender{
    
    if( self.enabledSwitch.on )
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid identifier:@"ca.lunarluau.GreenLight"];
        
        if(region)
        {
            region.notifyOnEntry = true;
            region.notifyOnExit = true;
            region.notifyEntryStateOnDisplay = _notifyOnDisplay;
            
            [_locationManager startMonitoringForRegion:region];
        }
    }
    else
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"ca.lunarluau.GreenLight"];
        [_locationManager stopMonitoringForRegion:region];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
