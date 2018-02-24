//
//  ImageDownloader.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface ImageDownloader: NSObject

+(instancetype) shared;
-(void) getImageFromURLString:(NSString *) urlString withCompletion:(void(^)(UIImage *, NSString *)) completion;

@end
