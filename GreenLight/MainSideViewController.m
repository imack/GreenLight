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

@implementation MainSideViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController* frontController = [[UIViewController alloc] init];
    frontController.view.backgroundColor = [UIColor blackColor];
    [frontController.view setFrame:CGRectMake(0,0, 320, 640)];
    [self.view addSubview:frontController.view];
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

