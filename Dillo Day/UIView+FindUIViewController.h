//
//  UIView+FindUIViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/5/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end
