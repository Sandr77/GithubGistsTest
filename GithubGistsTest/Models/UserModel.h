//
//  UserModel.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

-(id) initWithDict:(NSDictionary *) dict;

@property (strong, nonatomic) NSString *identity;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarUrlString;

@end
