//
//  GifItem.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GifItem.h"

@implementation GifItem

- (id) initWithResponse:(NSDictionary*) responseObject{
    
    
    self = [super init];
    
    if (self) {

        
        self.url = [responseObject objectForKey:@"url"];
        
    }
    
    return self;
    
}

@end
