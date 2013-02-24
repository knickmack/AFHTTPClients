//
//  BBYAPIClient.h
//  
//
//  Created by Nik Macintosh on 2013-02-23.
//
//

#import "AFHTTPClient.h"

@interface BBYAPIClient : AFHTTPClient

+ (BBYAPIClient *)sharedClient;

@end
