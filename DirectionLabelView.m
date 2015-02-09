//
//  DirectionLabelView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DirectionLabelView.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@interface DirectionLabelView()
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *overlayView;
@property (copy)void (^tapBlock)(void);
@end


@implementation DirectionLabelView
- (id)initWithTitle:(NSString *)title image:(UIImage *)image onTap:(void (^)(void))tapBlock {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat imageDimension = 40.;
    CGFloat padding = 1;
    CGFloat frameWidth = imageDimension + labelSize.width + padding;
    CGRect frame = CGRectMake(0, 0, frameWidth, MAX(labelSize.height, imageDimension));
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds)-labelSize.height)/2.0, labelSize.width, labelSize.height)];
        label.font = font;
        label.text = title;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        self.label = label;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.label.bounds)+padding,  (CGRectGetHeight(self.bounds)-imageDimension)/2.0, imageDimension, imageDimension)];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView = imageView;
        
        self.tapBlock = tapBlock;
        UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        overlayView.backgroundColor = [UIColor clearColor];
        [overlayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)]];
//        [overlayView addGestureRecognizer:[UITapGestureRecognizer bk_performBlock:^{
//            if (tapBlock) {
//                tapBlock();
//            }
//        } afterDelay:0]];
        
        self.overlayView = overlayView;
        self.overlayView.userInteractionEnabled = YES;
        
        [self addSubview:self.label];
        [self addSubview:self.imageView];
        [self addSubview:self.overlayView];
    }
    return self;
}

- (void)handleTap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}
@end