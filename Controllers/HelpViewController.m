//
//  HelpViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (strong, nonatomic) UILabel *emergencyLabel;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureEmergencyLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureEmergencyLabel {
    self.emergencyLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:self.emergencyLabel];
    
    self.emergencyLabel.text = @"Emergencies";
    self.emergencyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:100];
    self.emergencyLabel.adjustsFontSizeToFitWidth = YES;
    self.emergencyLabel.minimumScaleFactor = 0.01;
    self.emergencyLabel.textAlignment = NSTextAlignmentCenter;
    self.emergencyLabel.textColor = [UIColor redColor];
    
    [self.emergencyLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-20 relation:NSLayoutRelationEqual];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.emergencyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50 relation:NSLayoutRelationGreaterThanOrEqual];


    UILabel *emergencyTextLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:emergencyTextLabel];
    
    emergencyTextLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    CGFloat emergencyTextLabelInset = 15;
    emergencyTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds) - 2*emergencyTextLabelInset;
    emergencyTextLabel.numberOfLines = 0;
    emergencyTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    emergencyTextLabel.textAlignment = NSTextAlignmentCenter;
    
    [emergencyTextLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [emergencyTextLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.emergencyLabel withOffset:10];
    [emergencyTextLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15 relation:NSLayoutRelationEqual];
    [emergencyTextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15 relation:NSLayoutRelationEqual];
    emergencyTextLabel.text = @"On the real app, this would say something important about not being a \"Dumb Dillo\" and helping out a friend in need, but today there's something a little more important:\nJ.P., will you go to prom with me?";

    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [emergencyTextLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    

    UIButton *emergencyButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:emergencyButton];
    
    emergencyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:100];
    [emergencyButton setEnabled:YES];
    [emergencyButton setUserInteractionEnabled:YES];
    emergencyButton.titleLabel.minimumScaleFactor = 0.1;
    emergencyButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    emergencyButton.titleEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
    [emergencyButton setTitle:@"911" forState:UIControlStateNormal];
    
    emergencyButton.layer.cornerRadius = 10;
    emergencyButton.clipsToBounds = YES;
    [emergencyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    emergencyButton.backgroundColor = [UIColor redColor];
    
    [emergencyButton autoSetDimension:ALDimensionHeight toSize:100];
    [emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [emergencyButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [emergencyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyTextLabel withOffset:15];
    [emergencyButton addTarget:self action:@selector(handleEmergencyButtonTap) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *reportButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:reportButton];
    
    reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    reportButton.titleLabel.minimumScaleFactor = 0.1;
    reportButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    emergencyButton.titleEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
    [reportButton setTitle:@"Report an Incident" forState:UIControlStateNormal];
    [reportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    reportButton.backgroundColor = [UIColor lightGrayColor];
    reportButton.layer.cornerRadius = 10;
    reportButton.clipsToBounds = YES;
    [reportButton setEnabled:YES];
    [reportButton setUserInteractionEnabled:YES];
    
    [reportButton autoSetDimension:ALDimensionHeight toSize:100];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [reportButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emergencyButton withOffset:15];
    [reportButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [reportButton addTarget:self action:@selector(handleReportButtonTap) forControlEvents:UIControlEventTouchUpInside];

}

- (void)handleEmergencyButtonTap {
    
}

- (void)handleReportButtonTap {
    
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
