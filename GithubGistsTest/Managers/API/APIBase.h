//
//  APIBase.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {HTTP_POST, HTTP_GET} HTTP_METHOD;

@interface APIBase : NSObject

-(NSMutableURLRequest *) createGetRequestWithUrl:(NSURL *)url;
-(NSMutableURLRequest *) createRequestWithHTTPMethod:(HTTP_METHOD) httpMethod api:(NSString *) api params:(NSDictionary *)params;
-(void) sendRequest:(NSURLRequest *) request completion:(void (^)(id))completion;

@end
