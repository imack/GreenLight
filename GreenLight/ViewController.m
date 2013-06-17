//
//  ViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "ViewController.h"
#import "GreenLightService.h"
 

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    service = [[GreenLightService alloc] init];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    localNotification.alertBody = @"Alert message goes here";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


-(IBAction)doThing:(id)sender{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
