//
//  LineupTextHTKCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "LineupTextHTKCollectionViewCell.h"
#import <PureLayout/PureLayout.h>
#import <BOString/BOString.h>
#import <NSAttributedString+CCLFormat/NSAttributedString+CCLFormat.h>

@interface LineupTextHTKCollectionViewCell()
@property (strong, nonatomic) UILabel *artistLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation LineupTextHTKCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [UIColor clearColor];
    
    self.artistLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.artistLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.artistLabel.textColor = [UIColor blackColor];
    self.artistLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.artistLabel.numberOfLines = 0;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeLabel.textColor = [UIColor redColor];
    self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timeLabel.numberOfLines = 0;
    
    CGRect bounds = self.bounds;
    
    [self.contentView addSubview:_artistLabel];
//    [self.contentView addSubview:_timeLabel];

    CGFloat padding = 10;
    
    [self.artistLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
//    [self.timeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.artistLabel];
//    [self.timeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
//    [self.timeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
//    
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.artistLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding relation:NSLayoutRelationGreaterThanOrEqual];
//    [self.timeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.artistLabel setPreferredMaxLayoutWidth: DEFAULT_LINEUP_TEXT_CELL_SIZE.width - 2*padding];
    
    [self.artistLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.artistLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupCellWithArtist:(NSString *)artist atTime:(NSString *)time {
    self.artistLabel.text = [NSString stringWithFormat:@"%@! %@", artist, time];
    NSAttributedString *artistText = [[artist lowercaseString] bos_makeString:^(BOStringMaker *make) {
        make.font([UIFont fontWithName:@"HelveticaNeue-Thin" size:30]);
    }];
    
    NSAttributedString *timeText = [[time lowercaseString] bos_makeString:^(BOStringMaker *make) {
        make.font([UIFont fontWithName:@"HelveticaNeue" size:15]);
    }];
    
    self.artistLabel.attributedText = [NSAttributedString attributedStringWithFormat:@"%@ %@", artistText, timeText];
    
}

@end
