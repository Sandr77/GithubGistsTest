//
//  TopUsersView.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@protocol TopUsersViewDelegate

-(void) topUsersViewClickedUser:(User *) user;

@end


@interface TopUsersView : UIView

@property (weak, nonatomic) id <TopUsersViewDelegate> delegate;

@property (strong, nonatomic) NSArray *users;

@end
