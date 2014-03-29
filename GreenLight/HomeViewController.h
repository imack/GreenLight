//
//  ViewController.h
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : ApplicationViewController{
    UILabel *serviceLabel;
    
}

@property(nonatomic, strong)  IBOutlet UILabel *serviceLabel;
@property(nonatomic, strong) IBOutlet UISwitch *enabledSwitch;
-(IBAction)toggleSwitch:(id)sender;


@end
