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


+ (NSDictionary *)dictionaryWithRect:(NSRect)aRect
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:aRect.origin.x], kJSONXKey,
                                                      [NSNumber numberWithFloat:aRect.origin.y], kJSONYKey,
                                                      [NSNumber numberWithFloat:aRect.size.width], kJSONWidthKey,
                                                      [NSNumber numberWithFloat:aRect.size.height], kJSONHeightKey, nil];
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


- (NSRect)rectValue
{
    NSRect sResult = NSZeroRect;
    
    sResult.origin.x    = [[self objectForKey:kJSONXKey] floatValue];
    sResult.origin.y    = [[self objectForKey:kJSONYKey] floatValue];
    sResult.size.width  = [[self objectForKey:kJSONWidthKey] floatValue];
    sResult.size.height = [[self objectForKey:kJSONHeightKey] floatValue];
    
    return sResult;
}


@end
