//
//  DILStageSelectView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILStageSelectView.h"
#import "DILStageSelectTableViewCell.h"

@interface DILStageSelectView()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *stagesTableView;
@end

@implementation DILStageSelectView

- (void)setStageArray:(NSArray *)stageArray {
    _stageArray = stageArray;
    [self configureStagesTableView];
}
- (void)configureStagesTableView {
    [self addSubview:self.stagesTableView];
    [self.stagesTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - UITableView Implementation
- (UITableView *)stagesTableView {
    if (!_stagesTableView) {
        _stagesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _stagesTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _stagesTableView.separatorColor = [UIColor clearColor];
        _stagesTableView.delegate = self;
        _stagesTableView.dataSource = self;
        _stagesTableView.bounces = NO;
    }
    return _stagesTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const DILStageSelectTableViewCellIdentifier = [DILStageSelectTableViewCell identifier];
    if (![tableView dequeueReusableCellWithIdentifier:DILStageSelectTableViewCellIdentifier]) {
        [tableView registerClass:[DILStageSelectTableViewCell class] forCellReuseIdentifier:DILStageSelectTableViewCellIdentifier];
    }

    DILStageSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DILStageSelectTableViewCellIdentifier];
    DILPFStage *stageForCell = [self stageForIndexPath:indexPath];
    [cell configureCellWithStage:stageForCell];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self class] heightForCell];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectStage:[self stageForIndexPath:indexPath]];
}

- (DILPFStage *)stageForIndexPath:(NSIndexPath *)indexPath {
    return self.stageArray[indexPath.row];
}

+ (CGFloat)heightForCell {
    return 44;
}

- (CGFloat)heightForView {
    return self.stageArray.count * [[self class] heightForCell];
}

@end
