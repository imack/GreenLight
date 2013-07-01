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
    
    GHRevealViewController *revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
    
    UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
	revealController.view.backgroundColor = bgColor;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SidebarStoryboard" bundle:nil];
    
    MainSideViewController* vc = [sb instantiateViewControllerWithIdentifier:@"MainSideViewController"];
    vc.controllerId = @"SidebarController1";
    
    HomeViewController *sideBar = [sb instantiateViewControllerWithIdentifier:@"SidebarController1"];
    
    UIViewController* controller = vc;
    
    controller.view.frame = CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height);
    
    self.searchController = [[GHSidebarSearchViewController alloc] initWithSidebarViewController:revealController];
    
    revealController.sidebarViewController = sideBar;
    
    [self.view addSubview:revealController.view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
