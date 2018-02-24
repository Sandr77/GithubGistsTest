//
//  DataManager.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "DataManager.h"
#import "Gist.h"
#import "GistModel.h"
#import "APIManager.h"
#import "User.h"
#import "TopUsersView.h"

@interface DataManager() {
    int lastLoadedPage;
    NSMutableDictionary *gists;
}
@end

@implementation DataManager

-(id) init {
    self = [super init];
    gists = [[NSMutableDictionary alloc] init];
    lastLoadedPage = -1;
    
    return self;
}

+ (instancetype)shared
{
    static DataManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[DataManager alloc] init];
    });
    return shared;
}

-(void) loadGistContent:(Gist *)gist completion:(void (^)(NSArray *))completion {
    [[APIManager shared] getGistContent:gist completion:^(NSArray *content){
        completion(content);
    }];
}

-(void) loadCommitsForGist:(Gist *)gist completion:(void (^)(NSArray<Commit *> *))completion {
    [[APIManager shared] getCommitsForGist:gist completion:^(NSArray *commits){
        completion(commits);
    }];
}

-(void) loadGistsOfUser:(User *)user completion:(void (^)(NSArray<Gist *> *))completion {
    [[APIManager shared] getGistsOfUser:user completion:^(NSArray *gistsOfUser){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(GistModel *model in gistsOfUser) {
            Gist *gist = [[Gist alloc] initWithModel:model];
            [array addObject:gist];
        }
        completion([self sortedGists:array]);
    }];
}

-(void) loadNextGistsWithCompletion:(void(^)(NSArray <Gist *>*)) completion {
    [self loadGistsFromPage:lastLoadedPage + 1 untilNew:true completion:completion];
}

-(void) refreshGistsWithCompletion:(void(^)(NSArray <Gist *>*)) completion {
    [self loadGistsFromPage:0 untilNew:false completion:completion];
}

-(void) loadGistsFromPage:(int) page untilNew:(BOOL) flagNeedNew completion:(void(^)(NSArray <GistModel *>*)) completion {
    [[APIManager shared] getGistsFromPage:page completion:^(NSArray *newGists) {
        if(newGists.count == 0) {
            completion(nil);
            return;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            BOOL wasNew = false;
            BOOL wasOld = false;
            for(GistModel *model in newGists) {
                if(gists[model.identity] != nil) {
                    [gists[model.identity] updateWithModel:model];
                    wasOld = true;
                }
                else {
                    gists[model.identity] = [[Gist alloc] initWithModel:model];
                    wasNew = true;
                }
            }
            NSArray *sortedGists = [self sortedGists: gists.allValues];
            
            NSArray *top10Users = [self findTopUsers];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(sortedGists);
                self.topUsersView.users = top10Users;
            });
            
            [self findTopUsers];
            if(lastLoadedPage < page) {
                lastLoadedPage = page;
            }
            if((wasNew == false && flagNeedNew) || (wasOld == false && flagNeedNew == false) || [gists allValues].count < 5) {
                [self loadGistsFromPage:page + 1 untilNew:flagNeedNew completion:completion];
            }
            
        });
    }];
}

-(NSArray *) findTopUsers {
    NSMutableDictionary *topUsers = [NSMutableDictionary new];
    
    for(Gist *gist in gists.allValues) {
        if(topUsers[gist.user.name]) {
            NSMutableDictionary *dict = topUsers[gist.user.name];
            dict[@"count"] = @([dict[@"count"] intValue] + 1);
        }
        else {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[@"user"] = gist.user;
            dict[@"count"] = @(1);
            topUsers[gist.user.name] = dict;
        }
    }
    
    NSArray *sorted = [topUsers.allValues sortedArrayUsingComparator:^(NSDictionary *d1, NSDictionary *d2) {
        if([d1[@"count"] intValue] > [d2[@"count"] intValue]) {
            return NSOrderedAscending;
        }
        else if([d1[@"count"] intValue] < [d2[@"count"] intValue]) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
    }];
    
    NSMutableArray *top10Users = [NSMutableArray new];
    for(int i=0; i < sorted.count && i < 10; i++) {
        NSDictionary *d = sorted[i];
        NSLog(@"%@ %d", [d[@"user"] name], [d[@"count"] intValue]);
        [top10Users addObject:d[@"user"]];
    }
    
    return top10Users;
    
}

-(NSArray *) sortedGists:(NSArray *) array {
    return [array sortedArrayUsingComparator:^(Gist *g1, Gist *g2) {
        if(g1.timestamp > g2.timestamp) {
            return NSOrderedAscending;
        }
        else if(g1.timestamp < g2.timestamp) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
    }];
}





@end
