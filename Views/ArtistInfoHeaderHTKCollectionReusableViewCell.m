//
//  ArtistInfoHeaderHTKCollectionReusableViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoHeaderHTKCollectionReusableViewCell.h"
#import <FXBlurView/FXBlurView.h>

@interface ArtistInfoHeaderHTKCollectionReusableViewCell()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *circleImageView;
@property (strong, nonatomic) UILabel *artistLabel;
@end

@implementation ArtistInfoHeaderHTKCollectionReusableViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [UIColor grayColor];
    
    self.backgroundImageView = [[UIImageView alloc] initForAutoLayout];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.circleImageView = [[UIImageView alloc] initForAutoLayout];
    self.circleImageView.contentMode = UIViewContentModeScaleAspectFill;
    static CGFloat circleImageViewSize = 100;
    self.circleImageView.layer.cornerRadius = circleImageViewSize/2.0;
    self.circleImageView.layer.borderWidth = 1;
    self.circleImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.circleImageView.clipsToBounds = YES;
    
    self.artistLabel = [[UILabel alloc] initForAutoLayout];
    self.artistLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    self.artistLabel.backgroundColor = [UIColor blackColor];
    self.artistLabel.textColor = [UIColor whiteColor];
    self.artistLabel.numberOfLines = 0;
    self.artistLabel.textAlignment = NSTextAlignmentCenter;
    self.artistLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.contentView addSubview:self.backgroundImageView];
    
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    UIView *artistView = [[UIView alloc] initForAutoLayout];
    artistView.backgroundColor = [UIColor clearColor];
    
    [artistView addSubview:self.artistLabel];
    [artistView addSubview:self.circleImageView];
    
    [self.circleImageView autoSetDimensionsToSize:CGSizeMake(circleImageViewSize, circleImageViewSize)];
    [self.circleImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.circleImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.circleImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.circleImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.circleImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.artistLabel withOffset:-10];
    [self.artistLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.artistLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        [self.circleImageView autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        [self.circleImageView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        [artistView autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
        [artistView autoSetContentHuggingPriorityForAxis:ALAxisVertical];
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.artistLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    CGFloat artistViewWidth = DEFAULT_ARTIST_INFO_HEADER_CELL_SIZE.width - 50;
    self.artistLabel.preferredMaxLayoutWidth = artistViewWidth;
    [artistView autoSetDimension:ALDimensionWidth toSize:artistViewWidth relation:NSLayoutRelationLessThanOrEqual];
    
    [self.contentView insertSubview:artistView aboveSubview:self.backgroundImageView];
    [artistView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [artistView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [artistView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [artistView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
}

- (void)setupCellWithArtist:(Artist *)artist {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.backgroundImageView.image = [artist.bigImage blurredImageWithRadius:1 iterations:100 tintColor:[UIColor blackColor]];
    });
    self.circleImageView.image = artist.smallImage;
    self.artistLabel.text = artist.name;
}

@end
