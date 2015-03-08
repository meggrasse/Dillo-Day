//
//  DirectionLabelView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectionLabelView : UIView
- (id)initWithTitle:(NSString *)title image:(UIImage *)image onTap:(void (^)(void))tapBlock;
@end
