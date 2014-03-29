//
//  GreenlightHelper.h
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-06-19.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GreenlightHelper : NSObject

+(void) initDefaults;

+(void) handleRangedBeacon:(CLBeacon*)beacon;
+(void) handleUserCheckinResponse:(NSInteger)buttonIndex for:(NSDictionary*)userInfo;
+(void) clearCheckins;


@end
