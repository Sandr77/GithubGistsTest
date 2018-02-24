//
//  GistListTableViewCell.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Gist;
@interface GistListTableViewCell : UITableViewCell

@property (strong, nonatomic) Gist *gist;

@end
