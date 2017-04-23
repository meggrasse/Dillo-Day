//
//  DilloDayStyleKit.m
//  Dillo Day
//
//  Created by Philip Meyers IV on 5/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "DilloDayStyleKit.h"


@implementation DilloDayStyleKit

#pragma mark Cache

static UIColor* _tabBarColor = nil;
static UIColor* _tabBarUnselectedColor = nil;
static UIColor* _tabBarSelectedColor = nil;
static UIColor* _navigationBarColor = nil;
static UIColor* _navigationBarTextColor = nil;
static UIColor* _barButtonItemColor = nil;
static UIColor* _barButtonItemHighlightedColor = nil;
static UIColor* _notificationCellBackgroundColor = nil;
static UIColor* _notificationIconColor = nil;
static UIColor* _fontColor = nil;
static UIColor* _artistInfoSegmentedControlSelectedSegmentIndicatorColor = nil;
static UIColor* _artistInfoSegmentedControlBackgroundColor = nil;
static UIColor* _artistInfoSponsoredByTextColor = nil;
static UIColor* _artistInfoBioTextColor = nil;
static UIColor* _artistInfoSegmentedControlTextColor = nil;
static UIColor* _notificationCellTimeAgoTextColor = nil;
static UIColor* _notificationCellMessageTextColor = nil;
static UIColor* _lineupCellProgressColor = nil;

static UIImage* _imageOfNotificationIndicatorRead = nil;
static UIImage* _imageOfNotificationIndicatorUnread = nil;

#pragma mark Initialization

+ (void)initialize
{
    // Colors Initialization
    _tabBarColor = [UIColor colorWithRed: 0.173 green: 0.173 blue: 0.173 alpha: 1];
    _tabBarUnselectedColor = [UIColor colorWithRed: 0.933 green: 0.961 blue: 0.957 alpha: 1];
    _tabBarSelectedColor = [UIColor colorWithRed:0.35 green:0.68 blue:0.25 alpha:1.0];
    _notificationIconColor = DilloDayStyleKit.tabBarSelectedColor;
    _artistInfoSegmentedControlSelectedSegmentIndicatorColor = DilloDayStyleKit.tabBarSelectedColor;
    _lineupCellProgressColor = DilloDayStyleKit.tabBarSelectedColor;
    _navigationBarColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    _barButtonItemColor = [UIColor colorWithRed:0.35 green:0.68 blue:0.25 alpha:1.0];
    CGFloat barButtonItemColorHSBA[4];
    [_barButtonItemColor getHue: &barButtonItemColorHSBA[0] saturation: &barButtonItemColorHSBA[1] brightness: &barButtonItemColorHSBA[2] alpha: &barButtonItemColorHSBA[3]];

    _barButtonItemHighlightedColor = [UIColor colorWithHue: barButtonItemColorHSBA[0] saturation: barButtonItemColorHSBA[1] brightness: 1 alpha: barButtonItemColorHSBA[3]];
    _notificationCellBackgroundColor = [UIColor colorWithRed: 0.973 green: 1 blue: 0.996 alpha: 1];
    _fontColor = [UIColor colorWithRed: 0.165 green: 0.165 blue: 0.165 alpha: 1];
    _navigationBarTextColor = DilloDayStyleKit.fontColor;
    _artistInfoSegmentedControlBackgroundColor = [UIColor colorWithRed: 0.427 green: 0.467 blue: 0.471 alpha: 1];
    _artistInfoSponsoredByTextColor = [UIColor colorWithRed:0.35 green:0.68 blue:0.25 alpha:1.0];
    _artistInfoBioTextColor = [UIColor colorWithRed: 0.29 green: 0.29 blue: 0.29 alpha: 1];
    _artistInfoSegmentedControlTextColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    _notificationCellTimeAgoTextColor = [UIColor colorWithRed: 0.463 green: 0.463 blue: 0.463 alpha: 1];
    _notificationCellMessageTextColor = [UIColor colorWithRed: 0.216 green: 0.216 blue: 0.216 alpha: 1];

}

#pragma mark Colors

+ (UIColor*)tabBarColor { return _tabBarColor; }
+ (UIColor*)tabBarUnselectedColor { return _tabBarUnselectedColor; }
+ (UIColor*)tabBarSelectedColor { return _tabBarSelectedColor; }
+ (UIColor*)navigationBarColor { return _navigationBarColor; }
+ (UIColor*)navigationBarTextColor { return _navigationBarTextColor; }
+ (UIColor*)barButtonItemColor { return _barButtonItemColor; }
+ (UIColor*)barButtonItemHighlightedColor { return _barButtonItemHighlightedColor; }
+ (UIColor*)notificationCellBackgroundColor { return _notificationCellBackgroundColor; }
+ (UIColor*)notificationIconColor { return _notificationIconColor; }
+ (UIColor*)fontColor { return _fontColor; }
+ (UIColor*)artistInfoSegmentedControlSelectedSegmentIndicatorColor { return _artistInfoSegmentedControlSelectedSegmentIndicatorColor; }
+ (UIColor*)artistInfoSegmentedControlBackgroundColor { return _artistInfoSegmentedControlBackgroundColor; }
+ (UIColor*)artistInfoSponsoredByTextColor { return _artistInfoSponsoredByTextColor; }
+ (UIColor*)artistInfoBioTextColor { return _artistInfoBioTextColor; }
+ (UIColor*)artistInfoSegmentedControlTextColor { return _artistInfoSegmentedControlTextColor; }
+ (UIColor*)notificationCellTimeAgoTextColor { return _notificationCellTimeAgoTextColor; }
+ (UIColor*)notificationCellMessageTextColor { return _notificationCellMessageTextColor; }
+ (UIColor*)lineupCellProgressColor { return _lineupCellProgressColor; }

#pragma mark Drawing Methods

+ (void)drawHelpIconWithFrame: (CGRect)frame
{


    //// Subframes
    CGRect launch = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 188.21) * -0.04054 - 0.06) + 0.56, CGRectGetMinY(frame) + CGRectGetHeight(frame) - 205.36, 188.21, 189.34);


    //// Launch
    {
        //// Group
        {
            //// Dock-Icons
            {
                //// !-+-Oval-3-Copy
                {
                    //// Oval-3 Drawing
                    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(launch), CGRectGetMinY(launch), 188.21, 189.34)];
                    [DilloDayStyleKit.tabBarSelectedColor setStroke];
                    oval3Path.lineWidth = 14.4;
                    [oval3Path stroke];


                    //// Rectangle 2 Drawing
                    UIBezierPath* rectangle2Path = UIBezierPath.bezierPath;
                    [rectangle2Path moveToPoint: CGPointMake(CGRectGetMinX(launch) + 81.45, CGRectGetMinY(launch) + 117.9)];
                    [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(launch) + 81.45, CGRectGetMinY(launch) + 113.63)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 84.3, CGRectGetMinY(launch) + 98.4) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 81.45, CGRectGetMinY(launch) + 107.46) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 82.4, CGRectGetMinY(launch) + 102.38)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 94.9, CGRectGetMinY(launch) + 85.79) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 86.19, CGRectGetMinY(launch) + 94.42) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 89.73, CGRectGetMinY(launch) + 90.22)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 108.46, CGRectGetMinY(launch) + 72.1) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 102.07, CGRectGetMinY(launch) + 79.72) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 106.59, CGRectGetMinY(launch) + 75.16)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 111.27, CGRectGetMinY(launch) + 61.03) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 110.33, CGRectGetMinY(launch) + 69.04) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 111.27, CGRectGetMinY(launch) + 65.35)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 106.09, CGRectGetMinY(launch) + 48.57) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 111.27, CGRectGetMinY(launch) + 55.65) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 109.54, CGRectGetMinY(launch) + 51.49)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 91.18, CGRectGetMinY(launch) + 44.18) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 102.63, CGRectGetMinY(launch) + 45.64) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 97.66, CGRectGetMinY(launch) + 44.18)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 79, CGRectGetMinY(launch) + 45.64) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 87.01, CGRectGetMinY(launch) + 44.18) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 82.95, CGRectGetMinY(launch) + 44.67)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 65.39, CGRectGetMinY(launch) + 50.98) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 75.04, CGRectGetMinY(launch) + 46.62) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 70.51, CGRectGetMinY(launch) + 48.4)];
                    [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(launch) + 60.72, CGRectGetMinY(launch) + 40.3)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 91.97, CGRectGetMinY(launch) + 32.47) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 70.69, CGRectGetMinY(launch) + 35.08) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 81.11, CGRectGetMinY(launch) + 32.47)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 115.46, CGRectGetMinY(launch) + 39.91) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 102.04, CGRectGetMinY(launch) + 32.47) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 109.87, CGRectGetMinY(launch) + 34.95)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 123.85, CGRectGetMinY(launch) + 60.87) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 121.05, CGRectGetMinY(launch) + 44.86) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 123.85, CGRectGetMinY(launch) + 51.85)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 122.3, CGRectGetMinY(launch) + 71.03) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 123.85, CGRectGetMinY(launch) + 64.72) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 123.33, CGRectGetMinY(launch) + 68.11)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 117.76, CGRectGetMinY(launch) + 79.34) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 121.28, CGRectGetMinY(launch) + 73.96) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 119.76, CGRectGetMinY(launch) + 76.73)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 104.78, CGRectGetMinY(launch) + 91.96) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 115.75, CGRectGetMinY(launch) + 81.95) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 111.43, CGRectGetMinY(launch) + 86.15)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 94.22, CGRectGetMinY(launch) + 103.27) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 99.46, CGRectGetMinY(launch) + 96.49) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 95.94, CGRectGetMinY(launch) + 100.26)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 91.65, CGRectGetMinY(launch) + 115.29) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 92.51, CGRectGetMinY(launch) + 106.27) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 91.65, CGRectGetMinY(launch) + 110.28)];
                    [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(launch) + 91.65, CGRectGetMinY(launch) + 117.9)];
                    [rectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(launch) + 81.45, CGRectGetMinY(launch) + 117.9)];
                    [rectangle2Path closePath];
                    [rectangle2Path moveToPoint: CGPointMake(CGRectGetMinX(launch) + 77.57, CGRectGetMinY(launch) + 141.39)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 87.07, CGRectGetMinY(launch) + 130.64) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 77.57, CGRectGetMinY(launch) + 134.22) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 80.74, CGRectGetMinY(launch) + 130.64)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 94.14, CGRectGetMinY(launch) + 133.4) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 90.12, CGRectGetMinY(launch) + 130.64) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 92.48, CGRectGetMinY(launch) + 131.56)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 96.64, CGRectGetMinY(launch) + 141.39) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 95.81, CGRectGetMinY(launch) + 135.25) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 96.64, CGRectGetMinY(launch) + 137.91)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 94.11, CGRectGetMinY(launch) + 149.26) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 96.64, CGRectGetMinY(launch) + 144.77) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 95.79, CGRectGetMinY(launch) + 147.39)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 87.07, CGRectGetMinY(launch) + 152.07) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 92.42, CGRectGetMinY(launch) + 151.14) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 90.07, CGRectGetMinY(launch) + 152.07)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 80.26, CGRectGetMinY(launch) + 149.58) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 84.32, CGRectGetMinY(launch) + 152.07) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 82.06, CGRectGetMinY(launch) + 151.24)];
                    [rectangle2Path addCurveToPoint: CGPointMake(CGRectGetMinX(launch) + 77.57, CGRectGetMinY(launch) + 141.39) controlPoint1: CGPointMake(CGRectGetMinX(launch) + 78.47, CGRectGetMinY(launch) + 147.92) controlPoint2: CGPointMake(CGRectGetMinX(launch) + 77.57, CGRectGetMinY(launch) + 145.19)];
                    [rectangle2Path closePath];
                    [DilloDayStyleKit.tabBarSelectedColor setFill];
                    [rectangle2Path fill];
                }
            }
        }
    }
}

+ (void)drawNotificationsIcon
{

    //// Launch
    {
        //// Dock-Icons
        {
            //// Oval-6-+-Oval-1-Copy-2
            {
                //// Oval-1-Copy-2 Drawing
                UIBezierPath* oval1Copy2Path = UIBezierPath.bezierPath;
                [oval1Copy2Path moveToPoint: CGPointMake(28, 95.91)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(1.74, 168.24) controlPoint1: CGPointMake(28, 138.75) controlPoint2: CGPointMake(-8.2, 151.57)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(90.41, 184.96) controlPoint1: CGPointMake(6.86, 176.82) controlPoint2: CGPointMake(50.36, 184.96)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(180.24, 168.24) controlPoint1: CGPointMake(130.46, 184.96) controlPoint2: CGPointMake(176.76, 175.81)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(148.63, 95.91) controlPoint1: CGPointMake(187.43, 152.64) controlPoint2: CGPointMake(148.63, 139.39)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(148.63, 52.69) controlPoint1: CGPointMake(148.63, 52.44) controlPoint2: CGPointMake(148.63, 59.08)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(90.41, 0) controlPoint1: CGPointMake(148.63, 19.38) controlPoint2: CGPointMake(123.72, 0)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(28, 52.69) controlPoint1: CGPointMake(57.1, 0) controlPoint2: CGPointMake(28, 19.38)];
                [oval1Copy2Path addCurveToPoint: CGPointMake(28, 95.91) controlPoint1: CGPointMake(28, 59.34) controlPoint2: CGPointMake(28, 53.08)];
                [oval1Copy2Path closePath];
                oval1Copy2Path.miterLimit = 4;

                oval1Copy2Path.usesEvenOddFillRule = YES;

                [DilloDayStyleKit.tabBarSelectedColor setFill];
                [oval1Copy2Path fill];


                //// Oval-6 Drawing
                UIBezierPath* oval6Path = UIBezierPath.bezierPath;
                [oval6Path moveToPoint: CGPointMake(107.99, 188.42)];
                [oval6Path addCurveToPoint: CGPointMake(108, 189) controlPoint1: CGPointMake(108, 188.61) controlPoint2: CGPointMake(108, 188.81)];
                [oval6Path addCurveToPoint: CGPointMake(91, 206) controlPoint1: CGPointMake(108, 198.39) controlPoint2: CGPointMake(100.39, 206)];
                [oval6Path addCurveToPoint: CGPointMake(74, 189) controlPoint1: CGPointMake(81.61, 206) controlPoint2: CGPointMake(74, 198.39)];
                [oval6Path addCurveToPoint: CGPointMake(74.01, 188.53) controlPoint1: CGPointMake(74, 188.84) controlPoint2: CGPointMake(74, 188.69)];
                [oval6Path addCurveToPoint: CGPointMake(90.41, 188.96) controlPoint1: CGPointMake(79.47, 188.81) controlPoint2: CGPointMake(84.97, 188.96)];
                [oval6Path addCurveToPoint: CGPointMake(107.99, 188.42) controlPoint1: CGPointMake(96.19, 188.96) controlPoint2: CGPointMake(102.1, 188.77)];
                [oval6Path closePath];
                oval6Path.miterLimit = 4;

                oval6Path.usesEvenOddFillRule = YES;

                [DilloDayStyleKit.tabBarSelectedColor setFill];
                [oval6Path fill];
            }
        }
    }
}

+ (void)drawMapIcon
{

    //// Launch
    {
        //// Dock-Icons
        {
            //// Oval-1 Drawing
            UIBezierPath* oval1Path = UIBezierPath.bezierPath;
            [oval1Path moveToPoint: CGPointMake(60.5, 220)];
            [oval1Path addCurveToPoint: CGPointMake(121, 60.31) controlPoint1: CGPointMake(68.85, 220) controlPoint2: CGPointMake(121, 93.62)];
            [oval1Path addCurveToPoint: CGPointMake(60.5, 0) controlPoint1: CGPointMake(121, 27) controlPoint2: CGPointMake(93.91, 0)];
            [oval1Path addCurveToPoint: CGPointMake(0, 60.31) controlPoint1: CGPointMake(27.09, 0) controlPoint2: CGPointMake(0, 27)];
            [oval1Path addCurveToPoint: CGPointMake(60.5, 220) controlPoint1: CGPointMake(0, 93.62) controlPoint2: CGPointMake(52.15, 220)];
            [oval1Path closePath];
            [oval1Path moveToPoint: CGPointMake(60.19, 80)];
            [oval1Path addCurveToPoint: CGPointMake(82.25, 58) controlPoint1: CGPointMake(72.37, 80) controlPoint2: CGPointMake(82.25, 70.15)];
            [oval1Path addCurveToPoint: CGPointMake(60.19, 36) controlPoint1: CGPointMake(82.25, 45.85) controlPoint2: CGPointMake(72.37, 36)];
            [oval1Path addCurveToPoint: CGPointMake(38.12, 58) controlPoint1: CGPointMake(48, 36) controlPoint2: CGPointMake(38.12, 45.85)];
            [oval1Path addCurveToPoint: CGPointMake(60.19, 80) controlPoint1: CGPointMake(38.12, 70.15) controlPoint2: CGPointMake(48, 80)];
            [oval1Path closePath];
            oval1Path.miterLimit = 4;

            oval1Path.usesEvenOddFillRule = YES;

            [DilloDayStyleKit.tabBarSelectedColor setFill];
            NSLog(@"%@", DilloDayStyleKit.tabBarSelectedColor);
            [oval1Path fill];
        }
    }
}

+ (void)drawLineupIcon
{

    //// Launch
    {
        //// Dock-Icons
        {
            //// Logo Drawing
            UIBezierPath* logoPath = UIBezierPath.bezierPath;
            [logoPath moveToPoint: CGPointMake(88.33, 157.34)];
            [logoPath addCurveToPoint: CGPointMake(51.23, 178.55) controlPoint1: CGPointMake(77.96, 166.05) controlPoint2: CGPointMake(56.14, 181.27)];
            [logoPath addCurveToPoint: CGPointMake(45.23, 20.85) controlPoint1: CGPointMake(-34.85, 130.89) controlPoint2: CGPointMake(4.85, 52.94)];
            [logoPath addCurveToPoint: CGPointMake(191.45, 29.55) controlPoint1: CGPointMake(85.6, -11.23) controlPoint2: CGPointMake(166.35, -4.7)];
            [logoPath addCurveToPoint: CGPointMake(184.35, 62.73) controlPoint1: CGPointMake(200.38, 41.74) controlPoint2: CGPointMake(184.85, 55.57)];
            [logoPath addCurveToPoint: CGPointMake(191.45, 87.74) controlPoint1: CGPointMake(183.59, 73.84) controlPoint2: CGPointMake(190.35, 83.48)];
            [logoPath addCurveToPoint: CGPointMake(188.72, 104.6) controlPoint1: CGPointMake(192.54, 92) controlPoint2: CGPointMake(196.9, 96.44)];
            [logoPath addCurveToPoint: CGPointMake(147.25, 129.61) controlPoint1: CGPointMake(180.53, 112.75) controlPoint2: CGPointMake(165.26, 125.26)];
            [logoPath addCurveToPoint: CGPointMake(109.06, 125.26) controlPoint1: CGPointMake(129.25, 133.96) controlPoint2: CGPointMake(111.24, 123.63)];
            [logoPath addCurveToPoint: CGPointMake(88.33, 157.34) controlPoint1: CGPointMake(106.88, 126.89) controlPoint2: CGPointMake(98.7, 148.64)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(17.39, 163.3)];
            [logoPath addCurveToPoint: CGPointMake(130.89, 218.79) controlPoint1: CGPointMake(16.33, 166.04) controlPoint2: CGPointMake(48.5, 237.83)];
            [logoPath addCurveToPoint: CGPointMake(211.09, 141.03) controlPoint1: CGPointMake(213.27, 199.76) controlPoint2: CGPointMake(218.18, 145.38)];
            [logoPath addCurveToPoint: CGPointMake(131.98, 188.34) controlPoint1: CGPointMake(203.99, 136.68) controlPoint2: CGPointMake(183.26, 181.34)];
            [logoPath addCurveToPoint: CGPointMake(73.6, 175.83) controlPoint1: CGPointMake(80.69, 195.34) controlPoint2: CGPointMake(79.05, 173.66)];
            [logoPath addCurveToPoint: CGPointMake(52.87, 185.62) controlPoint1: CGPointMake(68.14, 178.01) controlPoint2: CGPointMake(65.96, 184.53)];
            [logoPath addCurveToPoint: CGPointMake(17.39, 163.3) controlPoint1: CGPointMake(39.77, 186.71) controlPoint2: CGPointMake(18.45, 160.56)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(101.97, 152.41)];
            [logoPath addCurveToPoint: CGPointMake(112.88, 135.59) controlPoint1: CGPointMake(108.7, 141.53) controlPoint2: CGPointMake(111.02, 135.59)];
            [logoPath addCurveToPoint: CGPointMake(126.09, 148.06) controlPoint1: CGPointMake(116.7, 135.59) controlPoint2: CGPointMake(111.64, 140.38)];
            [logoPath addCurveToPoint: CGPointMake(136.96, 159.25) controlPoint1: CGPointMake(134.27, 152.41) controlPoint2: CGPointMake(134.78, 155.2)];
            [logoPath addCurveToPoint: CGPointMake(142.34, 173.11) controlPoint1: CGPointMake(139.13, 163.3) controlPoint2: CGPointMake(142.34, 173.11)];
            [logoPath addCurveToPoint: CGPointMake(131.43, 169.85) controlPoint1: CGPointMake(142.34, 173.11) controlPoint2: CGPointMake(134.16, 168.22)];
            [logoPath addCurveToPoint: CGPointMake(130.34, 180.73) controlPoint1: CGPointMake(128.7, 171.48) controlPoint2: CGPointMake(130.34, 180.73)];
            [logoPath addCurveToPoint: CGPointMake(119.43, 173.66) controlPoint1: CGPointMake(130.34, 180.73) controlPoint2: CGPointMake(122.16, 172.03)];
            [logoPath addCurveToPoint: CGPointMake(116.15, 182.9) controlPoint1: CGPointMake(116.7, 175.29) controlPoint2: CGPointMake(116.15, 182.9)];
            [logoPath addLineToPoint: CGPointMake(101.97, 173.11)];
            [logoPath addCurveToPoint: CGPointMake(85.06, 169.85) controlPoint1: CGPointMake(101.97, 173.11) controlPoint2: CGPointMake(85.06, 173.11)];
            [logoPath addCurveToPoint: CGPointMake(101.97, 152.41) controlPoint1: CGPointMake(85.06, 168.18) controlPoint2: CGPointMake(95.24, 163.3)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(125.97, 135.05)];
            [logoPath addCurveToPoint: CGPointMake(145.65, 137.17) controlPoint1: CGPointMake(128.31, 134.53) controlPoint2: CGPointMake(136.96, 139.35)];
            [logoPath addCurveToPoint: CGPointMake(163.04, 130.64) controlPoint1: CGPointMake(154.35, 135) controlPoint2: CGPointMake(161.38, 130.64)];
            [logoPath addCurveToPoint: CGPointMake(168.53, 143.75) controlPoint1: CGPointMake(164.71, 130.64) controlPoint2: CGPointMake(165.28, 136.57)];
            [logoPath addCurveToPoint: CGPointMake(176.17, 156.26) controlPoint1: CGPointMake(171.45, 150.18) controlPoint2: CGPointMake(176.17, 156.26)];
            [logoPath addCurveToPoint: CGPointMake(164.71, 156.26) controlPoint1: CGPointMake(176.17, 156.26) controlPoint2: CGPointMake(166.89, 155.17)];
            [logoPath addCurveToPoint: CGPointMake(160.89, 166.05) controlPoint1: CGPointMake(162.53, 157.34) controlPoint2: CGPointMake(160.89, 166.05)];
            [logoPath addCurveToPoint: CGPointMake(154.35, 161.15) controlPoint1: CGPointMake(160.89, 166.05) controlPoint2: CGPointMake(155.98, 161.15)];
            [logoPath addCurveToPoint: CGPointMake(147.25, 172.03) controlPoint1: CGPointMake(152.71, 161.15) controlPoint2: CGPointMake(147.25, 172.03)];
            [logoPath addCurveToPoint: CGPointMake(141.25, 151.91) controlPoint1: CGPointMake(147.25, 172.03) controlPoint2: CGPointMake(146.6, 161.2)];
            [logoPath addCurveToPoint: CGPointMake(125.97, 135.05) controlPoint1: CGPointMake(135.9, 142.61) controlPoint2: CGPointMake(121.06, 136.14)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(171.74, 126.29)];
            [logoPath addCurveToPoint: CGPointMake(189.13, 113.22) controlPoint1: CGPointMake(173.38, 124.11) controlPoint2: CGPointMake(186.96, 113.22)];
            [logoPath addCurveToPoint: CGPointMake(195.81, 125.26) controlPoint1: CGPointMake(191.3, 113.22) controlPoint2: CGPointMake(193.35, 121.77)];
            [logoPath addCurveToPoint: CGPointMake(202.9, 133.96) controlPoint1: CGPointMake(198.08, 128.48) controlPoint2: CGPointMake(202.9, 133.96)];
            [logoPath addCurveToPoint: CGPointMake(192.54, 135.05) controlPoint1: CGPointMake(202.9, 133.96) controlPoint2: CGPointMake(193.63, 136.68)];
            [logoPath addCurveToPoint: CGPointMake(193.08, 143.75) controlPoint1: CGPointMake(191.45, 133.42) controlPoint2: CGPointMake(193.08, 143.75)];
            [logoPath addCurveToPoint: CGPointMake(183.26, 143.75) controlPoint1: CGPointMake(193.08, 143.75) controlPoint2: CGPointMake(183.81, 142.66)];
            [logoPath addCurveToPoint: CGPointMake(182.17, 151.91) controlPoint1: CGPointMake(182.72, 144.84) controlPoint2: CGPointMake(182.17, 151.91)];
            [logoPath addCurveToPoint: CGPointMake(172.35, 139.4) controlPoint1: CGPointMake(182.17, 151.91) controlPoint2: CGPointMake(173.44, 144.84)];
            [logoPath addCurveToPoint: CGPointMake(171.74, 126.29) controlPoint1: CGPointMake(171.26, 133.96) controlPoint2: CGPointMake(170.1, 128.46)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(201.27, 42.61)];
            [logoPath addCurveToPoint: CGPointMake(227.46, 77.95) controlPoint1: CGPointMake(209.45, 39.89) controlPoint2: CGPointMake(227.46, 70.34)];
            [logoPath addCurveToPoint: CGPointMake(246.01, 93.72) controlPoint1: CGPointMake(227.46, 81.34) controlPoint2: CGPointMake(242.19, 83.93)];
            [logoPath addCurveToPoint: CGPointMake(242.19, 123.63) controlPoint1: CGPointMake(249.89, 103.69) controlPoint2: CGPointMake(240.55, 115.47)];
            [logoPath addCurveToPoint: CGPointMake(249.82, 139.94) controlPoint1: CGPointMake(243.82, 131.79) controlPoint2: CGPointMake(249.28, 138.31)];
            [logoPath addCurveToPoint: CGPointMake(243.28, 154.08) controlPoint1: CGPointMake(250.37, 141.57) controlPoint2: CGPointMake(250.01, 150.33)];
            [logoPath addCurveToPoint: CGPointMake(226.36, 152.99) controlPoint1: CGPointMake(235.82, 158.23) controlPoint2: CGPointMake(233.03, 157.81)];
            [logoPath addCurveToPoint: CGPointMake(215.45, 133.96) controlPoint1: CGPointMake(219.7, 148.18) controlPoint2: CGPointMake(217.09, 136.14)];
            [logoPath addCurveToPoint: CGPointMake(200.72, 123.63) controlPoint1: CGPointMake(213.82, 131.79) controlPoint2: CGPointMake(202.9, 128.52)];
            [logoPath addCurveToPoint: CGPointMake(207.27, 102.97) controlPoint1: CGPointMake(198.54, 118.74) controlPoint2: CGPointMake(207.27, 102.97)];
            [logoPath addCurveToPoint: CGPointMake(207.27, 89.37) controlPoint1: CGPointMake(207.27, 102.97) controlPoint2: CGPointMake(211.63, 93.18)];
            [logoPath addCurveToPoint: CGPointMake(193.63, 73.6) controlPoint1: CGPointMake(202.9, 85.56) controlPoint2: CGPointMake(195.27, 79.04)];
            [logoPath addCurveToPoint: CGPointMake(201.27, 42.61) controlPoint1: CGPointMake(191.99, 68.16) controlPoint2: CGPointMake(193.08, 45.32)];
            [logoPath closePath];
            [logoPath moveToPoint: CGPointMake(228, 62.73)];
            [logoPath addCurveToPoint: CGPointMake(233.46, 72.51) controlPoint1: CGPointMake(231.79, 67.62) controlPoint2: CGPointMake(232.89, 72.51)];
            [logoPath addCurveToPoint: CGPointMake(239.46, 55.11) controlPoint1: CGPointMake(234.55, 72.51) controlPoint2: CGPointMake(239.86, 62.91)];
            [logoPath addCurveToPoint: CGPointMake(231.27, 40.97) controlPoint1: CGPointMake(239.05, 47.31) controlPoint2: CGPointMake(232.37, 40.43)];
            [logoPath addCurveToPoint: CGPointMake(224.73, 51.31) controlPoint1: CGPointMake(230.18, 41.52) controlPoint2: CGPointMake(228.55, 46.96)];
            [logoPath addCurveToPoint: CGPointMake(228, 62.73) controlPoint1: CGPointMake(222.89, 53.4) controlPoint2: CGPointMake(224.21, 57.83)];
            [logoPath closePath];
            logoPath.miterLimit = 4;

            logoPath.usesEvenOddFillRule = YES;

            [DilloDayStyleKit.tabBarSelectedColor setFill];
            [logoPath fill];
        }
    }
}

+ (void)drawLineupCellRadialFadeWithCellFrame: (CGRect)cellFrame
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.182 green: 0.182 blue: 0.182 alpha: 0.48];

    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 0.5, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor2.CGColor, (id)[gradientColor2 blendedColorWithFraction: 0.5 ofColor: gradientColor].CGColor, (id)gradientColor.CGColor], gradientLocations);

    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGFloat rectangleResizeRatio = MIN(CGRectGetWidth(rectangleRect) / 539, CGRectGetHeight(rectangleRect) / 230);
    CGContextDrawRadialGradient(context, gradient,
        CGPointMake(CGRectGetMidX(rectangleRect) + 0 * rectangleResizeRatio, CGRectGetMidY(rectangleRect) + 0 * rectangleResizeRatio), 2.02 * rectangleResizeRatio,
        CGPointMake(CGRectGetMidX(rectangleRect) + 0 * rectangleResizeRatio, CGRectGetMidY(rectangleRect) + 0 * rectangleResizeRatio), 284.28 * rectangleResizeRatio,
        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);


    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)drawNotificationIndicatorRead
{
    //// Color Declarations
    UIColor* notificationIndicatorColor = [UIColor colorWithRed:0.35 green:0.68 blue:0.25 alpha:1.0];

    //// Group 3
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1.5, 1.5, 38, 38)];
        [notificationIndicatorColor setStroke];
        ovalPath.lineWidth = 3;
        [ovalPath stroke];
    }
}

+ (void)drawNotificationIndicatorUnread
{
    //// Color Declarations
    UIColor* notificationIndicatorColor = [UIColor colorWithRed:0.35 green:0.68 blue:0.25 alpha:1.0];

    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1.5, 1.5, 38, 38)];
    [notificationIndicatorColor setFill];
    [oval2Path fill];
    [notificationIndicatorColor setStroke];
    oval2Path.lineWidth = 3;
    [oval2Path stroke];
}

#pragma mark Generated Images

+ (UIImage*)imageOfNotificationIndicatorRead
{
    if (_imageOfNotificationIndicatorRead)
        return _imageOfNotificationIndicatorRead;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(44, 44), NO, 0.0f);
    [DilloDayStyleKit drawNotificationIndicatorRead];

    _imageOfNotificationIndicatorRead = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfNotificationIndicatorRead;
}

+ (UIImage*)imageOfNotificationIndicatorUnread
{
    if (_imageOfNotificationIndicatorUnread)
        return _imageOfNotificationIndicatorUnread;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(48, 44), NO, 0.0f);
    [DilloDayStyleKit drawNotificationIndicatorUnread];

    _imageOfNotificationIndicatorUnread = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfNotificationIndicatorUnread;
}

#pragma mark Customization Infrastructure

- (void)setNotificationIndicatorReadTargets: (NSArray*)notificationIndicatorReadTargets
{
    _notificationIndicatorReadTargets = notificationIndicatorReadTargets;

    for (id target in self.notificationIndicatorReadTargets)
        [target setImage: DilloDayStyleKit.imageOfNotificationIndicatorRead];
}

- (void)setNotificationIndicatorUnreadTargets: (NSArray*)notificationIndicatorUnreadTargets
{
    _notificationIndicatorUnreadTargets = notificationIndicatorUnreadTargets;

    for (id target in self.notificationIndicatorUnreadTargets)
        [target setImage: DilloDayStyleKit.imageOfNotificationIndicatorUnread];
}


@end



@implementation UIColor (PaintCodeAdditions)

- (UIColor*)blendedColorWithFraction: (CGFloat)fraction ofColor: (UIColor*)color2
{
    UIColor* color1 = self;

    CGFloat r1 = 0, g1 = 0, b1 = 0, a1 = 0;
    CGFloat r2 = 0, g2 = 0, b2 = 0, a2 = 0;


    [color1 getRed: &r1 green: &g1 blue: &b1 alpha: &a1];
    [color2 getRed: &r2 green: &g2 blue: &b2 alpha: &a2];

    CGFloat r = r1 * (1 - fraction) + r2 * fraction;
    CGFloat g = g1 * (1 - fraction) + g2 * fraction;
    CGFloat b = b1 * (1 - fraction) + b2 * fraction;
    CGFloat a = a1 * (1 - fraction) + a2 * fraction;

    return [UIColor colorWithRed: r green: g blue: b alpha: a];
}

@end
