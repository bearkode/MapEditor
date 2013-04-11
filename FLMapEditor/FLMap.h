/*
 *  FLMap.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "FLMapView.h"


@class FLMapLayer;


@interface FLMap : NSObject


@property (nonatomic, readonly) NSSize             mapSize;
@property (nonatomic, readonly) NSSize             tileSize;
@property (nonatomic, readonly) NSArrayController *arrayController;


- (id)initWithMapSize:(NSSize)aMapSize tileSize:(NSSize)aTileSize;
- (id)initWithJSONData:(NSData *)aData;

- (NSData *)JSONDataRepresentation;


- (void)insertMapLayerOnTop:(FLMapLayer *)aMapLayer;
- (void)removeMapLayer:(FLMapLayer *)aMapLayer;


@end
