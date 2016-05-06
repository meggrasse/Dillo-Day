//
//  DILArtistBioHTKCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/3/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistBioHTKCollectionViewCell.h"
@interface DILArtistBioHTKCollectionViewCell()
@property (strong, nonatomic) UILabel *bioLabel;
@end

@implementation DILArtistBioHTKCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bioLabel];

    CGFloat bioLabelInset = 5;
    [self.bioLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(bioLabelInset, bioLabelInset, bioLabelInset, bioLabelInset)];

//    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//        [self.bioLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//    }];
//
//    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
//        [self.bioLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//    }];

    self.bioLabel.preferredMaxLayoutWidth = [[self class] defaultSize].width - 2*bioLabelInset;
}

- (UILabel *)bioLabel {
    if (!_bioLabel) {
        _bioLabel = [[UILabel alloc] initForAutoLayout];
        _bioLabel.numberOfLines = 0;
        _bioLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _bioLabel;
}

- (void)configureCellWithArtist:(DILPFArtist *)artist {
    self.bioLabel.text = artist.about;
}

+ (CGSize)defaultSize {
    return CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20, 50);
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
