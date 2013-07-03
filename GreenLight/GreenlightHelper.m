//
//  GreenlightHelper.m
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-06-19.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "GreenlightHelper.h"
#import "AppDelegate.h"
#import "User.h"
#import "JLActionSheet.h"

@implementation GreenlightHelper


+(void) initDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( ![defaults objectForKey:@"show_alerts"] ){
        [defaults setObject:[NSNumber numberWithBool:true] forKey:@"show_alerts"];
    }
    
    if ( ![defaults objectForKey:@"background_scan"] ){
        [defaults setObject:[NSNumber numberWithBool:true] forKey:@"background_scan"];
    }
    
    if ( ![defaults objectForKey:@"current_light"] ){
        [defaults setObject:[NSNumber numberWithInt:0] forKey:@"current_light"];
    }

}


@end
