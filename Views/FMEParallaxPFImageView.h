//
//  FMEParallaxPFImageView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

typedef enum : NSUInteger {
    FMEParallaxPFImageViewParallaxOffsetTypeProportional,
    FMEParallaxPFImageViewParallaxOffsetTypeStatic
} FMEParallaxPFImageViewParallaxOffsetType;



@interface FMEParallaxPFImageView : UIView
/**
 *  Default = YES;
 */
@property (nonatomic) BOOL parallaxEnabled;

/**
 *  Default = Proportional
 */
@property (nonatomic) FMEParallaxPFImageViewParallaxOffsetType parallaxOffsetType;

/**
 *  Default = 20%
 */
@property (nonatomic) CGFloat parallaxOffset;


@property (nonatomic, assign) PFFile *imageFile;

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
- (id)initWithFrame:(CGRect)frame parallaxOffsetType:(FMEParallaxPFImageViewParallaxOffsetType)offsetType;

@end
