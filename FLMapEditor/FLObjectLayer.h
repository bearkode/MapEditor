/*
 *  FLObjectLayer.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"


@class FLObject;


@interface FLObjectLayer : FLMapLayer


- (BOOL)addObject:(FLObject *)aObject;

- (void)drawObjects;


@end
