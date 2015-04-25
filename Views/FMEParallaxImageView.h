//
//  FMEParallaxImageView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FMEParallaxImageViewParallaxOffsetTypeProportional,
    FMEParallaxImageViewParallaxOffsetTypeStatic
} FMEParallaxImageViewParallaxOffsetType;

@interface FMEParallaxImageView : UIView
/**
 *  Default = YES;
 */
@property (nonatomic) BOOL parallaxEnabled;

/**
 *  Default = Proportional
 */
@property (nonatomic) FMEParallaxImageViewParallaxOffsetType parallaxOffsetType;

/**
 *  Default = 20%
 */
@property (nonatomic) CGFloat parallaxOffset;


@property (nonatomic, assign) UIImage *image;

/**
 *  Must set a scrollView
 */
@property (weak, nonatomic) UIScrollView *scrollView;

/**
 *  Must use this constructor
 *
 *  @param frame      Frame
 *  @param offsetType OffsetType
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame parallaxOffsetType:(FMEParallaxImageViewParallaxOffsetType)offsetType;
@end
