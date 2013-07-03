//
//  LoginController4.m
//  ADVFlatUI
//
//  Created by Tope on 30/05/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SignupController.h"
#import <QuartzCore/QuartzCore.h>
#import "JLActionSheet.h"
#import "AppDelegate.h"
#import "FlatTheme.h"

@interface SignupController (){
    User *user;
}

@end

@implementation SignupController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIColor* mainColor = [UIColor colorWithRed:249.0/255 green:223.0/255 blue:244.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:62.0/255 green:28.0/255 blue:55.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    self.usernameField.backgroundColor = [UIColor whiteColor];
    self.usernameField.placeholder = @"Your Display Name";
    self.usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    self.usernameField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.usernameField.layer.borderWidth = 1.0f;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 20)];
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = leftView;
    
    
    self.descriptionField.backgroundColor = [UIColor whiteColor];
    self.descriptionField.placeholder = @"A little About You";
    self.descriptionField.font = [UIFont fontWithName:fontName size:16.0f];
    self.descriptionField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.descriptionField.layer.borderWidth = 1.0f;
    
    
    UIView* leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 20)];
    self.descriptionField.leftViewMode = UITextFieldViewModeAlways;
    self.descriptionField.leftView = leftView2;
    
    self.loginButton.backgroundColor = darkColor;
    self.loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.loginButton setTitle:@"SIGN UP HERE" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [self.loginButton addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.textColor =  [UIColor whiteColor];
    self.titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    self.titleLabel.text = @"Welcome to Greenlight!";
    
    self.infoLabel.textColor =  [UIColor darkGrayColor];
    self.infoLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    self.infoLabel.text = @"Please signup below, this information is public";
    
    self.infoView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.headerImageView.image = [UIImage imageNamed:@"running.jpg"];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    
    user = [User MR_createEntity];
    user.current = [NSNumber numberWithBool:true];
    
}

-(void) signupAction{
    user.name = self.usernameField.text;
    user.user_bio = self.descriptionField.text;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate showMainStory];
}

-(void) viewDidAppear:(BOOL)animated{
    
    JLActionSheet *sheet =  [JLActionSheet sheetWithTitle:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@[@"I'm Female", @"I'm Male"]];
    [sheet allowTapToDismiss:FALSE];
    
    [sheet setClickedButtonBlock:^(JLActionSheet *actionSheet, NSInteger buttonIndex) {
        user.gender = [NSNumber numberWithInteger:buttonIndex];
        
        JLActionSheet *newSheet =  [JLActionSheet sheetWithTitle:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@[@"I'm into Women", @"I'm into Men", @"I'm into both"]];
        
        [newSheet setClickedButtonBlock:^(JLActionSheet *actionSheet, NSInteger buttonIndex) {
            user.orientation = [NSNumber numberWithInteger:buttonIndex];
            
            
        }];
        [newSheet showOnViewController:self];
        
    }];
    
    [sheet showOnViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
