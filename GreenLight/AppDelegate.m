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

@interface AppDelegate () 
@property (nonatomic, strong) GHRevealViewController *revealController;
@end


@implementation AppDelegate

@synthesize revealController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //NSLog(@"got notification %@", notification.description);
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

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"Greenlight shut down";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
