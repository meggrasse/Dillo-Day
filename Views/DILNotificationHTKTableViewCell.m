//
//  DILNotificationHTKTableViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationHTKTableViewCell.h"
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>
#import "NSDate+Utilities.h"

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
    self.backgroundColor = [DilloDayStyleKit notificationCellBackgroundColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

    [self.contentView addSubview:self.notificationMessageLabel];
    [self.contentView addSubview:self.unreadImageView];
    [self.contentView addSubview:self.notificationTimeLabel];


    CGFloat unreadInset = 20;
    CGFloat unreadDimension = 25;
    [self.unreadImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:unreadInset];
    [self.unreadImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.unreadImageView autoSetDimensionsToSize:CGSizeMake(unreadDimension, unreadDimension)];

    CGFloat horizontalInset = 20;
    [self.notificationMessageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.unreadImageView withOffset:unreadInset];
    [self.notificationMessageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizontalInset relation:NSLayoutRelationGreaterThanOrEqual];
    [self.notificationMessageLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:unreadInset relation:NSLayoutRelationGreaterThanOrEqual];
    self.notificationMessageLabel.preferredMaxLayoutWidth = [DILNotificationHTKTableViewCell defaultCellSize].width - 2 * unreadInset - horizontalInset - unreadDimension;

    CGFloat verticalTextOffset = -1;
    [self.notificationTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.notificationMessageLabel];
    [self.notificationTimeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.notificationMessageLabel withOffset:verticalTextOffset];
    [self.notificationTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:unreadInset relation:NSLayoutRelationGreaterThanOrEqual];
}

- (UILabel *)notificationMessageLabel {
    if (!_notificationMessageLabel) {
        _notificationMessageLabel = [[UILabel alloc] initForAutoLayout];
        _notificationMessageLabel.numberOfLines = 0;
        _notificationMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _notificationMessageLabel.font = [UIFont systemFontOfSize:16];
        _notificationMessageLabel.textColor = [DilloDayStyleKit notificationCellMessageTextColor];
    }
    return _notificationMessageLabel;
}

- (UILabel *)notificationTimeLabel {
    if (!_notificationTimeLabel) {
        _notificationTimeLabel = [[UILabel alloc] initForAutoLayout];
        _notificationTimeLabel.numberOfLines = 1;
        _notificationTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _notificationTimeLabel.font = [UIFont fontWithName:@"SourceSansPro-Light" size:13];
        _notificationTimeLabel.textColor = [DilloDayStyleKit notificationCellTimeAgoTextColor];
    }
    return _notificationTimeLabel;
}


- (UIImageView *)unreadImageView {
    if (!_unreadImageView) {
        _unreadImageView = [[UIImageView alloc] initForAutoLayout];
        _unreadImageView.contentMode = UIViewContentModeScaleAspectFit;
        _unreadImageView.clipsToBounds = YES;
    }
    return _unreadImageView;
}

- (UIImage *)imageForUnreadImageView:(BOOL)unread {
    UIImage *image;
    if (unread) {
        image = [DilloDayStyleKit imageOfNotificationIndicatorUnread];
    } else {
        image = [DilloDayStyleKit imageOfNotificationIndicatorRead];
    }
    return image;
}

#pragma mark - Public Methods
+ (CGSize)defaultCellSize {
    return CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 85);
}


- (void)configureCellWithNotification:(DILNotification *)notification {
    self.notificationMessageLabel.text = notification.alert;
    self.notificationTimeLabel.text = [notification.dateRecieved dateTimeAgo];
    self.unreadImageView.image = [self imageForUnreadImageView:notification.unread];
}
@end
