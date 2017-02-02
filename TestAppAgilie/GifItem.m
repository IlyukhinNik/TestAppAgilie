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
        self.author = [responseObject objectForKey:@"username"];
        self.url = [[[responseObject objectForKey:@"images"] objectForKey:@"original"] objectForKey:@"url"];
        self.title = [responseObject objectForKey:@"slug"];
        self.dateCreate = [responseObject objectForKey:@"import_datetime"];
        
        
    }
    
    return self;
    
}

@end
