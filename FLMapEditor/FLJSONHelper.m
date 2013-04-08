/*
 *  FLJSONHelper.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLJSONHelper.h"


NSString *const kJSONWidthKey  = @"width";
NSString *const kJSONHeightKey = @"height";
NSString *const kJSONXKey      = @"x";
NSString *const kJSONYKey      = @"y";


@implementation FLJSONHelper


+ (NSDictionary *)dictionaryWithSize:(NSSize)aSize
{
    NSMutableDictionary *sResult = [NSMutableDictionary dictionary];
    
    [sResult setObject:[NSNumber numberWithFloat:aSize.width] forKey:kJSONWidthKey];
    [sResult setObject:[NSNumber numberWithFloat:aSize.height] forKey:kJSONHeightKey];
    
    return sResult;
}


+ (NSSize)sizeWithDictionary:(NSDictionary *)aDict
{
    NSSize sResult = NSMakeSize(NAN, NAN);
    
    sResult.width  = [[aDict objectForKey:kJSONWidthKey] floatValue];
    sResult.height = [[aDict objectForKey:kJSONHeightKey] floatValue];
    
    return sResult;
}


+ (NSDictionary *)dictionaryWithPoint:(NSPoint)aPoint
{
    NSMutableDictionary *sResult = [NSMutableDictionary dictionary];
    
    [sResult setObject:[NSNumber numberWithFloat:aPoint.x] forKey:kJSONXKey];
    [sResult setObject:[NSNumber numberWithFloat:aPoint.y] forKey:kJSONYKey];
    
    return sResult;
}


+ (NSPoint)pointWitihDictionary:(NSDictionary *)aDict
{
    NSPoint sResult = NSMakePoint(NAN, NAN);
    
    sResult.x = [[aDict objectForKey:kJSONXKey] floatValue];
    sResult.y = [[aDict objectForKey:kJSONYKey] floatValue];
    
    return sResult;
}


@end
