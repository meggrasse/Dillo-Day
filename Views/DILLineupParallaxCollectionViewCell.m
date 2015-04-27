//
//  DILLineupParallaxCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupParallaxCollectionViewCell.h"
#import "FMEParallaxPFImageView.h"

#import "NSDate+Utilities.h"
#import <UAProgressView/UAProgressView.h>
#import <DPMeterView/DPMeterView.h>

@interface DILLineupParallaxCollectionViewCell()
@property (strong, nonatomic) FMEParallaxPFImageView *parallaxImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *performanceTimeLabel;
@property (strong, nonatomic) UAProgressView *progressView;
@property (strong, nonatomic) DPMeterView *meterView;
@end

@implementation DILLineupParallaxCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.clipsToBounds = YES;

    [self addSubview:self.parallaxImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.performanceTimeLabel];


    [self.parallaxImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];


    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    CGFloat nameLabelInset = 20;
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:nameLabelInset relation:NSLayoutRelationGreaterThanOrEqual];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:nameLabelInset relation:NSLayoutRelationGreaterThanOrEqual];
    //    [self.nameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.favoriteButton withOffset:50 relation:NSLayoutRelationGreaterThanOrEqual];

    CGFloat verticalTextOffset = 0;
    [self.performanceTimeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
    [self.performanceTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:verticalTextOffset];


}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.numberOfLines = 1;
        _nameLabel.font = [UIFont boldSystemFontOfSize:50];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.minimumScaleFactor = 0.1;
        _nameLabel.layer.shadowOpacity = .70;
        _nameLabel.layer.shadowOffset = CGSizeZero;
        //        _nameLabel.backgroundColor = [UIColor blackColor];
    }
    return _nameLabel;
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

- (FMEParallaxPFImageView *)parallaxImageView {
    if (!_parallaxImageView) {
        _parallaxImageView = [[FMEParallaxPFImageView alloc] initWithFrame:CGRectZero parallaxOffsetType:FMEParallaxPFImageViewParallaxOffsetTypeProportional];
    }
    return _parallaxImageView;
}

- (UAProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UAProgressView alloc] initForAutoLayout];
        _progressView.tintColor = [DilloDayStyleKit artistInfoSegmentedControlSelectedSegmentIndicatorColor];
        _progressView.fillOnTouch = NO;
    }
    return _progressView;
}

- (void)setupProgressView {
    [self.contentView addSubview:self.progressView];

    CGFloat progressViewDimension = 50;
    [self.progressView autoSetDimensionsToSize:CGSizeMake(progressViewDimension, progressViewDimension)];
    [self.progressView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.progressView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)terminateProgressView {
    [self.progressView removeFromSuperview];
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
    [self.parallaxImageView addSubview:self.meterView];
    [self.meterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.meterView setProgress:0 animated:NO];
}

- (void)terminateMeterView {
    [self.meterView removeFromSuperview];
}


- (void)configureCellWithArtist:(DILPFArtist *)artist scrollView:(UIScrollView *)scrollView {
    self.nameLabel.text = [artist.name uppercaseString];

    self.performanceTimeLabel.text = [artist.performanceTime mediumTimeString];
    self.parallaxImageView.scrollView = scrollView;
    self.parallaxImageView.imageFile = artist.lineupImage;

//    [self setupProgressView];
    [self setupMeterView];
    [self.parallaxImageView loadInBackground:^(UIImage *image, NSError *error) {
//        [self terminateProgressView];
        [self terminateMeterView];
    } progressBlock:^(int percentDone) {
        [self.meterView setProgress:((float)percentDone)/100.0 animated:YES];
//        [self.progressView setProgress:((float)percentDone)/100.0 animated:YES];
    }];

}

- (void)prepareForReuse {
    self.parallaxImageView.imageFile = nil;
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
