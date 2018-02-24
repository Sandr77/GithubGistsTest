//
//  UserModel.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id) initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    _identity = [dict[@"id"] stringValue];
    _name = dict[@"login"];
    _avatarUrlString = dict[@"avatar_url"];
    
    return self;
}

@end
