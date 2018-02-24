//
//  APIManager.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "APIManager.h"
#import "GistModel.h"
#import "Gist.h"
#import "GistFileContent.h"
#import "Commit.h"
#import "User.h"

@implementation APIManager

+ (instancetype)shared
{
    static APIManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[APIManager alloc] init];
    });
    return shared;
}

-(void) getGistsFromPage:(int) page completion:(void (^)(NSArray <GistModel *>*))completion {
    NSURLRequest *request = [self createRequestWithHTTPMethod:HTTP_GET api:@"gists/public" params:@{@"page":[@(page) stringValue], @"per_page":@"100"}];
    [self sendRequest:request completion:^(NSArray *array){
        NSMutableArray *models = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in array) {
            
            GistModel *gistModel = [[GistModel alloc] initWithDict:dict];
            if(gistModel) {
                [models addObject:gistModel];
            }
        }
        completion(models);
    }];
}

-(void) getGistContent:(Gist *) gist completion:(void(^)(NSArray <GistFileContent *>*)) completion {
    NSURLRequest *request = [self createGetRequestWithUrl:gist.url];
    [self sendRequest:request completion:^(NSDictionary *dict){
        NSMutableArray *content = [[NSMutableArray alloc] init];
        for(NSString *fileKey in [dict[@"files"] allKeys]) {
            GistFileContent *model = [[GistFileContent alloc] initWithFileName:fileKey content:dict[@"files"][fileKey][@"content"]];
            [content addObject:model];
        }
        completion(content);
    }];
}

-(void) getCommitsForGist:(Gist *)gist completion:(void (^)(NSArray<Commit *> *))completion {
    NSURLRequest *request = [self createGetRequestWithUrl:gist.commitsUrl];
    [self sendRequest:request completion:^(NSArray *array){
        NSMutableArray *commits = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in array) {
            Commit *commit = [[Commit alloc] initWithDict:dict];
            [commits addObject:commit];
        }
        completion(commits);
    }];
}

-(void) getGistsOfUser:(User *)user completion:(void (^)(NSArray<GistModel *> *))completion {
    NSURLRequest *request = [self createRequestWithHTTPMethod:HTTP_GET api:[NSString stringWithFormat:@"users/%@/gists", user.name] params:nil];
    [self sendRequest:request completion:^(NSArray *array){
        NSMutableArray *models = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in array) {
            GistModel *gistModel = [[GistModel alloc] initWithDict:dict];
            if(gistModel) {
                [models addObject:gistModel];
            }
        }
        completion(models);
    }];
}


@end
