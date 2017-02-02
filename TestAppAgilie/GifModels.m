//
//  GifModels.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GifModels.h"
#import "GIphyAPIManager.h"
#import "GifItem.h"

@implementation GifModels

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.limit = 15;
        self.offset = 0;
        
    }
    return self;
}

- (void) searchGifForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset{
    
    
    NSDictionary* params = @{@"limit": @(limit), @"offset": @(offset), @"q": term};
    
    [GIphyAPIManager searchGifWithParams:params complete:^(id responseObject, NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(errorResponds:)])
            {
                
                [self.delegate errorResponds:[NSString stringWithFormat:@"ERROR: %@", error.localizedDescription]];
            }
        }
        else
        {
 
            if ([responseObject objectForKey:@"pagination"]) {
                
                NSDictionary* paginationDict = [responseObject objectForKey:@"pagination"];
                
                if ([paginationDict objectForKey:@"offset"]) {
                    
                    self.offset =[[paginationDict objectForKey:@"offset"] integerValue];
                }
                
                
            }
            
            if ([responseObject objectForKey:@"data"]&&[[responseObject objectForKey:@"data"]count]>0) {
                
                NSMutableArray* gifDictArray = [responseObject objectForKey:@"data"];
                
                NSMutableArray* gifArray = [NSMutableArray array];
                
                for (NSDictionary* gifDict in gifDictArray) {
                    
                    if ([gifDict objectForKey:@"images"]) {
                        
                        NSDictionary* imagesDict = [gifDict objectForKey:@"images"];
                        
                        if ([imagesDict objectForKey:@"original"]) {
                            
                            NSDictionary* originalDict = [imagesDict objectForKey:@"original"];
                            
                            if ([originalDict objectForKey:@"url"]) {
                                
                                GifItem* gifItem = [[GifItem alloc] initWithResponse:originalDict];
                                
                                
                                [gifArray addObject:gifItem];
                            }
                        }
                    }
                    
                }
                
                if ([self.delegate respondsToSelector:@selector(searchGifForTermResponds:)]) {
                    
                    [self.delegate searchGifForTermResponds:gifArray];
                }
            } else {
                
                if ([self.delegate respondsToSelector:@selector(errorResponds:)]) {
                    
                    [self.delegate errorResponds:[NSString stringWithFormat:@"Gif with that name is not found"]
                     ];
                    
                }
                
            }
            
            
        }
   
    }];
    
}

@end
