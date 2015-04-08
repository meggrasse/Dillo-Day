//
//  DILNotificationHTKTableViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationHTKTableViewCell.h"
#import <FontasticIcons/FontasticIcons.h>

@interface DILNotificationHTKTableViewCell()
@property (strong, nonatomic) UILabel *notificationMessageLabel;
@property (strong, nonatomic) UIImageView *unreadImageView;
@property (strong, nonatomic) UILabel *notificationTimeLabel;
@end

@implementation DILNotificationHTKTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

    [self.contentView addSubview:self.notificationMessageLabel];
    [self.contentView addSubview:self.unreadImageView];
    [self.contentView addSubview:self.notificationTimeLabel];


    CGFloat unreadInset = 20;
    CGFloat unreadDimension = 20;
    [self.unreadImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:unreadInset];
    [self.unreadImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.unreadImageView autoSetDimensionsToSize:CGSizeMake(unreadDimension, unreadDimension)];

    CGFloat horizontalInset = 10;
    [self.notificationMessageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.unreadImageView withOffset:unreadInset];
    [self.notificationMessageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizontalInset relation:NSLayoutRelationGreaterThanOrEqual];
    [self.notificationMessageLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:unreadInset relation:NSLayoutRelationGreaterThanOrEqual];
    self.notificationMessageLabel.preferredMaxLayoutWidth = [DILNotificationHTKTableViewCell defaultCellSize].width - 2 * unreadInset - horizontalInset - unreadDimension;

    CGFloat verticalTextOffset = 1;
    [self.notificationTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.notificationMessageLabel];
    [self.notificationTimeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.notificationMessageLabel withOffset:verticalTextOffset];
    [self.notificationTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:unreadInset relation:NSLayoutRelationGreaterThanOrEqual];

    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.notificationMessageLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];

    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.notificationMessageLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
}

- (UILabel *)notificationMessageLabel {
    if (!_notificationMessageLabel) {
        _notificationMessageLabel = [[UILabel alloc] initForAutoLayout];
        _notificationMessageLabel.numberOfLines = 0;
        _notificationMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _notificationMessageLabel;
}

- (UILabel *)notificationTimeLabel {
    if (!_notificationTimeLabel) {
        _notificationTimeLabel = [[UILabel alloc] initForAutoLayout];
        _notificationTimeLabel.numberOfLines = 1;
        _notificationTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _notificationTimeLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _notificationTimeLabel;
}


- (UIImageView *)unreadImageView {
    if (!_unreadImageView) {
        _unreadImageView = [[UIImageView alloc] initForAutoLayout];
        _unreadImageView.contentMode = UIViewContentModeScaleAspectFill;
        _unreadImageView.clipsToBounds = YES;
//        _unreadImageView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.3];
    }
    return _unreadImageView;
}

- (UIImage *)imageForUnreadImageView {
    NSUInteger r = arc4random_uniform(2);
    UIImage *image;
    CGFloat imageDimension = 20;
    CGRect imageBounds = CGRectMake(0, 0, imageDimension, imageDimension);
    UIColor *imageColor = [UIColor blackColor];
    if (r) {
        image = [[FIFontAwesomeIcon circleIcon] imageWithBounds:imageBounds color:imageColor];
    } else {
        image = [[FIFontAwesomeIcon circleBlankIcon] imageWithBounds:imageBounds color:imageColor];
    }
    return image;
}

#pragma mark - Public Methods
+ (CGSize)defaultCellSize {
    return CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 85);
}

- (void)configureCellWithNotification:(Notification *)notification {
    self.notificationMessageLabel.text = notification.message;
    self.notificationTimeLabel.text = @"Just now";
    self.imageView.image = [self imageForUnreadImageView];

}
@end