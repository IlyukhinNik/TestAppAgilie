//
//  NSDictionary+Validate.h
//  WikiBonus
//
//  Created by Nikita Ilyukhin on 12/21/15.
//  Copyright © 2015 Nikita Ilyukhin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validate)

-(NSString*)stringForKey:(id)aKey;
-(NSNumber*)numberForKey:(id)aKey;
-(NSUInteger)integerForKey:(id)aKey;
-(NSDictionary*)dictionaryForKey:(id)aKey;
-(NSArray*)arrayForKey:(id)aKey;

@end
