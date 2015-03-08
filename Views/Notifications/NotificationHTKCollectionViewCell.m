//
//  NotificationHTKCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "NotificationHTKCollectionViewCell.h"
@interface NotificationHTKCollectionViewCell()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIView *hairlineView;
@end

@implementation NotificationHTKCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    
    return self;
}

- (void)setupCell {
    self.imageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.messageLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.messageLabel];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentJustified;
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageLabel.textColor = [UIColor blackColor];
    self.messageLabel.font = [UIFont systemFontOfSize:18];
    
    self.hairlineView  = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:self.hairlineView];
    self.hairlineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    
    [self.messageLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) excludingEdge:ALEdgeLeft];
    [self.messageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imageView withOffset:10];
    [self.hairlineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.hairlineView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    
    CGFloat inset = 10.f;
    CGFloat imageViewSize = 20;
    
    [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:inset];
    [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.imageView autoSetDimensionsToSize:CGSizeMake(imageViewSize, imageViewSize)];
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.messageLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.messageLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    self.messageLabel.preferredMaxLayoutWidth = DEFAULT_NOTIFICATION_CELL_SIZE.width - 3 * 10 - imageViewSize;
 

}

- (void)setupCellWithNotification:(Notification *)notification {
    self.imageView.image = notification.image;
    self.messageLabel.text = notification.message;
}

@end
