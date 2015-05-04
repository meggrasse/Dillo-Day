//
//  DILHelpViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/9/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILHelpViewController.h"
@import MessageUI;
#import <FlatUIKit/FlatUIKit.h>
#import "SVModalWebViewController.h"
#import "DILShuttleScheduleViewController.h"

@interface DILHelpViewController ()<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) FUIButton *emergencyButton;
@property (strong, nonatomic) FUIButton *NUPDButton;
@property (strong, nonatomic) FUIButton *feedbackButton;
@property (strong, nonatomic) FUIButton *shuttlesButton;
@property (strong, nonatomic) UILabel *feedbackLabel;
@property (strong, nonatomic) UILabel *shuttlesLabel;
@property (strong, nonatomic) UILabel *smartDilloLabel;
@end

static CGFloat buttonShadowHeight = 5;

@implementation DILHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view.
}

- (void)configureView {
    CGFloat sideInset = 10;
    CGFloat buttonHeight = 50;

    UIView *emergencyView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:emergencyView];
    [emergencyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];

    [emergencyView addSubview:self.smartDilloLabel];
    [self.smartDilloLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];
    [self.smartDilloLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];

    [emergencyView addSubview:self.emergencyButton];
    [self.emergencyButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.smartDilloLabel withOffset:sideInset];
    [self.emergencyButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];

    [emergencyView addSubview:self.NUPDButton];
    [self.NUPDButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.NUPDButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.emergencyButton withOffset:sideInset];
    [self.NUPDButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset];
    [self.NUPDButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];

    UIView *feedbackView = [[UIView alloc] initForAutoLayout];
    feedbackView.clipsToBounds = YES;
    [self.view addSubview:feedbackView];
    [feedbackView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];

    [feedbackView addSubview:self.feedbackButton];
    [self.feedbackButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.feedbackButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];
    [self.feedbackButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset];
    [self.feedbackButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];

    /*
    [feedbackView addSubview:self.feedbackLabel];
    [self.feedbackLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.feedbackLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.feedbackButton withOffset:-sideInset];
    [self.feedbackLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];
     */

    UIView *shuttleViewContainer = [[UIView alloc] initForAutoLayout];
    shuttleViewContainer.clipsToBounds = YES;
    [self.view addSubview:shuttleViewContainer];
    [shuttleViewContainer autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
    [shuttleViewContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyView withOffset:0];
    [shuttleViewContainer autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:feedbackView withOffset:0];


    UIView *shuttlesView = [[UIView alloc] initForAutoLayout];
    [shuttleViewContainer addSubview:shuttlesView];
    [shuttlesView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
//    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
//    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
//    [shuttlesView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyView];
//    [shuttlesView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:feedbackView];

    /*
    [shuttlesView addSubview:self.shuttlesLabel];
    [self.shuttlesLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.shuttlesLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.shuttlesLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
     */

    [shuttlesView addSubview:self.shuttlesButton];
    [self.shuttlesButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.shuttlesButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];
//    [self.shuttlesButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shuttlesLabel withOffset:sideInset];
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeTop];


    for (UIView *view in @[self.smartDilloLabel, self.emergencyButton, self.NUPDButton, self.feedbackButton, self.shuttlesButton]) {
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }

}



- (FUIButton *)emergencyButton {
    if (!_emergencyButton) {
        _emergencyButton = [[FUIButton alloc] initForAutoLayout];
        [_emergencyButton setTitle:@"CALL 911" forState:UIControlStateNormal];
        [_emergencyButton addTarget:self action:@selector(emergencyCall) forControlEvents:UIControlEventTouchUpInside];
        _emergencyButton.cornerRadius = 5;
        _emergencyButton.shadowHeight = buttonShadowHeight;
        _emergencyButton.buttonColor = [UIColor alizarinColor];
        _emergencyButton.shadowColor = [UIColor pomegranateColor];
    }
    return _emergencyButton;
}

- (FUIButton *)NUPDButton {
    if (!_NUPDButton) {
        _NUPDButton = [[FUIButton alloc] initForAutoLayout];
        [_NUPDButton setTitle:@"REPORT AN INCIDENT TO NUPD" forState:UIControlStateNormal];
        [_NUPDButton addTarget:self action:@selector(nupdCall) forControlEvents:UIControlEventTouchUpInside];
        _NUPDButton.cornerRadius = 5;
        _NUPDButton.shadowHeight = buttonShadowHeight;
        _NUPDButton.buttonColor = [UIColor amethystColor];
        _NUPDButton.shadowColor = [UIColor wisteriaColor];
    }
    return _NUPDButton;
}

- (FUIButton *)feedbackButton {
    if (!_feedbackButton) {
        _feedbackButton = [[FUIButton alloc] initForAutoLayout];
        [_feedbackButton setTitle:@"CONTACT MAYFEST" forState:UIControlStateNormal];
        _feedbackButton.cornerRadius = 5;
        [_feedbackButton addTarget:self action:@selector(contactMayfest) forControlEvents:UIControlEventTouchUpInside];
        _feedbackButton.shadowHeight = buttonShadowHeight;
        _feedbackButton.buttonColor = [UIColor wetAsphaltColor];
        _feedbackButton.shadowColor = [UIColor midnightBlueColor];
    }
    return _feedbackButton;
}

- (FUIButton *)shuttlesButton {
    if (!_shuttlesButton) {
        _shuttlesButton = [[FUIButton alloc] initForAutoLayout];
        [_shuttlesButton addTarget:self action:@selector(displayShuttleSchedule) forControlEvents:UIControlEventTouchUpInside];
        [_shuttlesButton setTitle:@"SHUTTLE SCHEDULE" forState:UIControlStateNormal];
        _shuttlesButton.cornerRadius = 5;
        _shuttlesButton.shadowHeight = buttonShadowHeight;
        _shuttlesButton.buttonColor = [UIColor peterRiverColor];
        _shuttlesButton.shadowColor = [UIColor belizeHoleColor];
    }
    return _shuttlesButton;
}

- (UILabel *)feedbackLabel {
    if (!_feedbackLabel) {
        _feedbackLabel = [[UILabel alloc] initForAutoLayout];
        _feedbackLabel.text = nil;
        _feedbackLabel.adjustsFontSizeToFitWidth = YES;
        _feedbackLabel.minimumScaleFactor = 0.01;
        _feedbackLabel.textAlignment = NSTextAlignmentCenter;
        _feedbackLabel.numberOfLines = 0;
    }
    return _feedbackLabel;
}

- (UILabel *)smartDilloLabel {
    if (!_smartDilloLabel) {
        _smartDilloLabel = [[UILabel alloc] initForAutoLayout];
        _smartDilloLabel.text = @"Be a Smart Dillo! If there is a fellow Wildcat in need, or if you would like to report something, use the numbers below.";
        _smartDilloLabel.adjustsFontSizeToFitWidth = YES;
        _smartDilloLabel.minimumScaleFactor = 0.01;
        _smartDilloLabel.numberOfLines = 0;
        _smartDilloLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _smartDilloLabel;
}

- (UILabel *)shuttlesLabel {
    if (!_shuttlesLabel) {
        _shuttlesLabel = [[UILabel alloc] initForAutoLayout];
//        _shuttlesLabel.text = @"Going somewhere? Why not check if a shuttle can take you there!";
        _shuttlesLabel.text = nil;
        _shuttlesLabel.numberOfLines = 0;
        _shuttlesLabel.adjustsFontSizeToFitWidth = YES;
        _shuttlesLabel.minimumScaleFactor = 0.01;
        _shuttlesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _shuttlesLabel;
}


- (void)displayShuttleSchedule {
    DILShuttleScheduleViewController *scheduleViewController = [[DILShuttleScheduleViewController alloc] init];
    UINavigationController *scheduleNavigationController = [[UINavigationController alloc] initWithRootViewController:scheduleViewController];
    
    [self presentViewController:scheduleNavigationController animated:YES completion:NULL];
}

- (void)emergencyCall {
    NSString *phNo = @"911";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];

    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Call Failed" message:@"This device cannot make a call at this time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [calert show];
    }
}


- (void)nupdCall {
    NSString *phNo = @"847-491-3456";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];

    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Call Failed" message:@"This device cannot make a call at this time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (void)contactMayfest {
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
    [composeVC setToRecipients:@[@"dilloday@gmail.com"]];
    composeVC.mailComposeDelegate = self;
    [self presentViewController:composeVC animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
@end
