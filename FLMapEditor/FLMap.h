/*
 *  FLMap.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface FLMap : NSObject


- (id)initWithSize:(NSSize)aSize;
- (id)initWithJSONData:(NSData *)aData;

- (NSData *)JSONDataRepresentation;


@end
