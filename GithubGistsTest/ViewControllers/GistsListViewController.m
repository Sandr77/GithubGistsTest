//
//  GistsListViewController.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 23/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistsListViewController.h"
#import "DataManager.h"
#import "TopUsersView.h"
#import "GistsOfUserViewController.h"

@interface GistsListViewController() <TopUsersViewDelegate> {
    BOOL loadingNow;
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet TopUsersView *topUsersView;

@end

@implementation GistsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topUsersView.delegate = self;
    [DataManager shared].topUsersView = _topUsersView;
    loadingNow = true;
    
    [[DataManager shared] loadNextGistsWithCompletion:^(NSArray *array){
        [self gistsRecieved:array];
        loadingNow = false;
        
        NSMutableArray *users = [NSMutableArray new];
        for(int i=0; i<array.count && i<10; i++) {
            [users addObject:[array[i] user]];
        }
    }];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    
    
}

-(void) gistsRecieved:(NSArray *)newGists {
    if(newGists.count > 0) {
        self.gists = newGists;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) refresh {
    [[DataManager shared] refreshGistsWithCompletion:^(NSArray *array){
        [refreshControl endRefreshing];
        [self gistsRecieved:array];
        loadingNow = false;
    }];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if(loadingNow) {
        return;
    }
    NSArray *visibleRows = [self.tableView indexPathsForVisibleRows];
    if([visibleRows.lastObject row] > self.gists.count - 5) {
        loadingNow = true;
        [[DataManager shared] loadNextGistsWithCompletion:^(NSArray *array){
            [self gistsRecieved:array];
            loadingNow = false;
        }];
    }
}


-(void) topUsersViewClickedUser:(User *)user {
    GistsOfUserViewController *vc = [GistsOfUserViewController new];
    vc.user = user;
    [self.navigationController pushViewController:vc animated:true];
}

@end
