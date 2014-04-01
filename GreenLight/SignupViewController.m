//
//  SignupViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 2014-03-29.
//  Copyright (c) 2014 Ian MacKinnon. All rights reserved.
//

#import "SignupViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface SignupViewController (){
    UIBarButtonItem *rightButton;
    PFUser *user;
}


@property (strong, readwrite, nonatomic) RETextItem* username;
@property (strong, readwrite, nonatomic) RETextItem* email;
@property (strong, readwrite, nonatomic) REDateTimeItem* dob;
@property (strong, readwrite, nonatomic) RETextItem* password;
@property (strong, readwrite, nonatomic) RETextItem* passwordConfirm;
@property (strong, readwrite, nonatomic) REPickerItem* orientationItem;

-(void) signup;


@end

@implementation SignupViewController

@synthesize infoView;
@synthesize infoLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoLabel.text = @"Signup";
    self.tableView.tableHeaderView = self.infoView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0)];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    // Add a section
    //
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Login Stuff"];
    [_manager addSection:section];
    
    // Add a string
    self.username = [RETextItem itemWithTitle:@"Username" value:@"" placeholder:@"Acme" ];
    self.email = [RETextItem itemWithTitle:@"Email" value:@""placeholder:@"contact@acmecorp.com"];
    [self.email setKeyboardType:UIKeyboardTypeEmailAddress];
    
    self.password = [RETextItem itemWithTitle:@"Password" value:@"" placeholder:@"Required" ];
    self.password.secureTextEntry = YES;
    self.passwordConfirm = [RETextItem itemWithTitle:@"Confirm" value:@"" placeholder:@"Required" ];
    self.passwordConfirm.secureTextEntry = YES;
    
    [section addItem:self.username];
    [section addItem:self.email];
    [section addItem:self.password];
    [section addItem:self.passwordConfirm];

    
    RETableViewSection *preferences = [RETableViewSection sectionWithHeaderTitle:@"About You"];
    [_manager addSection:preferences];
    
    self.dob = [REDateTimeItem itemWithTitle:@"Date of Birth" value:[NSDate date] placeholder:nil format:@"yyyy/MM/dd" datePickerMode:UIDatePickerModeDate];
    self.dob.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    
    NSArray __block *sexOptions = @[@"I'm a Man", @"I'm a Woman"];
    NSArray __block *orientationOptions = @[@"into Women", @"into Men", @"into either"];
    
    self.orientationItem = [REPickerItem itemWithTitle:@"Picker" value:@[] placeholder:nil options:sexOptions];
    
    self.orientationItem = [REPickerItem itemWithTitle:@"Orientation" value:@[[sexOptions objectAtIndex:1], [orientationOptions objectAtIndex:1]] placeholder:nil options:@[sexOptions, orientationOptions]];
    self.orientationItem.onChange = ^(REPickerItem *item){
        user[@"sex"] = [NSNumber numberWithInt:[sexOptions indexOfObjectIdenticalTo:[item.value firstObject]]];
        user[@"orientation"] = [NSNumber numberWithInt:[orientationOptions indexOfObjectIdenticalTo:[item.value firstObject]]];
    };
    
    
    [preferences addItem:self.dob];
    [preferences addItem:self.orientationItem];
    
    user = [PFUser user];
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(confirmCancel)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Signup" style:UIBarButtonItemStylePlain target:self action:@selector(signup)];
}


- (void)confirmCancel {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) signup{
    
    user.username = self.username.value;
    user.email = self.email.value;
    user.password = self.password.value;
    user[@"dob"] = self.dob.value;
    //user.user_bio = self.descriptionField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            [appDelegate showMainStory];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            [self showAlertMessage:errorString withTitle:@"Signup Error"];
            
        }
    }];
    
    
}


- (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
