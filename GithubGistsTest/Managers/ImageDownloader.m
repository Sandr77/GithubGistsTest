//
//  ImageDownloader.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "ImageDownloader.h"

#import "ImageDownloader.h"

@import UIKit;

@interface ImageDownloader()
{
    NSMutableDictionary *images;
    NSMutableDictionary *completions;
}

@end

@implementation ImageDownloader

-(id) init
{
    self=[super init];
    
    images=[[NSMutableDictionary alloc] init];
    completions=[[NSMutableDictionary alloc] init];
    
    return self;
}

+ (instancetype)shared
{
    static ImageDownloader *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ImageDownloader alloc] init];
    });
    return shared;
}

-(void) logout
{
    images=[[NSMutableDictionary alloc] init];
    completions=[[NSMutableDictionary alloc] init];
    
}

-(void) getImageFromURLString:(NSString *) urlString withCompletion:(void(^)(UIImage *, NSString *)) completion
{
    if(!urlString)
        return;
    NSURL *url=[NSURL URLWithString:urlString];
    if(!url)
        return;
    
    if(images[urlString])
    {
        completion(images[urlString], urlString);
        return;
    }
    if(completions[urlString])
    {
        
        [completions[urlString] addObject:completion];
        return;
    }
    else
    {
        completions[urlString]=[[NSMutableArray alloc] init];
        [completions[urlString] addObject:completion];
        
    }
    
    NSString *string=[urlString copy];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod: @"GET"];

    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){

        if(!data)
            return;
        UIImage *image=[UIImage imageWithData:data];
        if(image)
        {
            @synchronized (@"Save image") {
                images[string]=image;
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for(void(^completionn)(UIImage *, NSString *) in completions[urlString])
            {
                completionn(image, string);
            }
            [completions removeObjectForKey:string];
        });
        
    }];
    [dataTask resume];
}

@end
