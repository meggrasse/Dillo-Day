//
//  MainCSViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "MainCSViewController.h"
#import "DirectionLabelView.h"
#import <Masonry/Masonry.h>
#import <Colours/Colours.h>

@interface MainCSViewController ()

@end

@implementation MainCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)configureNavigationButtons {
    DirectionLabelView *lineupDirection = [[DirectionLabelView alloc] initWithTitle:@"lineup" image:[UIImage imageNamed:@"up7"] onTap:^{
        NSLog(@"Tapped lineup");
    }];
    
    DirectionLabelView *mapDirection = [[DirectionLabelView alloc] initWithTitle:@"map" image:[UIImage imageNamed:@"right11"] onTap:^{
        NSLog(@"Tapped map");
    }];
    
    DirectionLabelView *merchDirection = [[DirectionLabelView alloc] initWithTitle:@"merch" image:[UIImage imageNamed:@"down126"] onTap:^{
        NSLog(@"Tapped merch");
    }];
    
    DirectionLabelView *socialDirection = [[DirectionLabelView alloc] initWithTitle:@"social" image:[UIImage imageNamed:@"left15"] onTap:^{
        NSLog(@"Tapped social");
    }];
    
    DirectionLabelView *helpDirection = [[DirectionLabelView alloc] initWithTitle:@"help" image:[UIImage imageNamed:@"record8"] onTap:^{
        NSLog(@"Tapped help");
    }];
    
    for (UIView *view in @[lineupDirection, mapDirection, merchDirection, socialDirection, helpDirection]) {
        [self.view addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(lineupDirection, mapDirection, merchDirection, socialDirection, helpDirection);
    NSDictionary *metricDict = @{@"top" : @150,
                                 @"abovePadding" : @50,
                                 @"rightPadding" : @20};
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lineupDirection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(rightPadding)-[lineupDirection]|" options:0 metrics:metricDict views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(rightPadding)-[mapDirection]" options:0 metrics:metricDict views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(rightPadding)-[merchDirection]" options:0 metrics:metricDict views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(rightPadding)-[socialDirection]" options:0 metrics:metricDict views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(rightPadding)-[helpDirection]" options:0 metrics:metricDict views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[lineupDirection]-(abovePadding)-[mapDirection]-(abovePadding)-[merchDirection]-(abovePadding)-[socialDirection]-(abovePadding)-[helpDirection]" options:0 metrics:metricDict views:viewDict]];
    
    /*
    NSArray *viewArray = @[lineupDirection, mapDirection, merchDirection, socialDirection, helpDirection];
    for (int i = 0; i < [viewArray count]; i++) {
        UIEdgeInsets padding = UIEdgeInsetsMake(50, 0, 0, 0);
        UIView *view = viewArray[i];
        if (i == 0) {
            padding.top = 100;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                UIView *superview = view.superview;
                make.top.equalTo(superview.mas_top).with.offset(padding.top);
                make.right.equalTo(superview.mas_right).with.offset(padding.right);
            }];
        } else {
            UIView *aboveView = viewArray[i-1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                UIView *superview = view.superview;
                make.top.equalTo(aboveView.mas_bottom).with.offset(padding.top);
                make.right.equalTo(superview.mas_right).with.offset(padding.right);
            }];
        }
        
    }
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"lineup"]) {
        [self configureColorTransition:[UIColor robinEggColor] transitionType:FMColorTransitionTypeUp];
    } else if ([segue.identifier isEqualToString:@"merch"]) {
        [self configureColorTransition:[UIColor pinkLipstickColor] transitionType:FMColorTransitionTypeDown];
    } else if ([segue.identifier isEqualToString:@"social"]) {
        [self configureColorTransition:[UIColor lavenderColor] transitionType:FMColorTransitionTypeRight];
    } else if ([segue.identifier isEqualToString:@"help"]) {
        
    } else if ([segue.identifier isEqualToString:@"map"]) {
        [self configureColorTransition:[UIColor grassColor] transitionType:FMColorTransitionTypeLeft];
    }
}


@end
