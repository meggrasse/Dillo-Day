//
//  NSObject+DILPFMapFeatures.h
//  Dillo Day
//
//  Created by Meg Grasse on 4/29/16.
//  Copyright © 2016 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

extern NSString *const kDILPFMapFeaturesClassKey;

@interface DILPFMapFeatures : PFObject<PFSubclassing>
@property (retain) CLLocation *location;


@end

