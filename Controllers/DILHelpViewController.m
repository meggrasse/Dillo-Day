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
@property (strong, nonatomic) FUIButton *lyftButton;
@property (strong, nonatomic) FUIButton *sponsorsButton;
@property (strong, nonatomic) UILabel *feedbackLabel;
@property (strong, nonatomic) UILabel *shuttlesLabel;
@property (strong, nonatomic) UILabel *smartDilloLabel;
@property (strong, nonatomic) UILabel *lyftLabel;
@property (strong, nonatomic) UIImageView *sponsorImageView;
@end

//static CGFloat buttonShadowHeight = 5;

@implementation DILHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureEqualSizedView];
    //    [self configureView];
    // Do any additional setup after loading the view.
}

- (void)configureEqualSizedView {
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat sideInset = 10;
    
    //CGFloat width = CGRectGetWidth(window);
    //Bonus height.
    //CGFloat height = CGRectGetHeight(window);
    
    //check orientation?
    
    //   CGFloat buttonHeight = 50;
    
    //    [self.view addSubview:self.sponsorImageView];
    //    [self.sponsorImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    //    [self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:2*sideInset];
    
    //    [self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:sideInset relation:NSLayoutRelationEqual];
    //    [self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:sideInset relation:NSLayoutRelationEqual];
    
    //    [self.sponsorImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-4*sideInset];
    //    [self.sponsorImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.sponsorImageView withMultiplier:self.sponsorImageView.image.size.height/self.sponsorImageView.image.size.width];
    
    
    UIView *buttonSubview = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:buttonSubview];
    [buttonSubview autoSetDimension:ALDimensionWidth toSize:width];
    [buttonSubview autoSetDimension:ALDimensionHeight toSize:height/2 - 75];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [buttonSubview autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UIView *sponsorSubview = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:sponsorSubview];
    [sponsorSubview autoSetDimension:ALDimensionWidth toSize:width];
    [sponsorSubview autoSetDimension:ALDimensionHeight toSize:height/2];
    [sponsorSubview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [sponsorSubview autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [sponsorSubview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [sponsorSubview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:buttonSubview];
    
    NSArray *buttonArray = @[self.emergencyButton, self.NUPDButton, self.shuttlesButton, self.feedbackButton, self.sponsorsButton, self.lyftButton];
    for (UIView *view in buttonArray) {
        [buttonSubview addSubview:view];
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    
    [buttonArray autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:sideInset insetSpacing:YES matchedSizes:YES];
    
    //    [self.emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sponsorImageView withOffset:sideInset];
    [self.emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];
    [self.emergencyButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.NUPDButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.emergencyButton withOffset:sideInset];
    [self.NUPDButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.shuttlesButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.NUPDButton withOffset:sideInset];
    [self.shuttlesButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.feedbackButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shuttlesButton withOffset:sideInset];
    [self.feedbackButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.sponsorsButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.feedbackButton withOffset:sideInset];
    [self.sponsorsButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [self.lyftButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sponsorsButton withOffset:sideInset];
    [self.lyftButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    [self.lyftButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset];
    
//    [self.lyftLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.lyftButton];
//    [self.lyftLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.lyftButton];
}

- (void)configureView {
    CGFloat sideInset = 10;
    CGFloat buttonHeight = 50;
    
    //[self.view addSubview:self.sponsorImageView];
    //[self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
    
    //[self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
    //[self.sponsorImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
    
    //    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
    //        [self.sponsorImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    //        [self.sponsorImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.sponsorImageView withMultiplier:self.sponsorImageView.image.size.height/self.sponsorImageView.image.size.width];
    //    }];
    
    
    UIView *emergencyView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:emergencyView];
    //    [emergencyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [emergencyView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    //    [emergencyView addSubview:self.smartDilloLabel];
    //    [self.smartDilloLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset];
    //    [self.smartDilloLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    
    [emergencyView addSubview:self.emergencyButton];
    [self.emergencyButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
    //    [self.emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.smartDilloLabel withOffset:sideInset];
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
    
//    UIView *webViewContainer = [[UIView alloc] initForAutoLayout];
//    webViewContainer.clipsToBounds = YES;
//    [self.view addSubview:webViewContainer];
//    [shuttleViewContainer autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
//    [shuttleViewContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyView withOffset:0];
//    [shuttleViewContainer autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:feedbackView withOffset:0];
//    
//    
//    UIView *shuttlesView = [[UIView alloc] initForAutoLayout];
//    [shuttleViewContainer addSubview:shuttlesView];
//    [shuttlesView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
//    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
//    //    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
//    //    [shuttlesView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:sideInset relation:NSLayoutRelationGreaterThanOrEqual];
//    //    [shuttlesView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyView];
//    //    [shuttlesView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:feedbackView];
//    
//    /*
//     [shuttlesView addSubview:self.shuttlesLabel];
//     [self.shuttlesLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
//     [self.shuttlesLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
//     [self.shuttlesLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//     */
//    
//    [shuttlesView addSubview:self.shuttlesButton];
//    [self.shuttlesButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-2*sideInset];
//    [self.shuttlesButton autoSetDimension:ALDimensionHeight toSize:buttonHeight];
//    //    [self.shuttlesButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shuttlesLabel withOffset:sideInset];
//    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    
    
    for (UIView *view in @[self.emergencyButton, self.NUPDButton, self.feedbackButton, self.shuttlesButton, self.lyftButton]) {
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    
}



- (FUIButton *)emergencyButton {
    if (!_emergencyButton) {
        _emergencyButton = [[FUIButton alloc] initForAutoLayout];
        [_emergencyButton setTitle:@"CALL 911 (EMERGENCY)" forState:UIControlStateNormal];
        [_emergencyButton addTarget:self action:@selector(emergencyCall) forControlEvents:UIControlEventTouchUpInside];
        _emergencyButton.cornerRadius = 5;
        //_emergencyButton.shadowHeight = buttonShadowHeight;
        _emergencyButton.buttonColor = [UIColor alizarinColor];
        // _emergencyButton.shadowColor = [UIColor pomegranateColor];
    }
    return _emergencyButton;
}

- (FUIButton *)NUPDButton {
    if (!_NUPDButton) {
        _NUPDButton = [[FUIButton alloc] initForAutoLayout];
        [_NUPDButton setTitle:@"CALL NUPD (NON-EMERGENCY)" forState:UIControlStateNormal];
        [_NUPDButton addTarget:self action:@selector(nupdCall) forControlEvents:UIControlEventTouchUpInside];
        _NUPDButton.cornerRadius = 5;
        //_NUPDButton.shadowHeight = buttonShadowHeight;
        _NUPDButton.buttonColor = [UIColor amethystColor];
        // _NUPDButton.shadowColor = [UIColor wisteriaColor];
    }
    return _NUPDButton;
}

- (FUIButton *)feedbackButton {
    if (!_feedbackButton) {
        _feedbackButton = [[FUIButton alloc] initForAutoLayout];
        [_feedbackButton setTitle:@"CONTACT MAYFEST" forState:UIControlStateNormal];
        _feedbackButton.cornerRadius = 5;
        [_feedbackButton addTarget:self action:@selector(contactMayfest) forControlEvents:UIControlEventTouchUpInside];
        // _feedbackButton.shadowHeight = buttonShadowHeight;
        _feedbackButton.buttonColor = [UIColor wetAsphaltColor];
        // _feedbackButton.shadowColor = [UIColor midnightBlueColor];
    }
    return _feedbackButton;
}


- (FUIButton *)shuttlesButton {
    if (!_shuttlesButton) {
        _shuttlesButton = [[FUIButton alloc] initForAutoLayout];
        [_shuttlesButton addTarget:self action:@selector(displayShuttleSchedule) forControlEvents:UIControlEventTouchUpInside];
        [_shuttlesButton setTitle:@"SHUTTLE SCHEDULE" forState:UIControlStateNormal];
        _shuttlesButton.cornerRadius = 5;
        // _shuttlesButton.shadowHeight = buttonShadowHeight;
        _shuttlesButton.buttonColor = [UIColor peterRiverColor];
        //  _shuttlesButton.shadowColor = [UIColor belizeHoleColor];
    }
    return _shuttlesButton;
}

- (FUIButton *)sponsorsButton {
    if (!_sponsorsButton) {
        _sponsorsButton = [[FUIButton alloc] initForAutoLayout];
        [_sponsorsButton addTarget:self action:@selector(openSponsorPage) forControlEvents:UIControlEventTouchUpInside];
        [_sponsorsButton setTitle:@"SPONSORS" forState:UIControlStateNormal];
        _sponsorsButton.cornerRadius = 5;
        // _shuttlesButton.shadowHeight = buttonShadowHeight;
        _sponsorsButton.buttonColor = [UIColor peterRiverColor];
        //  _shuttlesButton.shadowColor = [UIColor belizeHoleColor];
    }
    return _sponsorsButton;
}


- (FUIButton *)lyftButton {
    if (!_lyftButton) {
        CGFloat height = self.view.frame.size.height;
        _lyftButton = [[FUIButton alloc] initForAutoLayout];
        UIImageView *lyftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lyft"]];
        [_lyftButton addSubview:lyftImage];
        [lyftImage autoSetDimensionsToSize:CGSizeMake(3.22*(height/14), height/14)];
        [lyftImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.lyftButton];
        [lyftImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.lyftButton];
        _lyftButton.layer.cornerRadius = 5;
        [_lyftButton addTarget:self action:@selector(openLyft) forControlEvents:UIControlEventTouchUpInside];
        [[_lyftButton layer] setBorderWidth:2.0f];
        [[_lyftButton layer] setBorderColor:[UIColor colorWithRed: 0.929 green: 0.224 blue: 0.588 alpha: 1].CGColor];
        _lyftButton.buttonColor = [UIColor whiteColor];
    }
    return _lyftButton;
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

- (UILabel *)lyftLabel {
    if (!_lyftLabel) {
        //_lyftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _lyftButton.frame.size.height, _lyftButton.frame.size.width)];
        _lyftLabel = [[UILabel alloc] initForAutoLayout];
        NSLog(@"%@", _lyftLabel);
        _lyftLabel.text = nil;
        _lyftLabel.numberOfLines = 0;
        _lyftLabel.adjustsFontSizeToFitWidth = YES;
        _lyftLabel.minimumScaleFactor = 0.01;
        _lyftLabel.textAlignment = NSTextAlignmentCenter;
        //_lyftLabel.text = @"test";
    }
    return _lyftLabel;
}

//- (UIImageView *)sponsorImageView {
//    if (!_sponsorImageView) {
//        _sponsorImageView = [[UIImageView alloc] initForAutoLayout];
//        _sponsorImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _sponsorImageView.image = [UIImage imageNamed:@"RHASponsorLogo"];
//    }
//    return _sponsorImageView;
//}

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

- (void)openLyft {
    UIApplication *myApp = UIApplication.sharedApplication;
    NSURL *lyftAppURL = [NSURL URLWithString:@"lyft://payment?credits=DILLODAY2016"];
    if ([myApp canOpenURL:lyftAppURL]) {
        // Lyft is installed; launch it
        [myApp openURL:lyftAppURL];
    } else {
        // Lyft not installed; open App Store
        NSURL *lyftAppStoreURL = [NSURL URLWithString:@"https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082"];
        [myApp openURL:lyftAppStoreURL];
    }
}

- (void)openSponsorPage {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://www.dilloday.com/sponsors"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
@end