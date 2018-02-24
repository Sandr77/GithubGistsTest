//
//  User.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;
@interface User : NSObject

@property (strong, nonatomic) NSString *identity;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarUrlString;

-(id) initWithModel:(UserModel *) model;
-(void) updateWithModel:(UserModel *) model;

@end
