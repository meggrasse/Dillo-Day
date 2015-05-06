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

    [self.contentView addSubview:self.parallaxImageView];

    UIView *centeredTextView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:centeredTextView];

    [centeredTextView addSubview:self.nameLabel];
    [centeredTextView addSubview:self.performanceTimeLabel];


    [self.parallaxImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [centeredTextView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [centeredTextView autoAlignAxisToSuperviewAxis:ALAxisVertical];

    CGFloat centeredTextViewInset = 20.f;
//    [centeredTextView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(centeredTextViewInset, centeredTextViewInset, centeredTextViewInset, centeredTextViewInset)];
    [centeredTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:centeredTextViewInset relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:centeredTextViewInset relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:centeredTextViewInset relation:NSLayoutRelationGreaterThanOrEqual];
    [centeredTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:centeredTextViewInset relation:NSLayoutRelationGreaterThanOrEqual];


//    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    CGFloat nameLabelInset = 20;
//    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:nameLabelInset relation:NSLayoutRelationGreaterThanOrEqual];
//    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:nameLabelInset relation:NSLayoutRelationGreaterThanOrEqual];
//    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    CGFloat verticalTextOffset = 0;
    [self.performanceTimeLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.performanceTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.performanceTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.performanceTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
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
        _performanceTimeLabel.font = [UIFont boldFlatFontOfSize:20];
        _performanceTimeLabel.textColor = [UIColor whiteColor];
        _performanceTimeLabel.textAlignment = NSTextAlignmentCenter;
        _performanceTimeLabel.adjustsFontSizeToFitWidth = YES;
        _performanceTimeLabel.minimumScaleFactor = 0.1;
        _performanceTimeLabel.layer.shadowOpacity = .70;
        _performanceTimeLabel.layer.shadowOffset = CGSizeZero;
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

//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"hh:mm"];
//    formatter.timeZone = [NSTimeZone time]
//    NSString *timeString = [formatter stringFromDate:artist.performanceTime];

    self.performanceTimeLabel.text = [artist.performanceTime shortTimeString];
//    self.performanceTimeLabel.text = artist.objectId;
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
    self.nameLabel.text = self.performanceTimeLabel.text = @"";
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
