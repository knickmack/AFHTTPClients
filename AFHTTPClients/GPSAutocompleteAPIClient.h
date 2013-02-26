//
//  GPSAutocompleteAPIClient.h
//  Best Buy
//
//  Created by Nik Macintosh on 2013-02-25.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GPSAutocompleteAPIClient : AFHTTPClient

+ (GPSAutocompleteAPIClient *)sharedClient;

@end
