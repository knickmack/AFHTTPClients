//
//  TablesViewController.m
//  Yahoo Query Language
//
//  Created by Nik Macintosh on 2013-03-11.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "TablesViewController.h"
#import "YQLAPIClient.h"

@interface TablesViewController ()

@property (strong, nonatomic, readonly) NSArray *tables;

@end

@implementation TablesViewController

@synthesize tables = _tables;

#pragma mark - TablesViewController

- (NSArray *)tables {
    if (!_tables) {
        _tables = @[];
    }
    
    return _tables;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tables.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    id table = [self.tables objectAtIndex:indexPath.row];
    
    if ([table isKindOfClass:[NSString class]]) {
        cell.textLabel.text = table;
    } else {
        cell.textLabel.text = [table valueForKeyPath:@"content"];
    }
    
    return cell;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.title = NSLocalizedString(@"Tables", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [[YQLAPIClient sharedClient] getPath:@"" parameters:@{ @"q": @"show tables"} success:^(AFHTTPRequestOperation *operation, NSDictionary *JSON) {
        _tables = [JSON valueForKeyPath:@"query.results.table"];
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    _tables = nil;

    [super didReceiveMemoryWarning];
}

@end
