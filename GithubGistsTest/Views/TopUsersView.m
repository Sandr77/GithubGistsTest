//
//  TopUsersView.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "TopUsersView.h"
#import "User.h"
#import "ImageDownloader.h"

@interface TopUsersView() {
    NSArray *_users;
}

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation TopUsersView


-(void) setUsers:(NSArray *)users {
    _users = users;
    for(UIView *view in _stackView.subviews) {
        [view removeFromSuperview];
    }
    for(int i=0; i<users.count; i++) {
        User *user = users[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 25;
        imageView.clipsToBounds = true;
        [view addSubview:imageView];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [[ImageDownloader shared] getImageFromURLString:user.avatarUrlString withCompletion:^(UIImage *image, NSString *urlString){
            imageView.image = image;
        }];
        [_stackView addArrangedSubview:view];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60];
        [view addConstraint:constraint];
        view.tag = [users indexOfObject:user];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
        [view addGestureRecognizer:gesture];
    }
}

-(NSArray *) users {
    return _users;
}

-(void) userTapped:(UITapGestureRecognizer *) gesture {
    [self.delegate topUsersViewClickedUser:_users[gesture.view.tag]];
}


@end
