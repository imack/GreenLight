//
//  SidebarController1.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarController.h"
#import "SidebarCell.h"
#import "GHRevealViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SidebarController ()

@property (nonatomic, strong) NSArray* items;

@end

@implementation SidebarController {
	GHRevealViewController *_revealController;
	UISearchBar *_searchBar;
	UITableView *_menuTableView;
	NSArray *_headers;
	NSArray *_controllers;
	NSArray *_cellInfos;
    
}
@synthesize revealController=_revealController;


-(id) initWithCoder:(NSCoder *)aDecoder{
    
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        NSDictionary* object1 = [NSDictionary dictionaryWithObjects:@[ @"Home", @"0", @"account" ] forKeys:@[ @"title", @"count", @"icon" ]];
        NSDictionary* object2 = [NSDictionary dictionaryWithObjects:@[ @"Activity", @"0", @"check" ] forKeys:@[ @"title", @"count", @"icon" ]];
        NSDictionary* object3 = [NSDictionary dictionaryWithObjects:@[ @"Settings", @"0", @"settings" ] forKeys:@[ @"title", @"count", @"icon" ]];
        NSDictionary* object4 = [NSDictionary dictionaryWithObjects:@[ @"About", @"0", @"arrow" ] forKeys:@[ @"title", @"count", @"icon" ]];
        
        self.items = @[object1, object2, object3, object4];
        
        UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        NSArray *controllers = @[
                                 [[UINavigationController alloc] initWithRootViewController:[sidebarStoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"]],
                                 [[UINavigationController alloc] initWithRootViewController:[sidebarStoryboard instantiateViewControllerWithIdentifier:@"FeedViewController"]],
                                 [[UINavigationController alloc] initWithRootViewController:[sidebarStoryboard instantiateViewControllerWithIdentifier:@"SettingsController"]],
                                 [[UINavigationController alloc] initWithRootViewController:[sidebarStoryboard instantiateViewControllerWithIdentifier:@"AboutViewController"]]
                                 ];    
        _controllers = controllers;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor clearColor];
    
    NSString* boldFontName = @"Avenir-Black";
    NSString* fontName = @"Avenir-BlackOblique";
    
    self.profileNameLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.profileNameLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    self.profileNameLabel.text = @"Lena Llellywyngot";
    
    self.profileLocationLabel.textColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.profileLocationLabel.font = [UIFont fontWithName:fontName size:12.0f];
    self.profileLocationLabel.text = @"London, UK";
    
    self.profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;
    self.profileImageView.layer.cornerRadius = 35.0f;
    
    for (UIViewController *navcontroller in _controllers){
        ApplicationViewController * controller = navcontroller.childViewControllers[0];
        controller.revealController = _revealController;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _revealController.contentViewController = _controllers[indexPath.row];
	[_revealController toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SidebarCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SidebarCell1"];
    
    NSDictionary* item = self.items[indexPath.row];
    
    cell.titleLabel.text = item[@"title"];
    cell.iconImageView.image = [UIImage imageNamed:item[@"icon"]];
    
    NSString* count = item[@"count"];
    if(![count isEqualToString:@"0"]){
        cell.countLabel.text = count;
    }
    else{
        cell.countLabel.alpha = 0;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ApplicationViewController*) initialController {    
    return _controllers[0];
    
}


@end
