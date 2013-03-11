//
//  AppDelegate.m
//  Yahoo Query Language
//
//  Created by Nik Macintosh on 2013-03-11.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AppDelegate.h"
#import "TablesViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, readonly) UINavigationController *navigationController;
@property (strong, nonatomic, readonly) TablesViewController *tablesViewController;

@end

@implementation AppDelegate

@synthesize navigationController = _navigationController;
@synthesize tablesViewController = _tablesViewController;

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.tablesViewController];
    }
    
    return _navigationController;
}

- (TablesViewController *)tablesViewController {
    if (!_tablesViewController) {
        _tablesViewController = [TablesViewController new];
    }
    
    return _tablesViewController;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
