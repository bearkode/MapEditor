/*
 *  FLTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLTile;


@interface FLTileSet : NSObject


@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSArray                *tiles;


/*  Attributes  */
- (NSString *)entityName;
- (NSURL *)storeURL;
- (NSDictionary *)storeOptions;


//- (void)setTilesFromArray:(NSArray *)aTiles;


- (FLTile *)insertNewTile;
- (void)deleteTileAtIndex:(NSInteger)aIndex;


- (NSUInteger)indexOfTile:(FLTile *)aTile;
- (FLTile *)tileAtIndex:(NSInteger)aIndex;
- (FLTile *)tileForObjectId:(NSInteger)aObjectId;


- (void)fetch;
- (void)save;
- (void)rollback;


@end
