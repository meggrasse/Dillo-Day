//
//  FMParallaxImageView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "FMParallaxImageView.h"
@interface FMParallaxImageView()
@property (nonatomic) CGFloat percentage;
@end


@implementation FMParallaxImageView

- (id)initWithFrame:(CGRect)frame parallaxPercentage:(CGFloat)percentage {
    if (self = [super initWithFrame:frame]) {
        _percentage = percentage;
        
        CGSize imageViewSize = frame.size;
        imageViewSize.height *= (1 + percentage);
        imageViewSize.width *= 1;
        
//        CGRect imageViewFrame = CGRectMake((CGRectGetWidth(self.frame) - imageViewSize.width)/2.0, (CGRectGetHeight(self.frame) - imageViewSize.height)/2.0, imageViewSize.width, imageViewSize.height);
//        _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        _imageView = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:_imageView];
        [_imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-imageViewSize.height/2.0, 0, -imageViewSize.height/2.0, 0)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
//        [self setImageOffsetFactor:0];
    }
    return self;
}

- (void)setImageOffsetFactor:(CGFloat)imageOffsetFactor {
    _imageOffsetFactor = imageOffsetFactor;
    
    if (imageOffsetFactor < -1) {
        imageOffsetFactor = -1;
    } else if (imageOffsetFactor > 1) {
        imageOffsetFactor = 1;
    }
    
    CGFloat yOffsetBaseline = (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.imageView.bounds))/2.0;
    CGFloat yWiggleRoom = (CGRectGetHeight(self.bounds) * _percentage)/2.0;
    
    CGFloat yOffset = yOffsetBaseline + (yWiggleRoom * -imageOffsetFactor);
    CGRect frame = self.imageView.frame;
    frame.origin.y = yOffset;
    self.imageView.frame = frame;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setImageOffsetFactor:_imageOffsetFactor];
}
@end
