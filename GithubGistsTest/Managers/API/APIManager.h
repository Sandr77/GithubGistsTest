//
//  APIManager.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIBase.h"

@class Gist, GistModel, User, Commit, GistFileContent;

@interface APIManager : APIBase

+(instancetype) shared;

-(void) getGistsFromPage:(int) page completion:(void (^)(NSArray <GistModel *>*))completion;
-(void) getCommitsForGist:(Gist *) gist completion:(void (^)(NSArray <Commit *>*))completion;
-(void) getGistContent:(Gist *) gist completion:(void(^)(NSArray <GistFileContent *>*)) completion;

-(void) getGistsOfUser:(User *) user completion:(void(^)(NSArray <GistModel *>*)) completion;

@end
