//
//  DILNotificationsViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationsViewController.h"
#import "DILNotificationsTableViewModel.h"

@interface DILNotificationsViewController ()
@property (strong, nonatomic) UITableView *notificationsTableView;
@property (strong, nonatomic) DILNotificationsTableViewModel *notificationsTableViewModel;
@end

@implementation DILNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureNotificationsTableView];
}

- (void)configureNotificationsTableView {
    [self.view addSubview:self.notificationsTableView];
    [self.notificationsTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (UITableView *)notificationsTableView {
    if (!_notificationsTableView) {
        _notificationsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _notificationsTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _notificationsTableView.delegate = self.notificationsTableViewModel;
        _notificationsTableView.dataSource = self.notificationsTableViewModel;
    }
    return _notificationsTableView;
}

- (DILNotificationsTableViewModel *)notificationsTableViewModel {
    if(!_notificationsTableViewModel) {
        _notificationsTableViewModel = [DILNotificationsTableViewModel new];
    }
    return _notificationsTableViewModel;
}

@end
