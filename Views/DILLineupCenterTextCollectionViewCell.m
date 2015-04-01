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

@interface DILLineupCenterTextCollectionViewCell()
@property (strong, nonatomic) DILPFArtist *artist;
@property (strong, nonatomic) UIImageView *artistImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *performanceTimeLabel;
@property (strong, nonatomic) UIButton *favoriteButton;
@property (strong, nonatomic) UIView *shadowView;
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
    self.shadowView = [[UIView alloc] initForAutoLayout];
    self.shadowView.layer.shadowOpacity = 1;
    self.shadowView.layer.shadowRadius = 1;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;;
    self.shadowView.layer.masksToBounds = NO;

    [self addSubview:self.artistImageView];
    [self addSubview:self.shadowView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.performanceTimeLabel];
    [self addSubview:self.favoriteButton];

    [self.artistImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.nameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.favoriteButton withOffset:50 relation:NSLayoutRelationGreaterThanOrEqual];

    CGFloat verticalTextOffset = 0;
    [self.performanceTimeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
    [self.performanceTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:verticalTextOffset];

    [self.favoriteButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    CGFloat favoriteButtonDimension = 30;
    [self.favoriteButton autoSetDimensionsToSize:CGSizeMake(favoriteButtonDimension, favoriteButtonDimension)];
    self.favoriteButton.layer.cornerRadius = favoriteButtonDimension/2.0;
    self.favoriteButton.clipsToBounds = YES;
    CGFloat favoriteButtonInset = 20;
    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:favoriteButtonInset];

    CGFloat shadowViewOffset = 5;
    [self.shadowView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.nameLabel withOffset:shadowViewOffset];
    [self.shadowView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel withOffset:shadowViewOffset];
    [self.shadowView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.nameLabel withOffset:shadowViewOffset];
    [self.shadowView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:shadowViewOffset];

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
//    self.artist.favorite = !self.artist.favorite;
//    [self.favoriteButton setImage:[self imageForFavoriteButton:self.artist.favorite] forState:UIControlStateNormal];
}

- (UIImage *)imageForFavoriteButton:(BOOL)favorite {
    UIImage *image;

    CGFloat imageDimension = 15;
    CGRect imageBounds = CGRectMake(0, 0, imageDimension, imageDimension);
    UIColor *imageColor = [UIColor whiteColor];
    if (favorite) {
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
//    [self.favoriteButton setImage:[self imageForFavoriteButton:self.artist.favorite] forState:UIControlStateNormal];
}

@end
