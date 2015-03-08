//
//  ArtistInfoAboutHTKCollectionViewCel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoAboutHTKCollectionViewCell.h"
@interface ArtistInfoAboutHTKCollectionViewCell()
@property (strong, nonatomic) UILabel *aboutLabel;
@end

@implementation ArtistInfoAboutHTKCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [UIColor whiteColor];
    
    self.aboutLabel = [[UILabel alloc] initForAutoLayout];
    self.aboutLabel.numberOfLines = 0;
    self.aboutLabel.textAlignment = NSTextAlignmentJustified;
    self.aboutLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.aboutLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
    self.aboutLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.aboutLabel];
    
    [self.aboutLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.aboutLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.aboutLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    self.aboutLabel.preferredMaxLayoutWidth = DEFAULT_ARTIST_INFO_ABOUT_CELL_SIZE.width - 2*5;
}

- (void)setupCelWithArtist:(Artist *)artist {
    self.aboutLabel.text = artist.aboutText;
}

@end
