//
//  GistListsTemplate.m
//  GithubGistsTest
//
//  Created by Andrey Snetkov on 24/02/2018.
//  Copyright © 2018 Andrey Snetkov. All rights reserved.
//

#import "GistListsTemplate.h"
#import "Gist.h"
#import "GistListTableViewCell.h"
#import "GistDetailsViewController.h"


@interface GistListsTemplate () {
    NSMutableDictionary *rowsHeights;;
}

@end

@implementation GistListsTemplate

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rowsHeights = [NSMutableDictionary new];
    [self.tableView registerNib:[UINib nibWithNibName:@"GistListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GistListTableViewCellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gists count];
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(rowsHeights[@(indexPath.row)]) {
        return [rowsHeights[@(indexPath.row)] floatValue];
    }
    return UITableViewAutomaticDimension;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    rowsHeights[@(indexPath.row)] = @(cell.bounds.size.height);
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GistListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GistListTableViewCellId"];
    cell.gist = self.gists[indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GistDetailsViewController *vc = [[GistDetailsViewController alloc] init];
    vc.gist = self.gists[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}


@end
