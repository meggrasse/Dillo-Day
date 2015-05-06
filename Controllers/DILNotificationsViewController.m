//
//  DILNotificationsViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationsViewController.h"
#import "DILNotificationsTableViewModel.h"
#import "DILPushNotificationHandler.h"

@interface DILNotificationsViewController ()<DILNotificationsTableViewProtocol>
@property (strong, nonatomic) UITableView *notificationsTableView;
@property (strong, nonatomic) DILNotificationsTableViewModel *notificationsTableViewModel;
@end

@implementation DILNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureNotificationsTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    CGPoint contentOffset = self.notificationsTableView.contentOffset;
    [self.notificationsTableView reloadData];
    [self.notificationsTableView setContentOffset:contentOffset animated:NO];
    [self.notificationsTableViewModel trackDisplayedNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.notificationsTableViewModel markDisplayedNotificationsRead];
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
        _notificationsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _notificationsTableView.backgroundColor = [DilloDayStyleKit notificationCellBackgroundColor];
    }
    return _notificationsTableView;
}

- (DILNotificationsTableViewModel *)notificationsTableViewModel {
    if(!_notificationsTableViewModel) {
        _notificationsTableViewModel = [DILNotificationsTableViewModel new];
        _notificationsTableViewModel.delegate = self;
    }
    return _notificationsTableViewModel;
}

#pragma mark - DILNotificationsTableViewProtocol
- (void)reloadTableDataScrollToTop:(BOOL)scrollToTop {
    CGPoint contentOffset = self.notificationsTableView.contentOffset;
    [self.notificationsTableView reloadData];
    if (!scrollToTop) {
        [self.notificationsTableView setContentOffset:contentOffset animated:NO];
    } else {
        [self.notificationsTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

@end
