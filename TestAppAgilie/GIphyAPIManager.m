//
//  GIphyAPIManager.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GIphyAPIManager.h"
#import "Defines.h"

@implementation GIphyAPIManager

+ (AFHTTPSessionManager *)manager
{
    static AFHTTPSessionManager *_manager;
    if (!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GIPHY_BASE_URL]];
    }
    return _manager;
}

+(void) searchGifWithParams: (NSDictionary*) params complete:(void (^)(id responseObject, NSError *error))complete{
    NSMutableDictionary* currentParams = [params mutableCopy];
    
    [currentParams setObject:GIPHY_API_KEY forKey:@"api_key"];
    
    [[GIphyAPIManager manager] setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    [[GIphyAPIManager manager] setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [[GIphyAPIManager manager] GET:GIPHY_BASE_URL
                           parameters:currentParams
                              success:^(NSURLSessionDataTask *task, id responseObject)
                                {
                                  
                                  NSDictionary* respondsDict = [[NSDictionary alloc] initWithDictionary:responseObject];
                                  
                                      complete(respondsDict, nil);
                                }
                              failure:^(NSURLSessionDataTask *task, NSError *error)
                                {
                                  complete(nil, error);
                                }];
}

@end
