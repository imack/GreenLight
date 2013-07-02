//
//  ViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "HomeViewController.h"
#import "GreenLightService.h"
#import "User.h"
#import "MainSideViewController.h"

#import "GHSidebarSearchViewController.h"
#import "GHRevealViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) GHRevealViewController *revealController;
@property (nonatomic, strong) GHSidebarSearchViewController *searchController;

@end

@implementation HomeViewController

@synthesize serviceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    service = [[GreenLightService alloc] init];
    service.delegate = self;
    
    User *current_user = [User MR_findFirstByAttribute:@"current" withValue:[NSNumber numberWithInt:1]];
    
}

-(void) update:(NSString*)update{
    self.serviceLabel.text = update;
}

-(IBAction)doThing:(id)sender{

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
