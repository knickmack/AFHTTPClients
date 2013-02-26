//
//  PlacesViewController.m
//  Google Places Autocomplete
//
//  Created by Nik Macintosh on 2013-02-26.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "PlacesViewController.h"
#import "GPSAutocompleteAPIClient.h"

@interface PlacesViewController () <UITableViewDataSource>

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
    }
    
    return _theSearchDisplayController;
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
    
    return cell;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
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
