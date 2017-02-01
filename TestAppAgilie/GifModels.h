//
//  GifModels.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIphyAPIManager;

@protocol GifModelsDelegate <NSObject>

-(void) searchGifForTermResponds:(NSMutableArray*) gifArray;

-(void) errorResponds:(NSString*) errorDescription;



@end
@interface GifModels : NSObject

@property (nonatomic, weak) id < GifModelsDelegate > delegate;

@property(assign,nonatomic) NSUInteger limit;

@property(assign, nonatomic) NSInteger offset;


- (void) searchGifForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset;

@end
