/*
 *  NSDictionary+JSONAddition.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 11..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface NSDictionary (JSONAddition)


+ (NSDictionary *)dictionaryWithSize:(NSSize)aSize;
+ (NSDictionary *)dictionaryWithPoint:(NSPoint)aPoint;
+ (NSDictionary *)dictionaryWithRect:(NSRect)aRect;

- (NSSize)sizeValue;
- (NSPoint)pointValue;
- (NSRect)rectValue;


@end
