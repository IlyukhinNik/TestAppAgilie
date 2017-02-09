//
//  GifItem.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIphyAPIManager.h"

@interface GifItem : NSObject

@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * dateCreate;
@property (strong, nonatomic) NSString * author;
@property (strong, nonatomic) NSString * title;

@end
