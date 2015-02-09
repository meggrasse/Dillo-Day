//
//  ColorSegueViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMColorTransition.h"

@interface ColorSegueViewController : UIViewController
@property (strong, nonatomic) FMColorTransition *previousColorTransition;
- (void)configureColorTransition:(UIColor *)color transitionType:(FMColorTransitionType)type;


- (void)configureDilloButtonToUnwindOnTap:(BOOL)unwindsOnTap;
@end
