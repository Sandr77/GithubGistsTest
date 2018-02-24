//
//  GistFileContent.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GistFileContent : NSObject

-(id) initWithFileName:(NSString *) filename content:(NSString *) content;

@property (strong, nonatomic) NSString *filename;
@property (strong, nonatomic) NSString *content;

@end
