//
//  DILArtistYoutubeVideoCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistYoutubeVideoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DILArtistYoutubeVideoCollectionViewCell()
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation DILArtistYoutubeVideoCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    [self addSubview:self.thumbnailImageView];
    [self addSubview:self.titleLabel];

    [self.thumbnailImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (UIImageView *)thumbnailImageView {
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc] initForAutoLayout];
        _thumbnailImageView.clipsToBounds = YES;
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _thumbnailImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _titleLabel;
}

- (void)configureCellWithVideo:(XCDYouTubeVideo *)video {
    [self.thumbnailImageView sd_setImageWithURL:video.mediumThumbnailURL];
    self.titleLabel.text = video.title;
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
