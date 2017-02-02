//
//  GifItem.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIphyAPIManager.h"

@protocol GifItemDelegate <NSObject>

-(void) getResponds:(NSData*) imageData;

-(void) errorResponds:(NSString*) error;


@end


@interface GifItem : NSObject

@property (strong, nonatomic) NSString * url;

@property (strong,nonatomic) NSData* imageData;

@property (nonatomic, weak) id < GifItemDelegate > delegate;

- (id) initWithResponse:(NSDictionary*) responseObject;



@end
