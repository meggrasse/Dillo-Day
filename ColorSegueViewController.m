//
//  ColorSegueViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ColorSegueViewController.h"


@interface ColorSegueViewController ()
@property (strong, nonatomic) FMColorTransition *colorTransition;
@property (strong, nonatomic) UIButton *dilloButton;
@end

@implementation ColorSegueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorTransition = [FMColorTransition new];
}


#pragma mark - Color Segue
- (void)configureColorTransition:(UIColor *)color transitionType:(FMColorTransitionType)type {
    self.colorTransition.transitionColor = color;
    self.colorTransition.transitionType = type;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *controller = [segue destinationViewController];
    controller.transitioningDelegate = self.colorTransition;
    if ([controller isMemberOfClass:[ColorSegueViewController class]]) {
        ColorSegueViewController *colorSequeVC = (ColorSegueViewController *)controller;
        colorSequeVC.previousColorTransition = self.colorTransition;
    }
}


#pragma mark - Dillo Button
- (void)configureDilloButtonToUnwindOnTap:(BOOL)unwindsOnTap {
    self.dilloButton = [[UIButton alloc] initWithFrame:[self dilloButtonFrame]];
    self.dilloButton.userInteractionEnabled = unwindsOnTap;
    [self.dilloButton setImage:[UIImage imageNamed:@"DillogoSharpLarge"] forState:UIControlStateNormal];
    [self.dilloButton addTarget:self action:@selector(handleDilloButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dilloButton];
}

- (CGRect)dilloButtonFrame {
    CGFloat dimension = 100.;
    CGFloat padding = 20.f;
    return CGRectMake(padding, padding, dimension, dimension);
}

- (void)handleDilloButtonTap {
//    [self performSegueWithIdentifier:@"Unwind" sender:self];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
