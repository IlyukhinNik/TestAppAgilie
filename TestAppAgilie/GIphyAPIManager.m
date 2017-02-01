//
//  GIphyAPIManager.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GIphyAPIManager.h"
#import "Defines.h"

NSString * const kGiphyPublicAPIKey = @"dc6zaTOxFJmzC";

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

-(void) searchGifWithParams: (NSDictionary*) params complete:(void (^)(id responseObject, NSError *error))complete{
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



-(void) fileDownload:(NSString*) url
    progressDownload: (void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)) progressDownload complete:(void (^)(id responseObject, NSError *error))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        AFHTTPRequestOperationManager *requestOperationManager = [[AFHTTPRequestOperationManager alloc]init];
        requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        AFHTTPRequestOperation *operation = [requestOperationManager HTTPRequestOperationWithRequest:request
                                                                                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
                                             {
                                                 
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         
                                                         complete(responseObject, nil);
                                                     });
                                                 
                                             }
                                                                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                             {

                                                     complete(nil, error);
                                                 
                                             }];
        
        if(progressDownload)
        {
            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
             {
                 progressDownload(bytesRead, totalBytesRead, totalBytesExpectedToRead);
             }];
        }
        
        [requestOperationManager.operationQueue addOperation:operation];
        
    });
}



@end
