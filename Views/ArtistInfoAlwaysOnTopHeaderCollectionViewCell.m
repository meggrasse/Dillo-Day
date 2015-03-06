//
//  ArtistInfoAlwaysOnTopHeaderCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoAlwaysOnTopHeaderCollectionViewCell.h"
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayoutAttributes.h>
#import <NYSegmentedControl/NYSegmentedControl.h>
#import <FXBlurView/FXBlurView.h>
#import "UIView+FindUIViewController.h"

@interface ArtistInfoAlwaysOnTopHeaderCollectionViewCell()

@property (strong, nonatomic) UIImageView *artistImageView;
@property (strong, nonatomic) UILabel *artistLabel;
@property (strong, nonatomic) UIView *itemView;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) NYSegmentedControl *segmentedControl;
@property (strong, nonatomic) UIView *navigationBarConnector;

@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIImage *shadowBarImage;
@end


@implementation ArtistInfoAlwaysOnTopHeaderCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}


- (void)setupCell {
    self.viewController = [self firstAvailableUIViewController];
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;

    self.backgroundImageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.backgroundImageView];
    self.backgroundImageView.clipsToBounds = YES;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.itemView = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.itemView];
    self.itemView.backgroundColor = [UIColor clearColor];
    
    self.navigationBarConnector = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.navigationBarConnector];
//    self.navigationBarConnector.backgroundColor = self.viewController.navigationController.navigationBar.backgroundColor;
    self.navigationBarConnector.backgroundColor = [UIColor whiteColor];
    self.navigationBarConnector.alpha = 0;
    
    self.segmentedControl = [[NYSegmentedControl alloc] initForAutoLayout];
    [self addSubview:self.segmentedControl];
    [self.segmentedControl insertSegmentWithTitle:@"About" atIndex:0];
    [self.segmentedControl insertSegmentWithTitle:@"Music" atIndex:1];
    [self.segmentedControl insertSegmentWithTitle:@"Misc" atIndex:2];
    
    self.artistImageView = [[UIImageView alloc] initForAutoLayout];
    [self.itemView addSubview:self.artistImageView];
    self.artistImageView.clipsToBounds = YES;
    
    self.artistLabel = [[UILabel alloc] initForAutoLayout];
    [self.itemView addSubview:self.artistLabel];
    self.artistLabel.textColor = [UIColor whiteColor];
    self.artistLabel.numberOfLines = 0;
    self.artistLabel.font = [UIFont systemFontOfSize:20];
    self.artistLabel.textAlignment = NSTextAlignmentCenter;
    self.artistLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.artistLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.itemView.bounds) - 20;
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        CGFloat segmentedControlHeight = 44;
        [self.segmentedControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.segmentedControl autoSetDimensionsToSize:CGSizeMake(250, segmentedControlHeight)];
        
        [self.artistImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.artistImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.artistImageView autoSetDimensionsToSize:CGSizeMake(100, 100)];
        
        [self.artistLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.artistLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.artistImageView withOffset:10];
        
        [self.itemView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [self.itemView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [self.itemView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
        [self.itemView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(self.bounds)-segmentedControlHeight];
        
        [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.backgroundImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl withOffset:segmentedControlHeight/2.0];
        [self.backgroundImageView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(self.bounds) relation:NSLayoutRelationGreaterThanOrEqual];
        
        [self.navigationBarConnector autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.navigationBarConnector autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl withOffset:segmentedControlHeight/2.0];
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.itemView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl withOffset:0 relation:NSLayoutRelationEqual];
        [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    }];
}

- (void)setupCellWithArtist:(Artist *)artist {
    self.backgroundImageView.image = [artist.bigImage blurredImageWithRadius:10 iterations:10 tintColor:[UIColor blackColor]];
    self.artistImageView.image = artist.smallImage;
    self.artistLabel.text = artist.name;
}

- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {
    if (!self.shadowBarImage) {
        self.shadowBarImage = self.viewController.navigationController.navigationBar.shadowImage;
    }
    
    CGFloat navigationBarConnectorAppearingThreshold = .20;
    if (layoutAttributes.progressiveness < navigationBarConnectorAppearingThreshold) {
        self.navigationBarConnector.alpha = (navigationBarConnectorAppearingThreshold - layoutAttributes.progressiveness)/navigationBarConnectorAppearingThreshold;
        [self.viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
    } else {
        self.navigationBarConnector.alpha = 0;
        [self.viewController.navigationController.navigationBar setShadowImage:self.shadowBarImage];
    }
}

@end
