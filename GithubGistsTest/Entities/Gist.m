//
//  Gist.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "Gist.h"
#import "GistModel.h"
#import "UserModel.h"
#import "User.h"

@implementation Gist

-(id) initWithModel:(GistModel *)model {
    self = [super init];
    [self fillValuesFrom:model];
    _user = [[User alloc] initWithModel:model.user];
    return self;
}

-(void) updateWithModel:(GistModel *)model {
    [self fillValuesFrom:model];
    [_user updateWithModel:model.user];
}

-(void) fillValuesFrom:(GistModel *) model {
    _identity = model.identity;
    _url = model.url;
    _commitsUrl = model.commitsUrl;
    _timestamp = model.timestamp;
    _descript = model.descript;
    _files = model.files;
}

@end
