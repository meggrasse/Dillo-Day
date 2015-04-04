
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
#import <NYSegmentedControl/NYSegmentedControl.h>

@interface DILArtistStickyHeaderCollectionViewCell()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *circularImageView;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) NYSegmentedControl *segmentedControl;
@end

static NSString *const kSegmentedControlBio     = @"BIO";
static NSString *const kSegmentedControlMusic   = @"MUSIC";

@implementation DILArtistStickyHeaderCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.circularImageView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.segmentedControl];

    [self.segmentedControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    CGFloat segmentedControlHeight = 44;
    [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:segmentedControlHeight];

    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.backgroundImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl];

    [self.circularImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImageView];
    [self.circularImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backgroundImageView];
//    CGFloat circularImageVieWDimension = 100;
    [self.circularImageView autoSetDimension:ALDimensionHeight toSize:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.circularImageView autoSetDimension:ALDimensionWidth toSize:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.circularImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.circularImageView];
    CGFloat circularImageViewInset = 30;
//    [self.circularImageView autoSetDimensionsToSize:CGSizeMake(circularImageViewInset, circularImageViewInset)];
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.circularImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.backgroundImageView withOffset:circularImageViewInset relation:NSLayoutRelationGreaterThanOrEqual];
        [self.circularImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.backgroundImageView withOffset:-circularImageViewInset relation:NSLayoutRelationGreaterThanOrEqual];

    }];

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

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _timeLabel;
}

- (NYSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[NYSegmentedControl alloc] initForAutoLayout];
        [_segmentedControl insertSegmentWithTitle:kSegmentedControlBio atIndex:0];
        [_segmentedControl insertSegmentWithTitle:kSegmentedControlMusic atIndex:1];
        [_segmentedControl addTarget:self action:@selector(handleSegmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)handleSegmentedControlChange:(UISegmentedControl *)sender {
    DILArtistInfoType type;
    NSString *selectedTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    if ([selectedTitle isEqualToString:kSegmentedControlBio]) {
        type = DILArtistInfoTypeBio;
    } else if ([selectedTitle isEqualToString:kSegmentedControlMusic]) {
        type = DILArtistInfoTypeMusic;
    }
    [self.delegate displayArtistInfoType:type];
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
