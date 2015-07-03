//
//  VBApiManager.m
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import "VBAPIManager.h"
#import <AFHTTPRequestOperation.h>

static const NSString * kAPIbaseURL = @"http://private-30403b-storm4.apiary-mock.com";

@implementation VBAPIManager

-(instancetype)init{
    if (self = [super init]){
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: [NSURL URLWithString: kAPIBasePath]];
        
        NSOperationQueue *operationQueue = self.manager.operationQueue;
        [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        
        [self.manager.reachabilityManager startMonitoring];
    }
    return self;
}

- (void)getImageWithURL: (NSURL *)url
                success: (void (^)(AFHTTPRequestOperation *, UIImage *))success
                failure: (void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSURLRequest * urlrequest = [NSURLRequest requestWithURL: url
                                                 cachePolicy: NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval: 10];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest: urlrequest];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    [operation start];
}

-(NSString *)URLForPath:(NSString *)path{
    return [NSString stringWithFormat: @"%@%@", kAPIbaseURL, path];
}

@end
