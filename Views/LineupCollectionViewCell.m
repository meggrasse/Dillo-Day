//
//  LineupCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "LineupCollectionViewCell.h"
#import "FMParallaxImageView.h"


@interface LineupCollectionViewCell()
@property (strong, nonatomic) FMParallaxImageView *artistImageView;
@property (strong, nonatomic) UILabel *artistLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *sponsorLabel;
@property (strong, nonatomic) UIView *hairlineView;
@end


@implementation LineupCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
//    _artistImageView = [[FMParallaxImageView alloc] initForAutoLayout];
    _artistImageView = [[FMParallaxImageView alloc] initWithFrame:CGRectZero parallaxPercentage:.40];
    _artistImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_artistImageView];
    _artistImageView.backgroundColor = [UIColor clearColor];
    _artistImageView.contentMode = UIViewContentModeScaleAspectFill;
    _artistImageView.clipsToBounds = YES;
    
    _artistLabel = [[UILabel alloc] initForAutoLayout];
    [self insertSubview:_artistLabel aboveSubview:_artistImageView];
    _artistLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
    _artistLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
//    _artistLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _artistLabel.font = [UIFont systemFontOfSize:20];
    _artistLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _artistLabel.numberOfLines = 0;
    
    _timeLabel = [[UILabel alloc] initForAutoLayout];
    [self insertSubview:_timeLabel aboveSubview:_artistImageView];
    _timeLabel.textColor = [[UIColor lightTextColor] colorWithAlphaComponent:0.75];
    _timeLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
//    _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    _timeLabel.font = [UIFont systemFontOfSize:20];
    _timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _timeLabel.numberOfLines = 0;
    
    _sponsorLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:_sponsorLabel];
    _sponsorLabel.textColor = [UIColor grayColor];
    _sponsorLabel.backgroundColor = [UIColor clearColor];
//    _sponsorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _sponsorLabel.font = [UIFont systemFontOfSize:14];
    _sponsorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _sponsorLabel.numberOfLines = 0;
    
    
    _hairlineView = [[UIView alloc] initForAutoLayout];
    [self addSubview:_hairlineView];
    _hairlineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.10];
    
  
    CGFloat edgeInset = 11;
    [_artistImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(edgeInset, edgeInset, edgeInset, edgeInset) excludingEdge:ALEdgeBottom];
    [_artistImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_sponsorLabel withOffset:-edgeInset];
    
    [_timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_artistImageView withOffset:edgeInset/2.0];
    [_timeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_artistImageView withOffset:edgeInset/2.0 relation:NSLayoutRelationLessThanOrEqual];
    [_timeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_artistImageView withOffset:-edgeInset/2.0];
    
    [_artistLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_artistImageView withOffset:edgeInset/2.0];
    [_artistLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_artistImageView withOffset:edgeInset/2.0 relation:NSLayoutRelationLessThanOrEqual];
    [_artistLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_timeLabel withOffset:-2];
    
    [_sponsorLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_artistImageView];
    [_sponsorLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_hairlineView withOffset:-edgeInset];
    [_sponsorLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_artistImageView withOffset:0 relation:NSLayoutRelationLessThanOrEqual];

    [_hairlineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_hairlineView autoSetDimension:ALDimensionHeight toSize:0.5];

    
     _timeLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 4 * edgeInset;
    _artistLabel.preferredMaxLayoutWidth = _timeLabel.preferredMaxLayoutWidth;
    _sponsorLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 2 * edgeInset;

}

- (void)setImageOffset:(CGPoint)imageOffset {
    _imageOffset = imageOffset;
    self.artistImageView.imageOffsetFactor = imageOffset.y;
//    NSLog(@"%@ image offset factor: \n%f", self.artistLabel.text, imageOffset.y);
    
//    CGRect frame = self.artistImageView.bounds;
//    CGRect offsetFrame = CGRectOffset(frame, 0, _imageOffset.y);
//    _artistImageView.frame = offsetFrame;
}

- (CGFloat)imageViewHeight {
    if (_artistImageView) {
        return CGRectGetHeight(_artistImageView.bounds);
    } else return 0;
}

- (void)setupCellWithArtist:(Artist *)artist {
    self.artistImageView.imageView.image = artist.bigImage;
    self.artistLabel.text = artist.name;
    self.timeLabel.text = artist.time;
    self.sponsorLabel.text = [NSString stringWithFormat:@"Sponsored by %@", artist.sponsor];
}

@end
