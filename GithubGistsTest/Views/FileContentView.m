//
//  FileContentView.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "FileContentView.h"
#import "GistFileContent.h"

@interface FileContentView() {
    GistFileContent *_content;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *filenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FileContentView

-(void) awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
    _containerView.layer.borderWidth = 0.5;
    _containerView.layer.cornerRadius = 5;
}

-(void) setContent:(GistFileContent *)content {
    _content = content;
    _filenameLabel.text = content.filename;
    _contentLabel.text = content.content;
}

-(GistFileContent *) content {
    return _content;
}


@end
