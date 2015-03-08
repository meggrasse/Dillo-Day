//
//  HelpCSViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HelpCSViewController.h"
#import <Shimmer/FBShimmeringView.h>
#import <PureLayout/PureLayout.h>
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>
#import <L360Confetti/L360ConfettiArea.h>

@interface HelpCSViewController ()
@property (strong, nonatomic) UILabel *emergencyLabel;
@property (strong, nonatomic) NSTimer *confettiTimer;
@end

@implementation HelpCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDilloButtonToUnwindOnTap:YES];
    [self configureEmergencyLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureEmergencyLabel {
    FBShimmeringView *shimmerView = [[FBShimmeringView alloc] initForAutoLayout];
    shimmerView.shimmeringPauseDuration = 0;
    shimmerView.shimmeringAnimationOpacity = 0.5;
    shimmerView.shimmeringSpeed = 150;
    [self.view addSubview:shimmerView];
    [shimmerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dilloButton withOffset:10];
    [shimmerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationEqual];
    [shimmerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationEqual];
    [shimmerView autoSetDimension:ALDimensionHeight toSize:60];
    
    self.emergencyLabel = [[UILabel alloc] initForAutoLayout];
    self.emergencyLabel.text = @"Emergencies";
    self.emergencyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
    self.emergencyLabel.minimumScaleFactor = 0.01;
    self.emergencyLabel.textAlignment = NSTextAlignmentCenter;
    self.emergencyLabel.textColor = [UIColor redColor];
    
    [shimmerView addSubview:self.emergencyLabel];

    [self.emergencyLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationEqual];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationEqual];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    shimmerView.contentView = self.emergencyLabel;
    shimmerView.shimmering = YES;
    
    UILabel *emergencyTextLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:emergencyTextLabel];
    emergencyTextLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    emergencyTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds) - 20;
    emergencyTextLabel.numberOfLines = 0;
    emergencyTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    emergencyTextLabel.textAlignment = NSTextAlignmentCenter;
    
//    [emergencyTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [emergencyTextLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:shimmerView withOffset:10];
    [emergencyTextLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10 relation:NSLayoutRelationEqual];
    [emergencyTextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10 relation:NSLayoutRelationEqual];
    emergencyTextLabel.text = @"On the real app, this would say something important about not being a \"Dumb Dillo\" and helping out a friend in need, but today there's something a little more important:\nJ.P., will you go to prom with me?";
    [emergencyTextLabel autoSetDimension:ALDimensionHeight toSize:120];
    
    UIButton *emergencyButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:emergencyButton];
    emergencyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    [emergencyButton setEnabled:YES];
    [emergencyButton setUserInteractionEnabled:YES];
    emergencyButton.titleLabel.minimumScaleFactor = 0.1;
    [emergencyButton setTitle:@"Yes!" forState:UIControlStateNormal];
    emergencyButton.layer.cornerRadius = 10;
    emergencyButton.clipsToBounds = YES;
    [emergencyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    emergencyButton.backgroundColor = [UIColor redColor];
    [emergencyButton autoSetDimension:ALDimensionHeight toSize:100];
    [emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyTextLabel withOffset:10];
    [emergencyButton addTarget:self action:@selector(acceptProm) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *reportButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:reportButton];
    
    reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    reportButton.titleLabel.minimumScaleFactor = 0.1;
    [reportButton setTitle:@"No" forState:UIControlStateNormal];
    [reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reportButton.backgroundColor = [UIColor whiteColor];
    reportButton.layer.cornerRadius = 10;
    reportButton.clipsToBounds = YES;
    reportButton.layer.borderColor = [UIColor grayColor].CGColor;
    reportButton.layer.borderWidth = .75;
    [reportButton setEnabled:YES];
    [reportButton setUserInteractionEnabled:YES];
    
    [reportButton autoSetDimension:ALDimensionHeight toSize:100];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [reportButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyButton withOffset:10];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [reportButton addTarget:self action:@selector(rejectProm) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    UIButton *JPProm = [[UIButton alloc] initForAutoLayout];
    [JPProm addTarget:self action:@selector(prom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:JPProm];
    JPProm.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    JPProm.titleLabel.minimumScaleFactor = 0.1;
    [JPProm setTitle:@"JP, will you go to prom with me?" forState:UIControlStateNormal];
    [JPProm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    JPProm.backgroundColor = [UIColor blueColor];
    JPProm.layer.cornerRadius = 10;
    JPProm.clipsToBounds = YES;

    [JPProm autoSetDimension:ALDimensionHeight toSize:100];
    [JPProm autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [JPProm autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [JPProm autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:reportButton withOffset:10];
    [JPProm autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
     */
}

- (void)acceptProm {
    UIView *backgroundDarkenView = [[UIView alloc] initForAutoLayout];
    backgroundDarkenView.alpha = 0;
    backgroundDarkenView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    [self.view addSubview:backgroundDarkenView];
    [backgroundDarkenView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    UIImageView *JPPhoto = [[UIImageView alloc] initForAutoLayout];
    JPPhoto.image = [UIImage imageNamed:@"JPProm"];
    JPPhoto.alpha = 0;
    [self.view insertSubview:JPPhoto aboveSubview:backgroundDarkenView];
    
    CGSize size = CGSizeMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetWidth(self.view.bounds)-40);
    [JPPhoto autoSetDimensionsToSize:size];
    [JPPhoto autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:0];
    [JPPhoto autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view withOffset:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundDarkenView.alpha = 1;
        JPPhoto.alpha = 1;
    }];
    
    L360ConfettiArea *area = [[L360ConfettiArea alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:area aboveSubview:JPPhoto];
    
    self.confettiTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(confetti:) userInfo:area repeats:YES];
}

- (void)rejectProm {
    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid response! Please try again." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [invalid show];
}

- (void)confetti:(NSTimer *)timer {
    L360ConfettiArea *area = timer.userInfo;
    [area burstAt:CGPointMake(CGRectGetMidX(area.bounds), 0) confettiWidth:5 numberOfConfetti:15];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
