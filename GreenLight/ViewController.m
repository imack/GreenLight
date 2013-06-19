//
//  ViewController.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "ViewController.h"
#import "GreenLightService.h"
 

@interface ViewController ()

@end

@implementation ViewController

@synthesize serviceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    service = [[GreenLightService alloc] init];
    service.delegate = self;
    
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
