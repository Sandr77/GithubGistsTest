//
//  DataManager.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gist, Commit, User, TopUsersView;
@interface DataManager : NSObject

+(instancetype) shared;

-(void) loadNextGistsWithCompletion:(void(^)(NSArray <Gist *>*)) completion;
-(void) refreshGistsWithCompletion:(void(^)(NSArray <Gist *>*)) completion;

-(void) loadGistContent:(Gist *) gist completion:(void(^)(NSArray *content)) completion;
-(void) loadCommitsForGist:(Gist *)gist completion:(void (^)(NSArray<Commit *> *))completion;

-(void) loadGistsOfUser:(User *)user completion:(void (^)(NSArray<Gist *> *))completion;

@property (weak, nonatomic) TopUsersView *topUsersView;

@end
