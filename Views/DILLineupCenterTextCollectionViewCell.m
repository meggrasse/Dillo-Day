//
//  DILLineupCenterTextCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCenterTextCollectionViewCell.h"
#import "NSDate+Utilities.h"
#import "Artist.h"
#import <FontasticIcons/FontasticIcons.h>
#import "DILFollowArtist.h"

@interface DILLineupCenterTextCollectionViewCell()
@property (strong, nonatomic) DILPFArtist *artist;
@property (strong, nonatomic) UIImageView *artistImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *performanceTimeLabel;
@property (strong, nonatomic) UIButton *favoriteButton;
@property (strong, nonatomic) UILabel *sponsorLabel;
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
    [self addSubview:self.nameLabel];
    [self addSubview:self.performanceTimeLabel];
    [self addSubview:self.favoriteButton];
    [self addSubview:self.sponsorLabel];

    [self.artistImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.nameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.favoriteButton withOffset:50 relation:NSLayoutRelationGreaterThanOrEqual];

    CGFloat verticalTextOffset = 0;
    [self.performanceTimeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
    [self.performanceTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:verticalTextOffset];

    CGFloat sponsorLabelInset = 5;
    [self.sponsorLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:sponsorLabelInset];
    [self.sponsorLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sponsorLabelInset];

    [self.favoriteButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    CGFloat favoriteButtonDimension = 30;
    [self.favoriteButton autoSetDimensionsToSize:CGSizeMake(favoriteButtonDimension, favoriteButtonDimension)];
    self.favoriteButton.layer.cornerRadius = favoriteButtonDimension/2.0;
    self.favoriteButton.clipsToBounds = YES;
    CGFloat favoriteButtonInset = 20;
    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:favoriteButtonInset];


}

- (UIImageView *)artistImageView {
    if (!_artistImageView) {
        _artistImageView = [[UIImageView alloc] initForAutoLayout];
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

- (void)handleFavoriteButtonTapped:(UIButton *)sender {
    DILFollowArtist *followArtistResult = [DILFollowArtist objectForPrimaryKey:self.artist.objectId];

    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    if (!followArtistResult) {
        followArtistResult = [[DILFollowArtist alloc] init];
        followArtistResult.artistObjectId = self.artist.objectId;
        followArtistResult.follow = NO;
        [defaultRealm addObject:followArtistResult];
    }
    followArtistResult.follow = !followArtistResult.follow;
    [defaultRealm commitWriteTransaction];

    [self.favoriteButton setImage:[self followImageForArtist:self.artist] forState:UIControlStateNormal];
}

- (UIImage *)followImageForArtist:(DILPFArtist *)artist {
    UIImage *image;
    CGFloat imageDimension = 15;
    CGRect imageBounds = CGRectMake(0, 0, imageDimension, imageDimension);
    UIColor *imageColor = [UIColor whiteColor];

    DILFollowArtist *followArtistResult = [DILFollowArtist objectForPrimaryKey:artist.objectId];
    if (followArtistResult && followArtistResult.follow) {
        image = [[FIIconicIcon heartFillIcon] imageWithBounds:imageBounds color:imageColor];
    } else {
        image = [[FIIconicIcon plusIcon] imageWithBounds:imageBounds color:imageColor];
    }
    return image;
}

#pragma mark - Public Methods
- (void)configureCellWithArtist:(DILPFArtist *)artist {
    self.artist = artist;
    
    [artist imageDownloadPromise].then(^(UIImage *image){
        self.artistImageView.image = image;
    });

    self.nameLabel.text = artist.name;
    self.performanceTimeLabel.text = [artist.performanceTime mediumTimeString];
    if (artist.sponsor.name) {
        self.sponsorLabel.text = [NSString stringWithFormat:@"Sponsored by %@", artist.sponsor.name];
    }

    [self.favoriteButton setImage:[self followImageForArtist:artist] forState:UIControlStateNormal];
}

@end
