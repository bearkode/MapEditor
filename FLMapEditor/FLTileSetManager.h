/*
 *  FLTileSetManager.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTileSet;


@interface FLTileSetManager : NSObject


@property (nonatomic, readonly) FLTileSet *terrainTileSet;
@property (nonatomic, readonly) FLTileSet *objectTileSet;


+ (id)sharedManager;


@end
