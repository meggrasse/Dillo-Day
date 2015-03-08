//
//  NavigationTreeView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/13/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "NavigationTreeView.h"
#import "NSStack.h"

@interface NavigationTreeView()
@property (strong, nonatomic) NSStack *titleStack;
@property (strong, nonatomic) UIImageView *dilloImageView;
@property (strong, nonatomic) NSMutableArray *labelArray;
@end

@implementation NavigationTreeView
+ (id)sharedInstance {
    static NavigationTreeView *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
//        [sharedMyManager configureNavTreeView];
        sharedMyManager.labelArray = [NSMutableArray new];
        sharedMyManager.titleStack = [NSStack new];
        [sharedMyManager.titleStack push:@"VC1"];
        [sharedMyManager.titleStack push:@"VC2"];
        [sharedMyManager.titleStack push:@"ViewController3"];
        [sharedMyManager configureView];
    });
    return sharedMyManager;
}

/*
- (id)init {
    if (self = [super init]) {
        self.labelArray = [NSMutableArray new];
        self.titleStack = [NSStack new];
        [self.titleStack push:@"VC1"];
        [self.titleStack push:@"VC2"];
        [self.titleStack push:@"ViewController3"];
        [self configureView];
    }
    return self;
}
*/
- (void)configureView {
    UIEdgeInsets dilloImageViewFramePadding = UIEdgeInsetsMake(20, 20, 0, 0);
    CGFloat dilloImageViewSize = 50.f;
    CGRect dilloImageViewFrame = CGRectMake(dilloImageViewFramePadding.left, dilloImageViewFramePadding.top, dilloImageViewSize, dilloImageViewSize);
    self.dilloImageView = [[UIImageView alloc] initWithFrame:dilloImageViewFrame];
    self.dilloImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dilloImageView.backgroundColor = [UIColor clearColor];
    
    [self.labelArray removeAllObjects];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    for (int i = [self.titleStack size] - 1; i >= 0; i--) {
        NSString *vcTitle = (NSString *)[self.titleStack stack][i];
        CGSize vcTitleSize = [vcTitle sizeWithAttributes:@{NSFontAttributeName : font}];
        CGRect vcTitleLabelFrame = CGRectMake(0, 0, vcTitleSize.width, vcTitleSize.height);
        UILabel *vcTitleLabel = [[UILabel alloc] initWithFrame:vcTitleLabelFrame];
        vcTitleLabel.font = font;
        vcTitleLabel.text = vcTitle;
        vcTitleLabel.textColor = [UIColor blackColor];
        [self.labelArray addObject:vcTitleLabel];
    }
    
    CGSize separatorLabelSize = [@">" sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat padding = 10.f;
    //  |-(dilloImageViewFramePadding)-[dilloImageView]-(padding)-[label n]-(padding)-[>]-(padding)-...-[>]-(padding)-[label 0]     -(padding)-|
    //                                                 ^minY                                                                                  ^maxY
    CGFloat maxY = CGRectGetMaxY(self.bounds) - padding;
    CGFloat minY = CGRectGetMaxY(self.dilloImageView.frame) + padding;
    UILabel *separatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, separatorLabelSize.width, separatorLabelSize.height)];
    NSUInteger numLabels = 0;
    for (int i = 0; i < [self.labelArray count]; i++) {
        if (i == 0) {
            UILabel *label = self.labelArray[i];
            CGRect frame = label.frame;
            frame.origin.x = minY;
            frame.origin.y = (CGRectGetHeight(self.bounds)-CGRectGetHeight(frame))/2.0;
            label.frame = frame;
            [self addSubview:label];
        } else {
            UILabel *currentLabel = self.labelArray[i];
            CGRect currentLabelFrame = currentLabel.frame;
            currentLabelFrame.origin.x = minY;
            currentLabelFrame.origin.y = (CGRectGetHeight(self.bounds)-CGRectGetHeight(currentLabelFrame))/2.0;
            
            UILabel *lastLabel = self.labelArray[0];
            CGRect lastLabelFrame = lastLabel.frame;
            
            [self addSubview:currentLabel];
            if (lastLabelFrame.origin.x + CGRectGetWidth(currentLabelFrame) + padding < maxY) {
                for (int j = i-1; j >= 0; j--) {
                    UILabel *previousLabel = self.labelArray[j];
                    CGRect previousLabelFrame = previousLabel.frame;
                    previousLabelFrame.origin.x += CGRectGetWidth(currentLabelFrame) + padding;
                    previousLabel.frame = previousLabelFrame;
                }
            } else {
                break;
            }
        }
        numLabels++;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController {
    self.currentViewController = viewController;
    [self.titleStack push:viewController.title];
}

- (void)popViewController:(UIViewController *)viewController {
    [self.titleStack pop];
}

- (void)updateNavigationTree {
    
}

- (void)addNavigationTreeViewToViewController:(UIViewController *)viewController {
    
}



@end
