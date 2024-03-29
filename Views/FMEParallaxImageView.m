//
//  FMEParallaxImageView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "FMEParallaxImageView.h"
#import <PureLayout/PureLayout.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FMEParallaxImageView()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *imageViewLayoutConstraints;
@property (strong, nonatomic) NSLayoutConstraint *imageViewHeightLayoutConstraint;

/**
 *  Ranges from -1 to 1;
 */
@property (nonatomic) CGFloat imageOffsetFactor;
@end

@implementation FMEParallaxImageView
- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (id)initWithFrame:(CGRect)frame parallaxOffsetType:(FMEParallaxImageViewParallaxOffsetType)offsetType {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self configureParallaxImageView];
    }
    return self;
}

/**
 *  Sets the default values and configures the view.
 */
- (void)configureParallaxImageView {
    self.parallaxEnabled = YES;
    self.parallaxOffset = 1;

    [self constructImageView];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (NSMutableArray *)imageViewLayoutConstraints {
    if(!_imageViewLayoutConstraints) {
        _imageViewLayoutConstraints = [NSMutableArray new];
    }
    return _imageViewLayoutConstraints;
}

- (void)constructImageView {
    [self addSubview:self.imageView];
    [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];

    switch (self.parallaxOffsetType) {
        case FMEParallaxImageViewParallaxOffsetTypeProportional: {
            self.imageViewHeightLayoutConstraint = [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:(1.0 + self.parallaxOffset)];
            break;
        }
        case FMEParallaxImageViewParallaxOffsetTypeStatic: {
            self.imageViewHeightLayoutConstraint = [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withOffset:(2.0 * self.parallaxOffset)];
            break;
        }
        default:
            break;
    }
}

- (void)setImageOffsetFactor:(CGFloat)imageOffsetFactor {
    if (imageOffsetFactor < -1) {
        imageOffsetFactor = -1;
    } else if (imageOffsetFactor > 1) {
        imageOffsetFactor = 1;
    } else if (isnan(imageOffsetFactor)) {
        imageOffsetFactor = 0;
    }

    _imageOffsetFactor = imageOffsetFactor;

    CGFloat heightDifference = CGRectGetHeight(self.imageView.bounds) - CGRectGetHeight(self.bounds);
    CGFloat yOffsetBaseline = -heightDifference/2.0;
    CGFloat yWiggleRoom = heightDifference/2.0;
    CGFloat yOffset = yOffsetBaseline + (yWiggleRoom * -imageOffsetFactor);

    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.y = yOffset;
    self.imageView.frame = imageViewFrame;
}


- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;

    [RACObserve(scrollView, contentOffset) subscribeNext:^(id x) {
        [self updateParallaxOffset];
    }];

    [self updateParallaxOffset];
}

- (void)updateParallaxOffset {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGRect convertedFrame = [self convertRect:self.frame toView:self.scrollView];
        CGRect scrollViewBounds = self.scrollView.bounds;
        scrollViewBounds.size.height += CGRectGetHeight(convertedFrame);
        scrollViewBounds.origin.y -= CGRectGetHeight(convertedFrame)/2.0;


        CGFloat yScrollViewBoundsMidpoint = CGRectGetMidY(scrollViewBounds);
        CGFloat yParallaxImageViewFrameMidpoint = CGRectGetMidY(convertedFrame);

        CGFloat newOffsetFactor = (yScrollViewBoundsMidpoint - yParallaxImageViewFrameMidpoint)/(CGRectGetHeight(scrollViewBounds)) *-1.0;
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageOffsetFactor = newOffsetFactor;
        });
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateParallaxOffset];
}

@end
