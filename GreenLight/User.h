//
//  User.h
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-06-20.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * user_bio;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * current;
@property (nonatomic, retain) NSNumber * min_age;
@property (nonatomic, retain) NSNumber * max_age;
@property (nonatomic, retain) NSNumber * status;

@end
