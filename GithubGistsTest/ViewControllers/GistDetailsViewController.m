//
//  GistDetailsViewController.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistDetailsViewController.h"
#import "ImageDownloader.h"
#import "DataManager.h"
#import "Gist.h"
#import "User.h"
#import "GistFileContent.h"
#import "FileContentView.h"
#import "CommitView.h"

@interface GistDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *filenameLabel;
@property (weak, nonatomic) IBOutlet UIStackView *contentStackView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIStackView *commitsStackView;


@end

@implementation GistDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ImageDownloader shared] getImageFromURLString:_gist.user.avatarUrlString withCompletion:^(UIImage *image, NSString *urlString){
        _avatarImageView.image = image;
    }];
    self.title = @"Details";
    
    _usernameLabel.text = _gist.user.name;
    _descriptionLabel.text = _gist.descript;
    [[DataManager shared] loadGistContent:_gist completion:^(NSArray *contents){
        
        for(GistFileContent *content in contents) {
            FileContentView *view = [[NSBundle mainBundle] loadNibNamed:@"FileContentView" owner:self options:nil][0];
            view.content = content;
            [_contentStackView addArrangedSubview:view];
        }
            
        [self.view layoutIfNeeded];
    }];
    
    [[DataManager shared] loadCommitsForGist:_gist completion:^(NSArray *commits){
        for(Commit *commit in commits) {
            CommitView *view = [[NSBundle mainBundle] loadNibNamed:@"CommitView" owner:self options:nil][0];
            view.commit = commit;
            [_commitsStackView addArrangedSubview:view];
        }
        [self.view layoutIfNeeded];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
