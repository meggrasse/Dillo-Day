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
@property (strong, nonatomic) FUIButton *zipcarButton;
@property (strong, nonatomic) FUIButton *sponsorsButton;
@property (strong, nonatomic) FUIButton *foodTruckMenusButton;
@property (strong, nonatomic) UILabel *feedbackLabel;
@property (strong, nonatomic) UILabel *shuttlesLabel;
@property (strong, nonatomic) UILabel *smartDilloLabel;
@property (strong, nonatomic) UILabel *zipcarLabel;
@property (strong, nonatomic) UIImageView *sponsorImageView;
@end

@implementation DILHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureEqualSizedView];
}

- (void)configureEqualSizedView {
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat sideInset = 10;
    
    UIView *buttonSubview = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:buttonSubview];
    [buttonSubview autoSetDimension:ALDimensionWidth toSize:width];
    [buttonSubview autoSetDimension:ALDimensionHeight toSize:height/2 - 75];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    NSArray *buttonArray = @[self.zipcarButton, self.NUPDButton, self.emergencyButton, self.feedbackButton, self.shuttlesButton, self.foodTruckMenusButton, self.sponsorsButton];
    for (UIView *view in buttonArray) {
        [buttonSubview addSubview:view];
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    
    [buttonArray autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:sideInset insetSpacing:YES matchedSizes:YES];
    
    [self.zipcarButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];
    [self.zipcarButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.NUPDButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.zipcarButton withOffset:sideInset];
    [self.NUPDButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.NUPDButton withOffset:sideInset];
    [self.emergencyButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.feedbackButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.emergencyButton withOffset:sideInset];
    [self.feedbackButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.shuttlesButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.feedbackButton withOffset:sideInset];
    [self.shuttlesButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];

    [self.foodTruckMenusButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shuttlesButton withOffset:sideInset];
    [self.foodTruckMenusButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.sponsorsButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.foodTruckMenusButton withOffset:sideInset];
    [self.sponsorsButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.sponsorsButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset];
}

- (void)configureView {
    CGFloat sideInset = 10;
    CGFloat buttonHeight = 50;
    
    UIView *emergencyView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:emergencyView];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    [emergencyView addSubview:self.emergencyButton];
    [self.emergencyButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
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
    
    [shuttlesView addSubview:self.shuttlesButton];
    [self.shuttlesButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.shuttlesButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    for (UIView *view in @[self.emergencyButton, self.NUPDButton, self.feedbackButton, self.shuttlesButton, self.zipcarButton]) {
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    
}

- (FUIButton *)emergencyButton {
    if (!_emergencyButton) {
        _emergencyButton = [[FUIButton alloc] initForAutoLayout];
        [_emergencyButton setTitle:@"CALL 911 (EMERGENCY)" forState:UIControlStateNormal];
        [_emergencyButton addTarget:self action:@selector(emergencyCall) forControlEvents:UIControlEventTouchUpInside];
        _emergencyButton.cornerRadius = 5;
        _emergencyButton.buttonColor = [UIColor alizarinColor];
    }
    return _emergencyButton;
}

- (FUIButton *)NUPDButton {
    if (!_NUPDButton) {
        _NUPDButton = [[FUIButton alloc] initForAutoLayout];
        [_NUPDButton setTitle:@"CALL NUPD (NON-EMERGENCY)" forState:UIControlStateNormal];
        [_NUPDButton addTarget:self action:@selector(nupdCall) forControlEvents:UIControlEventTouchUpInside];
        _NUPDButton.cornerRadius = 5;
        _NUPDButton.buttonColor = [UIColor amethystColor];
    }
    return _NUPDButton;
}

- (FUIButton *)feedbackButton {
    if (!_feedbackButton) {
        _feedbackButton = [[FUIButton alloc] initForAutoLayout];
        [_feedbackButton setTitle:@"CONTACT MAYFEST" forState:UIControlStateNormal];
        _feedbackButton.cornerRadius = 5;
        [_feedbackButton addTarget:self action:@selector(contactMayfest) forControlEvents:UIControlEventTouchUpInside];
        _feedbackButton.buttonColor = [UIColor wetAsphaltColor];
    }
    return _feedbackButton;
}


- (FUIButton *)shuttlesButton {
    if (!_shuttlesButton) {
        _shuttlesButton = [[FUIButton alloc] initForAutoLayout];
        [_shuttlesButton addTarget:self action:@selector(displayShuttleSchedule) forControlEvents:UIControlEventTouchUpInside];
        [_shuttlesButton setTitle:@"SHUTTLE SCHEDULE" forState:UIControlStateNormal];
        _shuttlesButton.cornerRadius = 5;
        _shuttlesButton.buttonColor = [UIColor peterRiverColor];
    }
    return _shuttlesButton;
}

- (FUIButton *)sponsorsButton {
    if (!_sponsorsButton) {
        _sponsorsButton = [[FUIButton alloc] initForAutoLayout];
        [_sponsorsButton addTarget:self action:@selector(openSponsorPage) forControlEvents:UIControlEventTouchUpInside];
        [_sponsorsButton setTitle:@"SPONSORS" forState:UIControlStateNormal];
        _sponsorsButton.cornerRadius = 5;
        _sponsorsButton.buttonColor = [UIColor colorWithRed: 0.204 green: 0.859 blue: 0.549 alpha: 1];
    }
    return _sponsorsButton;
}

- (FUIButton *)foodTruckMenusButton {
    if (!_foodTruckMenusButton) {
        _foodTruckMenusButton = [[FUIButton alloc] initForAutoLayout];
        [_foodTruckMenusButton addTarget:self action:@selector(openFoodTruckMenusPage) forControlEvents:UIControlEventTouchUpInside];
        [_foodTruckMenusButton setTitle:@"FOOD TRUCK MENUS" forState:UIControlStateNormal];
        _foodTruckMenusButton.cornerRadius = 5;
        _foodTruckMenusButton.buttonColor = [UIColor colorWithRed:0.89 green:0.72 blue:0.94 alpha:1.0];
    }
    return _foodTruckMenusButton;
}

- (FUIButton *)zipcarButton {
    if (!_zipcarButton) {
        _zipcarButton = [[FUIButton alloc] initForAutoLayout];
        UIImageView *zipcarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zipcar"]];
        [_zipcarButton addSubview:zipcarImage];
        CGFloat targetWidth = (3.0/5.0)*self.view.frame.size.width;
        CGFloat targetRatio = zipcarImage.frame.size.height/zipcarImage.frame.size.width;
        [zipcarImage autoSetDimensionsToSize:CGSizeMake(targetWidth, targetWidth*targetRatio)];
        [zipcarImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.zipcarButton];
        [zipcarImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.zipcarButton];
        _zipcarButton.layer.cornerRadius = 5;
        [_zipcarButton addTarget:self action:@selector(openAppStoreForZipcar) forControlEvents:UIControlEventTouchUpInside];
        [[_zipcarButton layer] setBorderWidth:2.0f];
        [[_zipcarButton layer] setBorderColor:[DilloDayStyleKit barButtonItemColor].CGColor];
        _zipcarButton.buttonColor = [UIColor whiteColor];
    }
    return _zipcarButton;
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
        _shuttlesLabel.text = nil;
        _shuttlesLabel.numberOfLines = 0;
        _shuttlesLabel.adjustsFontSizeToFitWidth = YES;
        _shuttlesLabel.minimumScaleFactor = 0.01;
        _shuttlesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _shuttlesLabel;
}

- (UILabel *)zipcarLabel {
    if (!_zipcarLabel) {
        _zipcarLabel = [[UILabel alloc] initForAutoLayout];
        NSLog(@"%@", _zipcarLabel);
        _zipcarLabel.text = nil;
        _zipcarLabel.numberOfLines = 0;
        _zipcarLabel.adjustsFontSizeToFitWidth = YES;
        _zipcarLabel.minimumScaleFactor = 0.01;
        _zipcarLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _zipcarLabel;
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

- (void)openAppStoreForZipcar {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/zipcar/id329384702"]];
}

- (void)openSponsorPage {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://www.dilloday.com/sponsors"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (void)openFoodTruckMenusPage {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://www.dilloday.com/files/DilloFoodTruckMenus.pdf"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
@end
