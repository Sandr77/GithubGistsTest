//
//  User.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "User.h"
#import "UserModel.h"

@implementation User

-(id) initWithModel:(UserModel *)model {
    self = [super init];
    [self fillValuesFrom:model];
    return self;
}

-(void) updateWithModel:(UserModel *)model {
    [self fillValuesFrom:model];
}

-(void) fillValuesFrom:(UserModel *) model {
    _identity = model.identity;
    _avatarUrlString = model.avatarUrlString;
    _name = model.name;

}

@end
