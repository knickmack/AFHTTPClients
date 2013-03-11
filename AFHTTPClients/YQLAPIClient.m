//
//  YQLAPIClient.m
//  
//
//  Created by Nik Macintosh on 2013-03-11.
//
//

#import "YQLAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kYQLAPIBaseURLString = @"http://query.yahooapis.com/v1/public/yql";

@implementation YQLAPIClient

#pragma mark - YQLAPIClient

+ (YQLAPIClient *)sharedClient {
    static YQLAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YQLAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kYQLAPIBaseURLString]];
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

@end
