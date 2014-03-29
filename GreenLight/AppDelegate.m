//
//  AppDelegate.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "AppDelegate.h"
#import "MagicalRecord.h"
#import "SidebarController.h"
#import "FlatTheme.h"
#import "GHSidebarSearchViewControllerDelegate.h"
#import "User.h"
#import <Parse/Parse.h>
#import <Crashlytics/Crashlytics.h>
#import <TestFlight.h>

@interface AppDelegate () {
    CLLocationManager *_locationManager;
    NSDictionary *_userInfo;
}
@property (nonatomic, strong) GHRevealViewController *revealController;
@end


@implementation AppDelegate

@synthesize revealController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // This location manager will be used to notify the user of region state transitions.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"GreenLightDatabase.sqlite"];
    
    [GreenlightHelper initDefaults];
    
    User *user = [User MR_findFirstByAttribute:@"current" withValue:[NSNumber numberWithBool:true]];
    
    if (user){
        [self showMainStory];
        
    } else {
        UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
        
        SidebarController *signupController = [sidebarStoryboard instantiateViewControllerWithIdentifier:@"SignupController"];
        
        self.window.rootViewController = signupController;
        
    }
    
    [Parse setApplicationId:@"dlS34ZRE6TxpC9lNqiVJ0GnouYZBFuidXX93bkt9"
                  clientKey:@"Pf240BGzxqk9BSBdgEjZAdD9qgdVAZ9xtAna27uI"];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [Crashlytics startWithAPIKey:@"d5979dbb4d0dac0abc0004b2ee248b7e78c15f83"];
    [TestFlight takeOff:@"8d8edd4e-f731-4773-b33a-65690977c36e"];
    

    
    return YES;
}

-(void) showMainStory{
    [FlatTheme styleNavigationBarWithFontName:@"Avenir" andColor:[UIColor colorWithWhite:0.4f alpha:1.0f]];
    
    self.revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
    
    UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    SidebarController *sidebarController = [sidebarStoryboard instantiateViewControllerWithIdentifier:@"SidebarController1"];
    sidebarController.revealController = revealController;
    revealController.sidebarViewController = sidebarController;
    revealController.contentViewController = sidebarController.initialController;
    
    self.window.rootViewController = revealController;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // A user can transition in or out of a region while the application is not running.
    // When this happens CoreLocation will launch the application momentarily, call this delegate method
    // and we will let the user know via a local notification.
    
    if(state == CLRegionStateInside)
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [_locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
    }
    else if(state == CLRegionStateOutside)
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [_locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
        [GreenlightHelper clearCheckins];
    }
    else
    {
        return;
    }
    
    // If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
    // If its not, iOS will display the notification to the user.
}

-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    if ( [beacons count] > 0 ){
        CLBeacon *nearest = [beacons objectAtIndex:0];
        
        [GreenlightHelper handleRangedBeacon:nearest];
        [_locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
        
    } else {
        NSLog(@"Got weird state where no ranged beacons ");
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"Greenlight shut down";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    if ( notification.userInfo){
        // If the application is in the foreground, we will notify the user of the region's state via an alert.
        _userInfo = notification.userInfo; //don't like this hack, but it'll do for now
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Do you want to checkin to %@",[_userInfo objectForKey:@"name"]] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        [sheet addButtonWithTitle:@"Yes"];
        [sheet addButtonWithTitle:@"No"];
        [sheet addButtonWithTitle:@"Always"];
        [sheet addButtonWithTitle:@"Never"];
        
        [sheet showInView: self.window];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [GreenlightHelper handleUserCheckinResponse:buttonIndex for:_userInfo];
    }
    
}

@end
