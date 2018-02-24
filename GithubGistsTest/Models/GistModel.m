//
//  GistModel.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistModel.h"
#import "NSString+Ext.h"
#import "UserModel.h"

@implementation GistModel

-(id) initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(dict[@"owner"] == nil) {
        return nil;
    }
    _identity = dict[@"id"];
    _url = [NSURL URLWithString:dict[@"url"]];
    _commitsUrl = [NSURL URLWithString:dict[@"commits_url"]];
    _descript = dict[@"description"];
    _timestamp = [dict[@"created_at"] timestampFromDateString];
    
    _files = [dict[@"files"] allKeys];
    _user = [[UserModel alloc] initWithDict:dict[@"owner"]];
    
    return self;
}

@end
