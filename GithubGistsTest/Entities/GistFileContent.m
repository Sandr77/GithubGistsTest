//
//  GistFileContent.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistFileContent.h"

@implementation GistFileContent

-(id) initWithFileName:(NSString *)filename content:(NSString *)content {
    self = [super init];
    _filename = filename;
    _content = content;
    return self;
}

@end
