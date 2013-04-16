/*
 *  FLTerrainTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTerrainTile;


@interface FLTerrainTileSet : NSObject


@property (nonatomic, readonly) NSArrayController *arrayController;


- (NSUInteger)count;
- (FLTerrainTile *)insertNewTerrainTile;
- (void)deleteTerrainTile:(FLTerrainTile *)aTerrainTile;

- (void)save;
- (void)rollback;


@end
