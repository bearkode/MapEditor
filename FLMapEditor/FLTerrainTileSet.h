/*
 *  FLTerrainTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "FLTileSet.h"


@class FLTerrainTile;


@interface FLTerrainTileSet : FLTileSet


- (NSUInteger)count;
- (FLTerrainTile *)terrainTileAtIndex:(NSInteger)aIndex;
- (FLTerrainTile *)insertNewTerrainTile;
- (void)deleteTerrainTile:(FLTerrainTile *)aTerrainTile;
- (void)deleteTerrainTileAtIndex:(NSInteger)aIndex;

- (void)save;
- (void)rollback;


@end
