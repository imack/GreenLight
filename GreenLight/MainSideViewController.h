//
//  MainViewController.h
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHRevealViewController.h"
typedef void (^RevealBlock)();

@interface MainSideViewController : UIViewController{
@private
	RevealBlock _revealBlock;
}

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@property (nonatomic, strong) RevealBlock revealBlock;
@property (nonatomic, strong) NSString* controllerId;

@end
