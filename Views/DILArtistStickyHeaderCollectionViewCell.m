
//  DILArtistStickyHeaderCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistStickyHeaderCollectionViewCell.h"
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayoutAttributes.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSDate+Utilities.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface DILArtistStickyHeaderCollectionViewCell()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *circularImageView;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) NSMutableArray *circularImageViewLayoutConstraints;
@property (strong, nonatomic) UIView *backgroundImageViewTintView;
@end

static NSString *const kSegmentedControlBio     = @"BIO";
static NSString *const kSegmentedControlMusic   = @"MUSIC";

@implementation DILArtistStickyHeaderCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
        self.circularImageViewLayoutConstraints = [NSMutableArray new];
    }
    return self;
}

- (void)configureCell {
    self.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView addSubview:self.backgroundImageViewTintView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.segmentedControl];

    [self.backgroundImageViewTintView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self.segmentedControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    CGFloat segmentedControlHeight = 44;
    [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:segmentedControlHeight];

    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.backgroundImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl];

    [self addCircularImageView];

    CGFloat timeLabelInset = 10;
    [self.timeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.backgroundImageView withOffset:-timeLabelInset];
    [self.timeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.backgroundImageView withOffset:-timeLabelInset];}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
    }
    return _backgroundImageView;
}

- (UIImageView *)circularImageView {
    if (!_circularImageView) {
        _circularImageView = [[UIImageView alloc] initForAutoLayout];
        _circularImageView.contentMode = UIViewContentModeScaleAspectFill;
        _circularImageView.clipsToBounds = YES;
        _circularImageView.layer.shadowOpacity = 1;
        _circularImageView.layer.shadowOffset = CGSizeZero;
        _circularImageView.layer.shadowRadius = 10;

        [RACObserve(self, circularImageView.bounds) subscribeNext:^(NSNumber *bounds) {
            CGRect imageViewBounds = bounds.CGRectValue;
            _circularImageView.layer.cornerRadius = CGRectGetHeight(imageViewBounds)/2.0;
        }];
    }
    return _circularImageView;
}

- (void)removeCircularImageView {
    if (_circularImageView) {
        [self.circularImageView removeFromSuperview];
        _circularImageView = nil;
    }
}

- (void)addCircularImageView {
    [self.backgroundImageView addSubview:self.circularImageView];
    [self.circularImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImageView];
    [self.circularImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backgroundImageView];

    CGFloat inset = 60;
    [self.circularImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.backgroundImageView withOffset:-inset];
    [self.circularImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.circularImageView];
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _timeLabel;
}


- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[kSegmentedControlBio, kSegmentedControlMusic]];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsZero;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.backgroundColor = [DilloDayStyleKit artistInfoSegmentedControlBackgroundColor];
        _segmentedControl.selectionIndicatorColor = [DilloDayStyleKit artistInfoSegmentedControlSelectedSegmentIndicatorColor];
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *formattedTitleString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [DilloDayStyleKit artistInfoSegmentedControlTextColor], NSFontAttributeName : [UIFont boldFlatFontOfSize:18]}];
            return formattedTitleString;
        }];
        [_segmentedControl addTarget:self action:@selector(handleSegmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)handleSegmentedControlChange:(HMSegmentedControl *)sender {
    DILArtistInfoType type;
    NSString *selectedTitle = sender.sectionTitles[sender.selectedSegmentIndex];
    if ([selectedTitle isEqualToString:kSegmentedControlBio]) {
        type = DILArtistInfoTypeBio;
    } else if ([selectedTitle isEqualToString:kSegmentedControlMusic]) {
        type = DILArtistInfoTypeMusic;
    }
    [self.delegate displayArtistInfoType:type];
}

- (UIView *)backgroundImageViewTintView {
    if (!_backgroundImageViewTintView) {
        _backgroundImageViewTintView = [[UIView alloc] initForAutoLayout];
        _backgroundImageViewTintView.backgroundColor = [UIColor blackColor];
        _backgroundImageViewTintView.alpha = 0.20;
    }
    return _backgroundImageViewTintView;
}

- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {

}

#pragma mark - Public Methods
- (void)configureCellWithArtist:(DILPFArtist *)artist {
    [artist imageDownloadPromise].then(^(UIImage *image){
        self.circularImageView.image = image;
        self.backgroundImageView.image = image;
    });

    self.timeLabel.text = [artist.performanceTime mediumTimeString];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
