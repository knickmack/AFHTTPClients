//
//  CategoriesViewController.m
//  Best Buy
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "CategoriesViewController.h"
#import "BBYAPIClient.h"
#import "ProductsViewController.h"

@interface CategoriesViewController ()

@property (strong, nonatomic, readonly) NSArray *categories;

@end

@implementation CategoriesViewController

@synthesize categories = _categories;

#pragma mark - CategoriesViewController

- (NSArray *)categories {
    if (!_categories) {
        _categories = @[];
    }
    
    return _categories;
}

- (void)refreshCategories {
    __weak __typeof(&*self)weakSelf = self;
    
    [[BBYAPIClient sharedClient] getPath:@"categories" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
        
        _categories = [(NSArray *)[response valueForKeyPath:@"categories"] sortedArrayUsingDescriptors:@[ descriptor ]];
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *category = [self.categories objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = category[@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *category = [self.categories objectAtIndex:indexPath.row];
    ProductsViewController *productsViewController = [[ProductsViewController alloc] initWithCategory:category];
    
    [self.navigationController pushViewController:productsViewController animated:YES];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.title = NSLocalizedString(@"Categories", nil);
    
    [self refreshCategories];
}

- (void)didReceiveMemoryWarning {
    _categories = nil;
    
    [super didReceiveMemoryWarning];
}

@end
