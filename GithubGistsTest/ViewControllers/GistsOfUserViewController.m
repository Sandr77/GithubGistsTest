//
//  GistsOfUserViewController.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistsOfUserViewController.h"
#import "User.h"
#import "DataManager.h"

@interface GistsOfUserViewController ()

@end

@implementation GistsOfUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.user.name;
    
    [[DataManager shared] loadGistsOfUser:self.user completion:^(NSArray *array){
        self.gists = array;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
