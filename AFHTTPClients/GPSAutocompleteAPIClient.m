//
//  GPSAutocompleteAPIClient.m
//  Best Buy
//
//  Created by Nik Macintosh on 2013-02-25.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "GPSAutocompleteAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kGPSAutocompleteAPIBaseURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString * const kGPSAutocompleteAPIKey = @"YOUR_API_KEY";

@implementation GPSAutocompleteAPIClient

#pragma mark - GPSAutocompleteAPIClient

+ (GPSAutocompleteAPIClient *)sharedClient {
    static GPSAutocompleteAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GPSAutocompleteAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kGPSAutocompleteAPIBaseURLString]];
    });
    
    return _sharedClient;
}

#pragma mark - AFHTTPClient

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableDictionary *mutableParameters = [parameters mutableCopy];
    
    mutableParameters[@"key"] = kGPSAutocompleteAPIKey;
    
    return [super requestWithMethod:method path:path parameters:[mutableParameters copy]];
}

@end
