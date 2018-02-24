//
//  APIBase.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "APIBase.h"
@import UIKit;

#define BASE_URL @"https://api.github.com/"

@implementation APIBase

-(NSMutableURLRequest *) createRequestWithHTTPMethod:(HTTP_METHOD) httpMethod api:(NSString *) api params:(NSDictionary *)params {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, api];
    
    NSMutableString *paramString = [@"" mutableCopy];
    for(NSString *key in params.allKeys) {
        [paramString appendFormat:@"%@=%@&", key, [params[key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    
    if(httpMethod == HTTP_GET) {
        urlString = [urlString stringByAppendingFormat:@"?%@", paramString];
    }
  
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = httpMethod == HTTP_GET ? @"GET" : @"POST";

    if(httpMethod == HTTP_POST) {
        [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    }
 
    return request;
}

-(NSMutableURLRequest *) createGetRequestWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
 
    return request;
}

-(void) sendRequest:(NSURLRequest *) request completion:(void (^)(id))completion
{
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
        
        if(httpResponse.statusCode != 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if([result isKindOfClass:[NSDictionary class]] && result[@"message"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:result[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
                completion(nil);
            });
            return;
        }
        
        
        if(data && !error) {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if(result) {
                id checkedResult = nil;
                if([result isKindOfClass:[NSArray class]]) {
                    checkedResult = [self checkArrayResult:result];
                }
                else {
                    NSMutableDictionary *checkedDict = [result mutableCopy];
                    [self checkResult:checkedDict];
                    checkedResult = checkedDict;
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(checkedResult);
                });
                return;
            }
           
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(nil);
        });
    }];
    
    [dataTask resume];
}

-(NSArray *) checkArrayResult:(NSArray *) resArray
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    dict[@"array"]=resArray;
    [self checkResult:dict];
    return dict[@"array"];
}

-(void) checkResult:(NSMutableDictionary *) resultDict
{
    NSArray *keys=[resultDict allKeys];
    for(NSString *k in keys)
    {
        id object=resultDict[k];
        if([object isKindOfClass:[NSNull class]])
        {
            [resultDict removeObjectForKey:k];
        }
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *newDict=[object mutableCopy];
            [self checkResult:newDict];
            resultDict[k]=newDict;
        }
        if([object isKindOfClass:[NSArray class]])
        {
            NSMutableArray *newArr=[object mutableCopy];
            for(int i=0;i<[newArr count];i++)
            {
                id arrElement=newArr[i];
                if([arrElement isKindOfClass:[NSNull class]])
                {
                    [newArr removeObjectAtIndex:i];
                    i--;
                }
                else if([arrElement isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *newDict=[arrElement mutableCopy];
                    [self checkResult:newDict];
                    [newArr replaceObjectAtIndex:i withObject:newDict];
                    
                }
                
            }
            resultDict[k]=newArr;
        }
    }
}

@end
