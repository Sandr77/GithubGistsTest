//
//  Commit.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "Commit.h"
#import "NSString+Ext.h"

@implementation Commit

-(id) initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    _date = [dict[@"committed_at"] date];
    _username = dict[@"user"][@"login"];
    _additions = [dict[@"change_status"][@"additions"] intValue];
    _deletions = [dict[@"change_status"][@"deletions"] intValue];
    
    return self;
}

@end
