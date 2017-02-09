//
//  GiphyParser.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 07.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GiphyParser.h"

@implementation GiphyParser

+(GifItem*) getGifItem:(NSDictionary *)response
{
    NSDictionary *gifItemInfoDictionary = [[response objectForKey:@"point"] objectForKey:@"data"];
    if (gifItemInfoDictionary)
    {
        GifItem *parsedGifItem = [GifItem new];
        
        parsedGifItem.author = [gifItemInfoDictionary stringForKey:@"username"];
        parsedGifItem.url = [[[gifItemInfoDictionary objectForKey:@"images"] objectForKey:@"downsized"] stringForKey:@"url"];
        parsedGifItem.title = [gifItemInfoDictionary stringForKey:@"slug"];
        parsedGifItem.dateCreate = [gifItemInfoDictionary stringForKey:@"import_datetime"];
        return parsedGifItem;
    }
    return [GifItem new];
}

+(NSMutableArray *) getArrayGifItems: (NSDictionary*) response
{
    NSMutableArray *arrayParsedGifItems = [NSMutableArray new];
    NSDictionary* infoDictionary = [response objectForKey:@"data"];
    
    for (NSDictionary* gifItemInfoDictionary in infoDictionary)
    {
        GifItem *gifItem = [GifItem new];
        gifItem.author = [gifItemInfoDictionary stringForKey:@"username"];
        gifItem.url = [[[gifItemInfoDictionary objectForKey:@"images"] objectForKey:@"downsized"] stringForKey:@"url"];
        gifItem.title = [gifItemInfoDictionary stringForKey:@"slug"];
        gifItem.dateCreate = [gifItemInfoDictionary stringForKey:@"import_datetime"];
        
        if (gifItem.author.length == 0)
            gifItem.author = @"No name";
        
        [arrayParsedGifItems addObject:gifItem];
    }
    return arrayParsedGifItems;
}
@end
