//
//  FMParallaxImageView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMParallaxImageView : UIView
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic) CGFloat distance;

/**
 *  Ranges from -1 to 1, where 0 is centered
 */
@property (nonatomic, readwrite) CGFloat imageOffsetFactor;
- (id)initForAutoLayoutwithParallaxDistance:(CGFloat)distance;
- (id)initForAutoLayoutWithParallaxPercentage:(CGFloat)percentage;
- (id)initWithFrame:(CGRect)frame parallaxPercentage:(CGFloat)percentage;
@end
