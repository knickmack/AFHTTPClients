//
//  AppDelegate.m
//  Google Places Autocomplete
//
//  Created by Nik Macintosh on 2013-02-26.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "AppDelegate.h"
#import "PlacesViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, readonly) UINavigationController *navigationController;
@property (strong, nonatomic, readonly) PlacesViewController *placesViewController;

@end

@implementation AppDelegate

@synthesize navigationController = _navigationController;
@synthesize placesViewController = _placesViewController;

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.backgroundColor = [UIColor whiteColor];
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.placesViewController];
    }
    
    return _navigationController;
}

- (PlacesViewController *)placesViewController {
    if (!_placesViewController) {
        _placesViewController = [PlacesViewController new];
    }
    
    return _placesViewController;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
