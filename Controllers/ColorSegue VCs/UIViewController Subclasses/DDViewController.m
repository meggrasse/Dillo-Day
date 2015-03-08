//
//  DDViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DDViewController.h"
#import "FMColorTransition.h"

@interface DDViewController ()
@property (strong, nonatomic) FMColorTransition *colorTransition;
@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorTransition = [FMColorTransition new];
    
    UIButton *dilloButton = [[UIButton alloc] initWithFrame:[self dilloButtonFrame]];
    [dilloButton setImage:[UIImage imageNamed:@"DillogoSharpLarge"] forState:UIControlStateNormal];
    [dilloButton addTarget:self action:@selector(handleDilloButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dilloButton];
}

- (void)configureColorTransition:(UIColor *)color transitionType:(FMColorTransitionType)type {
    self.colorTransition.transitionColor = color;
    self.colorTransition.transitionType = type;
}

- (CGRect)dilloButtonFrame {
    CGFloat dimension = 100.;
    CGFloat padding = 20.f;
    return CGRectMake(padding, padding, dimension, dimension);
}

- (void)handleDilloButtonTap {
    [self performSegueWithIdentifier:@"Unwind" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *controller = [segue destinationViewController];
    controller.transitioningDelegate = self.colorTransition;
}
@end
