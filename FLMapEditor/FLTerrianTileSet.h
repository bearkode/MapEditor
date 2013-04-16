/*
 *  FLTerrianTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTerrainTile;


@interface FLTerrianTileSet : NSObject


@property (nonatomic, readonly) NSArrayController *arrayController;


- (NSUInteger)count;
- (FLTerrainTile *)insertNewTerrianTile;
- (void)deleteTerrianTile:(FLTerrainTile *)aTerrianTile;

- (void)save;
- (void)rollback;


@end
