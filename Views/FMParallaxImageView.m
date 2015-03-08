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
@property (strong, nonatomic) NSArray *imageViewConstraints;
@property (nonatomic) BOOL shouldUsePercentage;
@end


@implementation FMParallaxImageView
- (void)setDistance:(CGFloat)distance {
    _distance = distance;
    [self setImageOffsetFactor:self.imageOffsetFactor];
}

- (id)initForAutoLayoutwithParallaxDistance:(CGFloat)distance {
    if (self = [super initForAutoLayout]) {
//         NSLog(@"%@", NSStringFromCGRect(self.bounds));
        self.distance = distance;
        self.imageView = [[UIImageView alloc] initForAutoLayout];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        
        self.shouldUsePercentage = NO;
        [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-distance, 0, -distance, 0)];
    }
    
    return self;
}

- (id)initForAutoLayoutWithParallaxPercentage:(CGFloat)percentage {
    if (self = [super initForAutoLayout]) {
        _percentage = percentage;
        self.shouldUsePercentage = YES;
        
        self.imageView = [[UIImageView alloc] initForAutoLayout];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame parallaxPercentage:(CGFloat)percentage {
    if (self = [super initWithFrame:frame]) {
        _percentage = percentage;
        
        self.imageView = [[UIImageView alloc] initForAutoLayout];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        self.shouldUsePercentage = YES;
        CGSize imageViewSize = self.frame.size;
        imageViewSize.height *= (1 + _percentage);
        imageViewSize.width *= 1;
        
        self.imageViewConstraints = [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-imageViewSize.height/2.0, 0, -imageViewSize.height/2.0, 0)];
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
    CGFloat yWiggleRoom;
    if (self.shouldUsePercentage) {
        yWiggleRoom = (CGRectGetHeight(self.bounds) * _percentage)/2.0;
    } else {
        yWiggleRoom = self.distance;
    }
    
    CGFloat yOffset = yOffsetBaseline + (yWiggleRoom * -imageOffsetFactor);
    if (isnan(yOffset)) {
        yOffset = 0;
    }
    
    CGRect frame = self.imageView.frame;
    frame.origin.y = yOffset;
    self.imageView.frame = frame;
}

- (void)layoutSubviews {
    if (self.shouldUsePercentage && !self.imageViewConstraints && CGRectGetHeight(self.bounds)) {
        CGSize imageViewSize = self.bounds.size;
        imageViewSize.height *= (1 + _percentage);
        imageViewSize.width *= 1;
        
        self.imageViewConstraints = [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-imageViewSize.height/2.0, 0, -imageViewSize.height/2.0, 0)];
    }
}


/*
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
    if (isnan(yOffset)) {
        yOffset = 0;
    }
    CGRect frame = self.imageView.frame;
    frame.origin.y = yOffset;
    self.imageView.frame = frame;
}
*/
/*
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setImageOffsetFactor:_imageOffsetFactor];
    
    for (NSLayoutConstraint *constraint in self.imageViewConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTop || constraint.firstAttribute == NSLayoutAttributeBottom) {
            CGSize imageViewSize = self.frame.size;
            imageViewSize.height *= (1 + _percentage);
            
            constraint.constant = imageViewSize.height/2.0;
        }
    }
}
 */
@end
