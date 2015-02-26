//
//  ArtistInfoVideoHTKCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoVideoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ArtistInfoVideoCollectionViewCell()
@property (strong, nonatomic) UIImageView *videoThumbnail;
@property (strong, nonatomic) UILabel *videoName;
@end


@implementation ArtistInfoVideoCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.clipsToBounds = YES;
    
    self.videoThumbnail = [[UIImageView alloc] initForAutoLayout];
    self.videoThumbnail.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    self.videoThumbnail.contentMode = UIViewContentModeScaleAspectFill;
    self.videoThumbnail.clipsToBounds = YES;
    
    self.videoName = [[UILabel alloc] initForAutoLayout];
    self.videoName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.videoName.backgroundColor = [UIColor blackColor];
    self.videoName.textColor = [UIColor whiteColor];
    self.videoName.numberOfLines = 2;
    self.videoName.textAlignment = NSTextAlignmentLeft;
    self.videoName.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [self addSubview:self.videoThumbnail];
    [self insertSubview:self.videoName aboveSubview:self.videoThumbnail];
    
    [self.videoThumbnail autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.videoName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.videoName autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.videoName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
}
- (void)setupCellWithVideo:(XCDYouTubeVideo *)video {
    self.videoName.text = video.title;
    [self.videoThumbnail sd_setImageWithURL:video.mediumThumbnailURL placeholderImage:[UIImage imageNamed:@"DillogoSharpLarge"] options:0];
}




@end
