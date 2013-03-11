//
//  YQLAPIClient.h
//  
//
//  Created by Nik Macintosh on 2013-03-11.
//
//

#import "AFHTTPClient.h"

@interface YQLAPIClient : AFHTTPClient

+ (YQLAPIClient *)sharedClient;

@end
