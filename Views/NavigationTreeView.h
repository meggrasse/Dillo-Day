//
//  NavigationTreeView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/13/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationTreeView : UIView
+ (id)sharedInstance;
@property (weak, nonatomic) UIViewController *currentViewController;

- (void)configureView;
- (void)pushViewController:(UIViewController *)viewController;
- (void)popViewController:(UIViewController *)viewController;
- (void)updateNavigationTree;
- (void)addNavigationTreeViewToViewController:(UIViewController *)viewController;
@end
