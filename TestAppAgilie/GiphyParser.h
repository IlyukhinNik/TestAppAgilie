//
//  GiphyParser.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 07.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GifItem.h"
#import "NSDictionary+Validate.h"


@interface GiphyParser : NSObject

+(GifItem*) getGifItem: (NSDictionary*) response;
+(NSMutableArray*) getArrayGifItems: (NSDictionary*) response;

@end
