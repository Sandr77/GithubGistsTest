//
//  NSString+Ext.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString(Timestamp)

-(double) timestampFromDateString {
    return [[self date] timeIntervalSinceReferenceDate];
}

-(NSDate *) date {
    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"Z" withString:@""];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";//2018-02-23T05:47:43Z
    NSDate *date = [formatter dateFromString:str];
    return date;
}

@end
