//
//  DILArtistSponsorCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/24/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistSponsorCollectionViewCell.h"
#import <ParseUI/ParseUI.h>
#import <UAProgressView/UAProgressView.h>

@interface DILArtistSponsorCollectionViewCell()
@property (strong, nonatomic) UILabel *sponsoredByLabel;
@property (strong, nonatomic) PFImageView *sponsorLogoImageView;
@property (strong, nonatomic) UAProgressView *progressView;
@end


@implementation DILArtistSponsorCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}


- (void)configureCell {
    UIView *centeredView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:centeredView];

    [centeredView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [centeredView autoAlignAxisToSuperviewAxis:ALAxisVertical];

    [centeredView addSubview:self.sponsoredByLabel];
    [centeredView addSubview:self.sponsorLogoImageView];

    [self.sponsoredByLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTrailing];
    [self.sponsorLogoImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeading];
    [self.sponsoredByLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.sponsorLogoImageView withOffset:-5];

    CGFloat sponsorLogoImageViewDimension = 200;
    [self.sponsorLogoImageView autoSetDimension:ALDimensionHeight toSize:sponsorLogoImageViewDimension];
}

- (UILabel *)sponsoredByLabel {
    if (!_sponsoredByLabel) {
        _sponsoredByLabel = [[UILabel alloc] initForAutoLayout];
        _sponsoredByLabel.numberOfLines = 1;
        _sponsoredByLabel.text = @"SPONSORED BY:";
        _sponsoredByLabel.adjustsFontSizeToFitWidth = YES;
        _sponsoredByLabel.minimumScaleFactor = 0.1;
        _sponsoredByLabel.textColor = [DilloDayStyleKit artistInfoSponsoredByTextColor];
        _sponsoredByLabel.font = [UIFont boldFlatFontOfSize:20];
    }
    return _sponsoredByLabel;
}

- (PFImageView *)sponsorLogoImageView {
    if (!_sponsorLogoImageView) {
        _sponsorLogoImageView = [[PFImageView alloc] initForAutoLayout];
    }
    return _sponsorLogoImageView;
}

- (UAProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UAProgressView alloc] initForAutoLayout];
        _progressView.tintColor = [UIColor whiteColor];
        _progressView.fillOnTouch = NO;
    }
    return _progressView;
}

- (void)terminateProgressView {
    [self.progressView removeFromSuperview];
}

- (void)configureCellWithSponsor:(DILPFSponsor *)sponsor {
    self.sponsorLogoImageView.file = sponsor.sponsorLogo;
    [self.sponsorLogoImageView loadInBackground:^(UIImage *image, NSError *error) {
        [self terminateProgressView];
        if (image) {
            CGFloat imageAspectRatio = image.size.width/image.size.height;
            [self.sponsorLogoImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.sponsorLogoImageView withMultiplier:imageAspectRatio];
        }
    } progressBlock:^(int percentDone) {
        [self.progressView setProgress:((float)percentDone)/100.0 animated:YES];
    }];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
