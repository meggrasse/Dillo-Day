//
//  DILStageSelectTableViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILStageSelectTableViewCell.h"
@interface DILStageSelectTableViewCell()
@property (strong, nonatomic) UILabel *stageNameLabel;
@end

@implementation DILStageSelectTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureTableViewCell];
    }
    return self;
}

- (void)configureTableViewCell {
    [self.contentView addSubview:self.stageNameLabel];

    [self.stageNameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.stageNameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
}

- (UILabel *)stageNameLabel {
    if (!_stageNameLabel) {
        _stageNameLabel = [[UILabel alloc] initForAutoLayout];
        _stageNameLabel.font = [UIFont systemFontOfSize:18.0];
        _stageNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stageNameLabel;
}

- (void)configureCellWithStage:(DILPFStage *)stage {
    self.stageNameLabel.text = [stage.name uppercaseString];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
