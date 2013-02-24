//
//  BBYAPIClient.m
//  
//
//  Created by Nik Macintosh on 2013-02-23.
//
//

#import "BBYAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kBBYAPIBaseURLString = @"http://api.remix.bestbuy.com/v1/";
static NSString * const kBBYAPIKey = @"YOUR_API_KEY";

@implementation BBYAPIClient

#pragma mark - BBYAPIClient

+ (BBYAPIClient *)sharedClient {
    static BBYAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BBYAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBBYAPIBaseURLString]];
    });
    
    return _sharedClient;
}

#pragma mark - AFHTTPClient

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    // Account for the incorrect MIME type used for JSON by BBYOpen
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/x-javascript"]];
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableDictionary *mutableParameters = [@{} mutableCopy];
    
    [mutableParameters addEntriesFromDictionary:parameters];
    mutableParameters[@"apiKey"] = kBBYAPIKey;
    mutableParameters[@"format"] = @"json";
    
    return [super requestWithMethod:method path:path parameters:[mutableParameters copy]];
}

@end
