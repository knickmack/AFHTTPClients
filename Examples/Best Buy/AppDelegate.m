//
//  AppDelegate.m
//  Best Buy
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "CategoriesViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, readonly) CategoriesViewController *categoriesViewController;
@property (strong, nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation AppDelegate

@synthesize categoriesViewController = _categoriesViewController;
@synthesize navigationController = _navigationController;

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

- (CategoriesViewController *)categoriesViewController {
    if (!_categoriesViewController) {
        _categoriesViewController = [CategoriesViewController new];
    }
    
    return _categoriesViewController;
}

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.categoriesViewController];
    }
    
    return _navigationController;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
