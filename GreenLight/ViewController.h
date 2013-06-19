//
//  ViewController.h
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreenLightService.h"

@interface ViewController : UIViewController<GreenLightServiceDelegate>{
    UILabel *serviceLabel;
    GreenLightService *service;
}

@property(nonatomic, strong)  IBOutlet UILabel *serviceLabel;

-(IBAction)doThing:(id)sender;


@end
