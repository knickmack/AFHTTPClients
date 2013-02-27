//
//  PlacesViewController.m
//  Google Places Autocomplete
//
//  Created by Nik Macintosh on 2013-02-26.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "PlacesViewController.h"
#import "GPSAutocompleteAPIClient.h"

@interface PlacesViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource>

@property (assign, nonatomic, getter = isDirty) BOOL dirty;
@property (assign, nonatomic, getter = isLoading) BOOL loading;
@property (strong, nonatomic, readonly) UISearchBar *searchBar;
@property (strong, nonatomic, readonly) NSArray *searchResults;
@property (strong, nonatomic, readonly) UISearchDisplayController *theSearchDisplayController;

@end

@implementation PlacesViewController

@synthesize searchBar = _searchBar;
@synthesize searchResults = _searchResults;
@synthesize theSearchDisplayController = _theSearchDisplayController;

#pragma mark - PlacesViewController

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        
        _searchBar.delegate = self;
        
        [_searchBar sizeToFit];
    }
    
    return _searchBar;
}

- (NSArray *)searchResults {
    if (!_searchResults) {
        _searchResults = @[];
    }
    
    return _searchResults;
}

- (UISearchDisplayController *)theSearchDisplayController {
    if (!_theSearchDisplayController) {
        _theSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        
        _theSearchDisplayController.searchResultsDataSource = self;
        _theSearchDisplayController.delegate = self;
    }
    
    return _theSearchDisplayController;
}

- (void)refreshPlaces {
    NSDictionary *parameters = @{ @"input": self.searchBar.text, @"sensor": @"true" };
    __weak __typeof(&*self)weakSelf = self;
    
    [[GPSAutocompleteAPIClient sharedClient] getPath:@"json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        _searchResults = response[@"predictions"];
        [weakSelf.searchDisplayController.searchResultsTableView reloadData];
        
        if (self.isDirty) {
            self.dirty = NO;
            [self refreshPlaces];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length < 2) {
        return;
    }
    
    if (self.isLoading) {
        self.dirty = YES;
        return;
    }
    
    [self refreshPlaces];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *prediction = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = prediction[@"description"];
    
    return cell;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.dirty = NO;
    self.loading = NO;
    self.title = NSLocalizedString(@"Places", nil);
    [self.view addSubview:self.theSearchDisplayController.searchBar];
}

- (void)didReceiveMemoryWarning {
    _searchBar = nil;
    _searchResults = nil;
    _theSearchDisplayController = nil;
    
    [super didReceiveMemoryWarning];
}

@end
