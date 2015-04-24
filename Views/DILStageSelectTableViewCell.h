//
//  DILStageSelectTableViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFStage.h"

@interface DILStageSelectTableViewCell : UITableViewCell
- (void)configureCellWithStage:(DILPFStage *)stage;
+ (NSString *)identifier;

@end
