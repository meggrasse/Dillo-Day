//
//  DILLineupCenterTextCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCenterTextCollectionViewCell.h"

#import "DILLineupCenterTextCollectionViewCellRadialShadowView.h"


#import "NSDate+Utilities.h"
#import <ParseUI/ParseUI.h>
#import <UAProgressView/UAProgressView.h>

@interface DILLineupCenterTextCollectionViewCell()
@property (strong, nonatomic) DILPFArtist *artist;
@property (strong, nonatomic) PFImageView *artistImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *performanceTimeLabel;
@property (strong, nonatomic) UIButton *favoriteButton;
@property (strong, nonatomic) UILabel *sponsorLabel;
@property (strong, nonatomic) UAProgressView *progressView;
@property (strong, nonatomic) DILLineupCenterTextCollectionViewCellRadialShadowView *shadowView;
@end

@implementation DILLineupCenterTextCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.clipsToBounds = YES;

    [self addSubview:self.artistImageView];
    [self addSubview:self.shadowView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.performanceTimeLabel];
//    [self addSubview:self.favoriteButton];
    [self addSubview:self.sponsorLabel];

    [self.artistImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self.shadowView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [self.nameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.favoriteButton withOffset:50 relation:NSLayoutRelationGreaterThanOrEqual];

    CGFloat verticalTextOffset = 0;
    [self.performanceTimeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
    [self.performanceTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:verticalTextOffset];

    CGFloat sponsorLabelInset = 5;
    [self.sponsorLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:sponsorLabelInset];
    [self.sponsorLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sponsorLabelInset];

//    [self.favoriteButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    CGFloat favoriteButtonDimension = 30;
//    [self.favoriteButton autoSetDimensionsToSize:CGSizeMake(favoriteButtonDimension, favoriteButtonDimension)];
//    self.favoriteButton.layer.cornerRadius = favoriteButtonDimension/2.0;
//    self.favoriteButton.clipsToBounds = YES;
//    CGFloat favoriteButtonInset = 20;
//    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:favoriteButtonInset];


}

- (PFImageView *)artistImageView {
    if (!_artistImageView) {
        _artistImageView = [[PFImageView alloc] initForAutoLayout];
        _artistImageView.contentMode = UIViewContentModeScaleAspectFill;
        _artistImageView.clipsToBounds = YES;
    }
    return _artistImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont boldSystemFontOfSize:50];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.backgroundColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)sponsorLabel {
    if (!_sponsorLabel) {
        _sponsorLabel = [[UILabel alloc] initForAutoLayout];
        _sponsorLabel.numberOfLines = 1;
        _sponsorLabel.font = [UIFont systemFontOfSize:12];
        _sponsorLabel.textColor = [UIColor whiteColor];
        _sponsorLabel.textAlignment = NSTextAlignmentRight;
        //        _nameLabel.backgroundColor = [UIColor blackColor];
    }
    return _sponsorLabel;
}

- (UILabel *)performanceTimeLabel {
    if (!_performanceTimeLabel) {
        _performanceTimeLabel = [[UILabel alloc] initForAutoLayout];
        _performanceTimeLabel.numberOfLines = 1;
        _performanceTimeLabel.font = [UIFont systemFontOfSize:20];
        _performanceTimeLabel.textColor = [UIColor whiteColor];
        _performanceTimeLabel.textAlignment = NSTextAlignmentCenter;
//        _performanceTimeLabel.backgroundColor = [UIColor blackColor];
    }
    return _performanceTimeLabel;
}

- (UIButton *)favoriteButton {
    if (!_favoriteButton) {
        _favoriteButton = [[UIButton alloc] initForAutoLayout];
        [_favoriteButton addTarget:self action:@selector(handleFavoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _favoriteButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return _favoriteButton;
}

- (DILLineupCenterTextCollectionViewCellRadialShadowView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[DILLineupCenterTextCollectionViewCellRadialShadowView alloc] initForAutoLayout];
        _shadowView.backgroundColor = [UIColor clearColor];
    }
    return _shadowView;
}

- (void)handleFavoriteButtonTapped:(UIButton *)sender {
    self.artist.artistAlerts = !self.artist.artistAlerts;
    [self.favoriteButton setImage:[self followImageForArtist:self.artist] forState:UIControlStateNormal];
}

- (UIImage *)followImageForArtist:(DILPFArtist *)artist {
    UIImage *image;
//    CGFloat imageDimension = 15;
//    CGRect imageBounds = CGRectMake(0, 0, imageDimension, imageDimension);
//    UIColor *imageColor = [UIColor whiteColor];

    if (self.artist.artistAlerts) {
        image = [UIImage imageNamed:@"Check without bg"];
    } else {
        image = [UIImage imageNamed:@"Add without bg"];
    }
    return image;
}

- (UAProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UAProgressView alloc] initForAutoLayout];
        _progressView.tintColor = [UIColor whiteColor];
        _progressView.fillOnTouch = NO;
    }
    return _progressView;
}

- (void)setupProgressView {
    [self.artistImageView addSubview:self.progressView];

    CGFloat progressViewDimension = 50;
    [self.progressView autoSetDimensionsToSize:CGSizeMake(progressViewDimension, progressViewDimension)];
    [self.progressView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.progressView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)terminateProgressView {
    [self.progressView removeFromSuperview];
}

@end
