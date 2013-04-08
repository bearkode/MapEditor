/*
 *  FLJSONHelper.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface FLJSONHelper : NSObject


+ (NSDictionary *)dictionaryWithSize:(NSSize)aSize;
+ (NSSize)sizeWithDictionary:(NSDictionary *)aDict;

+ (NSDictionary *)dictionaryWithPoint:(NSPoint)aPoint;
+ (NSPoint)pointWitihDictionary:(NSDictionary *)aDict;


@end
