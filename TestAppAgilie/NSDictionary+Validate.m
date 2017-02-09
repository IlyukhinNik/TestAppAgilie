//
//  NSDictionary+Validate.m
//  WikiBonus
//
//  Created by Nikita Ilyukhin on 12/21/15.
//  Copyright © 2015 Nikita Ilyukhin. All rights reserved.
//

#import "NSDictionary+Validate.h"

@implementation NSDictionary (Validate)

-(NSString*)stringForKey:(id)aKey
{
    if([self[aKey] isKindOfClass:[NSString class]])
        return [self objectForKey:aKey];
    else if ([self[aKey] isKindOfClass:[NSNumber class]])
        return [(NSNumber*)[self objectForKey:aKey] stringValue];
    return @"";
}
-(NSNumber*)numberForKey:(id)aKey
{
    if([[self objectForKey:aKey] isKindOfClass:[NSNumber class]])
        return [self objectForKey:aKey];
    
    return [NSNumber new];
}
-(NSUInteger)integerForKey:(id)aKey
{
    if([self[aKey] isKindOfClass:[NSString class]]|| [self[aKey] isKindOfClass:[NSNumber class]])
        return [self[aKey] integerValue];
    return 0;
}


-(NSDictionary*)dictionaryForKey:(id)aKey
{
    if([self[aKey] isKindOfClass:[NSDictionary class]])
        return [self objectForKey:aKey];
    
    return @{};
}

-(NSArray*)arrayForKey:(id)aKey
{
    if([self[aKey] isKindOfClass:[NSArray class]])
        return [self objectForKey:aKey];
    
    return @[];
}
@end
