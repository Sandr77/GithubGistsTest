//
//  Commit.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commit : NSObject

-(id) initWithDict:(NSDictionary *) dict;

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *username;
@property int additions;
@property int deletions;

@end
