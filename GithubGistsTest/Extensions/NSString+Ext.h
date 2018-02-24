//
//  NSString+Ext.h
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Timestamp)

-(double) timestampFromDateString;
-(NSDate *) date;

@end
