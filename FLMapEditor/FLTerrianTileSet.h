/*
 *  FLTerrianTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTerrianTile;


@interface FLTerrianTileSet : NSObject


@property (nonatomic, readonly) NSArrayController *arrayController;


- (NSUInteger)count;
- (FLTerrianTile *)insertNewTerrianTile;
- (void)deleteTerrianTile:(FLTerrianTile *)aTerrianTile;

- (void)save;
- (void)rollback;


@end
