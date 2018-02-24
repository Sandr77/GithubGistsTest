//
//  GistListTableViewCell.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistListTableViewCell.h"
#import "Gist.h"
#import "User.h"
#import "ImageDownloader.h"

@interface GistListTableViewCell() {
    Gist *_gist;
}

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation GistListTableViewCell

-(void) awakeFromNib {
    [super awakeFromNib];
}

-(void) setGist:(Gist *)gist {
    _gist = gist;
    _descriptionLabel.text = _gist.descript;
    
    _usernameLabel.text = _gist.user.name;
    _avatarImageView.image = nil;
    [[ImageDownloader shared] getImageFromURLString:_gist.user.avatarUrlString withCompletion:^(UIImage *image, NSString *urlString){
        if([urlString isEqualToString:self.gist.user.avatarUrlString]) {
            _avatarImageView.image = image;
        }
    }];
    
}

-(Gist *) gist {
    return _gist;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
