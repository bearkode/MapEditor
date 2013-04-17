/*
 *  FLMapLayer.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTileSet;


typedef enum
{
    kFLMapLayerTerrainType = 0,
    kFLMapLayerObjectType,
} FLMapLayerType;


@interface FLMapLayer : NSObject


@property (nonatomic, readonly) FLMapLayerType type;
@property (nonatomic, retain)   NSString      *name;
@property (nonatomic, retain)   FLTileSet     *tileSet;


- (id)initWithType:(FLMapLayerType)aType;
- (id)initWithJSONObject:(NSDictionary *)aDict;

- (NSDictionary *)JSONObject;


@end
