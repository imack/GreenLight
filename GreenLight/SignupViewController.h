//
//  SignupViewController.h
//  GreenLight
//
//  Created by Ian MacKinnon on 2014-03-29.
//  Copyright (c) 2014 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RETableViewManager.h>

@interface SignupViewController : UITableViewController<RETableViewManagerDelegate, UIAlertViewDelegate>

@property (strong, readwrite, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *main;

@property (nonatomic, weak) IBOutlet UIView * infoView;
@property (nonatomic, weak) IBOutlet UILabel * infoLabel;

@end
