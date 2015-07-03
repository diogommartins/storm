//
//  VBApiManager.h
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperationManager.h>


static NSString *kAPIBasePath = @"http://private-30403b-storm4.apiary-mock.com";

@interface VBAPIManager : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager;

-(void)getImageWithURL: (NSURL *)url
               success: (void (^)(AFHTTPRequestOperation *operation, UIImage * image))success
               failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(NSString *)URLForPath: (NSString *)path;

@end
