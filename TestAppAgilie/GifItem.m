//
//  GifItem.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GifItem.h"

@implementation GifItem

- (id) initWithServerResponse:(NSDictionary*) responseObject{
    
    
    self = [super init];
    
    if (self) {

        
        self.url = [responseObject objectForKey:@"url"];
        
    }
    
    return self;
    
}


- (void) loadImageByUrl:(NSString*)url {

    [GIphyAPIManager fileDownload:url progressDownload:^(NSUInteger bytesRead, long long totalRead, long long expectedToRead) {
        
        if ([self.delegate respondsToSelector:@selector(progressLoadImage:expectedToRead:)])
            {
                [self.delegate progressLoadImage: totalRead expectedToRead: expectedToRead];
            }
        
        } complete:^(id responseObject, NSError *error) {

        if(error)
        {
            if ([self.delegate respondsToSelector:@selector(errorResponds:)])
            {
                
                [self.delegate errorResponds:[NSString stringWithFormat:@"ERROR: %@", error.localizedDescription]];
                
            }
        }
        else
        {
            self.imageData = responseObject;
            
            if ([self.delegate respondsToSelector:@selector(getResponds:)]) {
                
                [self.delegate getResponds:responseObject];
            }
  
        }
    }];
    
}

@end
