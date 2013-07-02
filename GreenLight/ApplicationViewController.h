//
//  ApplicationViewController.h
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-07-02.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHRevealViewController.h"

typedef void (^RevealBlock)();

@interface ApplicationViewController : UIViewController{
    @private
    GHRevealViewController *_revealController;
    
}

@property (nonatomic, strong) GHRevealViewController *revealController;


@end
