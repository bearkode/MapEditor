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
{
    NSArrayController *mArrayController;
}


@property (nonatomic, readonly) NSArrayController *arrayController;


- (FLTile *)tileAtIndex:(NSInteger)aIndex;
- (FLTile *)tileForTileIndex:(NSInteger)aIndex;


@end
