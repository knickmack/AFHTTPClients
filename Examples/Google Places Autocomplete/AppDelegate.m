//
//  AppDelegate.m
//  Google Places Autocomplete
//
//  Created by Nik Macintosh on 2013-02-26.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _window;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
