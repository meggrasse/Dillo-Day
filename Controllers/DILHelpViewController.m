//
//  DILHelpViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/9/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILHelpViewController.h"
#import <FlatUIKit/FlatUIKit.h>
#import "SVModalWebViewController.h"

@interface DILHelpViewController ()
@property (strong, nonatomic) FUIButton *emergencyButton;
@property (strong, nonatomic) FUIButton *feedbackButton;
@property (strong, nonatomic) FUIButton *shuttlesButton;
@property (strong, nonatomic) UILabel *feedbackLabel;
@end

@implementation DILHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view.
}

- (void)configureView {
    [self.view addSubview:self.emergencyButton];
    [self.emergencyButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    CGFloat emergencyButtonInset = 15;
    [self.emergencyButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(emergencyButtonInset, emergencyButtonInset, emergencyButtonInset, emergencyButtonInset) excludingEdge:ALEdgeBottom];
    CGFloat emergencyButtonHeight = 125;
    [self.emergencyButton autoSetDimension:ALDimensionHeight toSize:emergencyButtonHeight];


    [self.view addSubview:self.feedbackButton];
    CGFloat feedbackButtonInset = emergencyButtonInset;
    [self.feedbackButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(feedbackButtonInset, feedbackButtonInset, feedbackButtonInset, feedbackButtonInset) excludingEdge:ALEdgeTop];
    CGFloat feedbackButtonHeight = 44;
    [self.feedbackButton autoSetDimension:ALDimensionHeight toSize:feedbackButtonHeight];

    [self.view addSubview:self.feedbackLabel];
//    [self.feedbackLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.feedbackLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.feedbackButton];
    [self.feedbackLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.feedbackButton];
    CGFloat feedbackLabelOffset = 10;
    [self.feedbackLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.feedbackButton withOffset:-feedbackLabelOffset];

    [self.view addSubview:self.shuttlesButton];
    CGFloat shuttlesButtonInset = feedbackButtonInset;
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:shuttlesButtonInset];
    [self.shuttlesButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:shuttlesButtonInset];
    CGFloat shuttlesButtonHeight = 3.0/4.0 * emergencyButtonHeight;
    [self.shuttlesButton autoSetDimension:ALDimensionHeight toSize:shuttlesButtonHeight];
    [self.shuttlesButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (FUIButton *)emergencyButton {
    if (!_emergencyButton) {
        _emergencyButton = [[FUIButton alloc] initForAutoLayout];
        [_emergencyButton setTitle:@"CALL 911" forState:UIControlStateNormal];
        [_emergencyButton addTarget:self action:@selector(emergencyCall) forControlEvents:UIControlEventTouchUpInside];
        _emergencyButton.cornerRadius = 5;
        _emergencyButton.shadowHeight = 4;
        _emergencyButton.buttonColor = [UIColor alizarinColor];
        _emergencyButton.shadowColor = [UIColor pomegranateColor];
    }
    return _emergencyButton;
}

- (FUIButton *)feedbackButton {
    if (!_feedbackButton) {
        _feedbackButton = [[FUIButton alloc] initForAutoLayout];
        [_feedbackButton setTitle:@"Let us know!" forState:UIControlStateNormal];
        _feedbackButton.cornerRadius = 5;
        _feedbackButton.shadowHeight = 4;
        _feedbackButton.buttonColor = [UIColor wetAsphaltColor];
        _feedbackButton.shadowColor = [UIColor midnightBlueColor];
    }
    return _feedbackButton;
}

- (FUIButton *)shuttlesButton {
    if (!_shuttlesButton) {
        _shuttlesButton = [[FUIButton alloc] initForAutoLayout];
        [_shuttlesButton addTarget:self action:@selector(openShuttlesWebPage) forControlEvents:UIControlEventTouchUpInside];
        [_shuttlesButton setTitle:@"Shuttles" forState:UIControlStateNormal];
        _shuttlesButton.cornerRadius = 5;
        _shuttlesButton.shadowHeight = 4;
        _shuttlesButton.buttonColor = [UIColor peterRiverColor];
        _shuttlesButton.shadowColor = [UIColor belizeHoleColor];
    }
    return _shuttlesButton;
}

- (UILabel *)feedbackLabel {
    if (!_feedbackLabel) {
        _feedbackLabel = [[UILabel alloc] initForAutoLayout];
        _feedbackLabel.text = @"Have questions, feedback, or need support?";
        _feedbackLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _feedbackLabel;
}

- (void)openShuttlesWebPage {
    NSURL *shuttlesURL = [NSURL URLWithString:@"https://www.google.com"];
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:shuttlesURL];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (void)emergencyCall {
    NSString *phNo = @"+919";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];

    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
