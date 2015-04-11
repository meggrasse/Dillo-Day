//
//  DILParseClassGeneration.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILParseClassGeneration.h"

NSString *const kDILPFRoleAdminKey          = @"admin";
NSString *const kDILPFRoleMayfestExecKey    = @"mayfestExec";
NSString *const kDILPFRoleStudentKey        = @"student";

@implementation DILParseClassGeneration
+ (void)createAllRoles {
    [[self class] createAdminRole];
    [[self class] createMayfestExecRole];
    [[self class] createStudentRole];
}

+ (void)createAdminRole {
    PFRole *adminRole = [PFRole roleWithName:kDILPFRoleAdminKey acl:[PFACL ACL]];
    [adminRole save];
}

+ (void)createMayfestExecRole {
    PFRole *mayfestExecRole = [PFRole roleWithName:kDILPFRoleMayfestExecKey acl:[PFACL ACL]];
    [mayfestExecRole save];
}

+ (void)createStudentRole {
    PFRole *studentRole = [PFRole roleWithName:kDILPFRoleStudentKey acl:[PFACL ACL]];
    [studentRole save];
}
@end
