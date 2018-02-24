//
//  CommitView.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "CommitView.h"
#import "Commit.h"

@interface CommitView() {
    Commit *_commit;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *deletionsLabel;


@end

@implementation CommitView

-(void) setCommit:(Commit *)commit {
    _commit = commit;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    _dateLabel.text = [dateFormatter stringFromDate:commit.date];

    
    _additionsLabel.text = [NSString stringWithFormat:@"%d", commit.additions];
    _deletionsLabel.text = [NSString stringWithFormat:@"%d", commit.deletions];
}

-(Commit *) commit {
    return _commit;
}

@end
