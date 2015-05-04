//
//  DILParseClassGeneration.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

extern NSString *const kDILPFRoleAdminKey;
extern NSString *const kDILPFRoleMayfestExecKey;
extern NSString *const kDILPFRoleStudentKey;

@interface DILParseClassGeneration : NSObject
+ (void)createAllRoles;
+ (void)createAdminRole;
+ (void)createMayfestExecRole;
+ (void)createStudentRole;
@end
