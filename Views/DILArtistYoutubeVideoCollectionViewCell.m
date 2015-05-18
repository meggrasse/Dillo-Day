//
//  DILArtistYoutubeVideoCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistYoutubeVideoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ParseUI.h"
#import "DPMeterView.h"

@interface DILArtistYoutubeVideoCollectionViewCell()
@property (strong, nonatomic) PFImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *titleBackgroundView;
@property (strong, nonatomic) DPMeterView *meterView;
@end

@implementation DILArtistYoutubeVideoCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    [self.contentView addSubview:self.thumbnailImageView];
    [self.contentView addSubview:self.titleBackgroundView];
    [self.titleBackgroundView addSubview:self.titleLabel];

    [self.thumbnailImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.titleBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.titleBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.titleBackgroundView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

- (UIImageView *)thumbnailImageView {
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[PFImageView alloc] initForAutoLayout];
        _thumbnailImageView.clipsToBounds = YES;
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _thumbnailImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [DilloDayStyleKit artistInfoMusicVideoTitleTextColor];
    }
    return _titleLabel;
}

- (UIView *)titleBackgroundView {
    if (!_titleBackgroundView) {
        _titleBackgroundView = [[UIView alloc] initForAutoLayout];
        _titleBackgroundView.backgroundColor = [DilloDayStyleKit artistInfoMusicVideoTitleBackgroundColor];
    }
    return _titleBackgroundView;
}


- (void)configureCellWithVideo:(XCDYouTubeVideo *)video {
    [self.thumbnailImageView sd_setImageWithURL:video.mediumThumbnailURL];
    self.titleLabel.text = [video.title uppercaseString];
}

- (void)configureCellWithDILPFYoutubeVideo:(DILPFYoutubeVideo *)video {
	self.titleLabel.text = [video.title uppercaseString];
	self.thumbnailImageView.file = video.thumbnail;
	[self setupMeterView];
	[self.thumbnailImageView loadInBackground:^(UIImage *image, NSError *error) {
		[self terminateMeterView];
	} progressBlock:^(int percentDone) {
		[self.meterView setProgress:((float)percentDone)/100.0 animated:YES];
	}];
}

- (DPMeterView *)meterView {
	if (!_meterView) {
		_meterView = [[DPMeterView alloc] initForAutoLayout];
		_meterView.meterType = DPMeterTypeLinearHorizontal;
		_meterView.trackTintColor = [UIColor whiteColor];
		_meterView.progressTintColor = [DilloDayStyleKit lineupCellProgressColor];
	}
	return _meterView;
}

- (void)setupMeterView {
	[self.thumbnailImageView addSubview:self.meterView];
	[self.meterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
	[self.meterView setProgress:0 animated:NO];
}

- (void)terminateMeterView {
	[self.meterView removeFromSuperview];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
