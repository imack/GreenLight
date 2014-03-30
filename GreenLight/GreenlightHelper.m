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

@implementation GreenlightHelper


+(void) initDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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


+(void) promptForAuthorization:(User*)user{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.alertBody = [NSString stringWithFormat:@"Do you want to checkin to %@", user.name];
    NSDictionary *userInfo = @{@"major":user.major, @"minor":user.minor, @"name":user.name};
    
    notification.userInfo = userInfo;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

+(void) handleUserCheckinResponse:(NSInteger)buttonIndex for:(NSDictionary*)userInfo{
    
    NSArray *users = [User MR_findByAttribute:@"user_id" withValue:[userInfo objectForKey:@"userid"]];
    User *user  = [users objectAtIndex:0];
    
    switch (buttonIndex) {
            
    }
    
}


+(void) performCheckin:(User*)user{
    
    NSString *major = [user.major stringValue];
    NSString *minor = [user.minor stringValue];
    
    NSDictionary *dict = @{@"major": major,
                           @"minor":minor};
    
    
    [[AuthClient sharedClient] postPath:@"/api/checkin" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        notification.alertBody = [NSString stringWithFormat:@"You were checked in to %@", user.name];
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}


+(void) grabNameData:(User*)user  withPrompt:(bool)prompt{
    
    NSDictionary *dict = @{@"major": user.major,
                           @"minor": user.minor};
    
    [[AuthClient sharedClient] getPath:@"/locations/lookup" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *location_dict = [dict objectForKey:@"users"];
        if ([location_dict count] == 1){
            NSDictionary *raw_loc = [location_dict objectAtIndex:0];
            user.name = [raw_loc objectForKey:@"name"];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            if (prompt){
                [GreenlightHelper promptForAuthorization:user];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}


+(void) handleRangedBeacon:(CLBeacon*)beacon {
    NSLog(@"Ranged a beacon major:%@ minor:%@", beacon.major, beacon.minor);
    
    NSArray *users = [User MR_findByAttribute:@"user_id" withValue:beacon.major];
    
    if ( [users count] > 0){
        User *user = [users objectAtIndex:0];
        NSTimeInterval interval = [user.last_seen timeIntervalSinceNow];
        
        if ( (-1*interval) > 1*60){
            if ( [user.prompt boolValue]){
                [GreenlightHelper performCheckin:(User*)user];
            } else {
                [GreenlightHelper promptForAuthorization:user];
            }
            user.last_seen = [NSDate date];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
    } else {
        User *user = [User MR_createEntity];
        user.major = beacon.major;
        user.minor = beacon.minor;
        user.last_seen = [NSDate date];
        user.prompt = [NSNumber numberWithBool:false];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [GreenlightHelper grabNameData:user withPrompt:true];
    }
    
    
    
}



@end
