//
//  DILNotificationsTableViewModel.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DILNotificationsTableViewProtocol <NSObject>
@required
- (void)reloadTableDataScrollToTop:(BOOL)scrollToTop;
@end

@interface DILNotificationsTableViewModel : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) id<DILNotificationsTableViewProtocol> delegate;

- (void)markDisplayedNotificationsRead;
- (void)trackDisplayedNotifications;
@end
