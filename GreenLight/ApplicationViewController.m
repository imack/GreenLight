//
//  ApplicationViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 2013-07-02.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "ApplicationViewController.h"

@interface ApplicationViewController ()

@end

@implementation ApplicationViewController

@synthesize revealController=_revealController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealSidebar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.leftBarButtonItem = menuItem;
}

- (void)revealSidebar:(id)sender {
	[self.revealController toggleSidebar:!self.revealController.sidebarShowing
                                duration:kGHRevealSidebarDefaultAnimationDuration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
