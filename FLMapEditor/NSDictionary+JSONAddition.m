/*
 *  NSDictionary+JSONAddition.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 11..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "NSDictionary+JSONAddition.h"


NSString *const kJSONWidthKey  = @"width";
NSString *const kJSONHeightKey = @"height";
NSString *const kJSONXKey      = @"x";
NSString *const kJSONYKey      = @"y";


@implementation NSDictionary (JSONAddition)


+ (NSDictionary *)dictionaryWithSize:(NSSize)aSize
{
    NSDictionary *sResult = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:aSize.width], kJSONWidthKey,
                                                                       [NSNumber numberWithFloat:aSize.height], kJSONHeightKey, nil];
    
    return sResult;

}


+ (NSDictionary *)dictionaryWithPoint:(NSPoint)aPoint
{
    NSDictionary *sResult = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:aPoint.x], kJSONXKey,
                                                                       [NSNumber numberWithFloat:aPoint.y], kJSONYKey, nil];
    
    return sResult;

}


- (NSSize)sizeValue
{
    NSSize sResult = NSMakeSize(NAN, NAN);
    
    sResult.width  = [[self objectForKey:kJSONWidthKey] floatValue];
    sResult.height = [[self objectForKey:kJSONHeightKey] floatValue];
    
    return sResult;
}


- (NSPoint)pointValue
{
    NSPoint sResult = NSMakePoint(NAN, NAN);
    
    sResult.x = [[self objectForKey:kJSONXKey] floatValue];
    sResult.y = [[self objectForKey:kJSONYKey] floatValue];
    
    return sResult;
}


@end
