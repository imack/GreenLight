//
//  GreenlightHelper.m
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-06-19.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "GreenlightHelper.h"
#import "AppDelegate.h"

@implementation GreenlightHelper


+(NSFNanoStore*) getNanoStore{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];    
    return app.nanoStore;    
}

@end
