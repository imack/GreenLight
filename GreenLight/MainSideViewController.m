//
//  MainViewController.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "MainSideViewController.h"
#import "SidebarController.h"
#import "FlatTheme.h"
#import "Utils.h"

@interface MainSideViewController ()

@end

@implementation MainSideViewController


@synthesize revealBlock=_revealBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController* frontController = [[UIViewController alloc] init];
    frontController.view.backgroundColor = [UIColor blackColor];
    [frontController.view setFrame:CGRectMake(0,0, 320, 640)];
    [self.view addSubview:frontController.view];
    
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealSidebar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.leftBarButtonItem = menuItem;
}


- (void)revealSidebar:(id)sender {
	_revealBlock();
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

