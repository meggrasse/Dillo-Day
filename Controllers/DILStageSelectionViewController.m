//
//  DILStageSelectionViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILStageSelectionViewController.h"

@interface DILStageSelectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *stagesTableView;
//@property (nonatomic) BOOL hasRegisteredCells;
@end

@implementation DILStageSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureNotificationsTableView];
    self.title = @"Pick a Stage";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.hasRegisteredCells = NO;
    // Do any additional setup after loading the view.
}

- (void)configureNotificationsTableView {
    [self.view addSubview:self.stagesTableView];
    [self.stagesTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

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
    static NSString *const DILStageSelectionTableViewCellIdentifier = @"DILStageSelectionTableViewCellIdentifier";
    if (![tableView dequeueReusableCellWithIdentifier:DILStageSelectionTableViewCellIdentifier]) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DILStageSelectionTableViewCellIdentifier];
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DILStageSelectionTableViewCellIdentifier];
    DILPFStage *stageForCell = [self stageForIndexPath:indexPath];
    cell.textLabel.text = stageForCell.name;

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self class] heightForCell];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectStage:[self stageForIndexPath:indexPath]];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (DILPFStage *)stageForIndexPath:(NSIndexPath *)indexPath {
    return self.stageArray[indexPath.row];
}

+ (CGFloat)heightForCell {
    return 44;
}

- (CGFloat)heightForViewController {
    return self.stageArray.count * [[self class] heightForCell] + CGRectGetHeight(self.navigationController.navigationBar.bounds) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}

@end
