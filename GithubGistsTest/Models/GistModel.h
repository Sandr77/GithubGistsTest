//
//  GistModel.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;
@interface GistModel : NSObject

@property (strong, nonatomic) NSString *identity;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSURL *commitsUrl;
@property double timestamp;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSArray *files;

@property (strong, nonatomic) UserModel *user;

-(id) initWithDict:(NSDictionary *) dict;

@end
