//
//  Gist.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GistModel, User;
@interface Gist : NSObject

@property (readonly, strong, nonatomic) NSString *identity;
@property NSTimeInterval timestamp;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSURL *commitsUrl;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) User *user;

-(id) initWithModel:(GistModel *) model;
-(void) updateWithModel:(GistModel *) model;

@end
