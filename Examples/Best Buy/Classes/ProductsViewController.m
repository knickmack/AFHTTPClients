//
//  ProductsViewController.m
//  Best Buy
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "ProductsViewController.h"
#import "BBYAPIClient.h"

@interface ProductsViewController ()

@property (copy, nonatomic, readonly) NSDictionary *category;
@property (strong, nonatomic, readonly) NSArray *products;

@end

@implementation ProductsViewController

@synthesize category = _category;
@synthesize products = _products;

#pragma mark - ProductsViewController

- (NSArray *)products {
    if (!_products) {
        _products = @[];
    }
    
    return _products;
}

- (id)initWithCategory:(NSDictionary *)category {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _category = category;
    
    return self;
}

- (void)refreshProducts {
    NSString *path = [NSString stringWithFormat:@"products(categoryPath.name=%@*)", [self.category valueForKeyPath:@"name"]];
    __weak __typeof(&*self)weakSelf = self;
    
    [[BBYAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
        
        _products = [(NSArray *)response[@"products"] sortedArrayUsingDescriptors:@[ descriptor ]];
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.detailTextLabel.text = [product valueForKeyPath:@"longDescription"];
    cell.textLabel.text = [product valueForKeyPath:@"name"];
    
    return cell;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.title = self.category[@"name"];
    
    [self refreshProducts];
}

- (void)didReceiveMemoryWarning {
    _category = nil;
    _products = nil;
    
    [super didReceiveMemoryWarning];
}

@end
