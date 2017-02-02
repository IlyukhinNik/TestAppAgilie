//
//  GIphyAPIManager.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GIphyAPIManager : NSObject

+(void) searchGifWithParams: (NSDictionary*) params complete:(void (^)(id responseObject, NSError *error))complete;

@end
