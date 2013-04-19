/*
 *  FLTerrainLayer.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"


@class FLTerrainTile;


@interface FLTerrainLayer : FLMapLayer


- (void)fillWithTile:(FLTerrainTile *)aTile atPosition:(NSPoint)aPosition;
- (BOOL)setTile:(FLTerrainTile *)aTile atPosition:(NSPoint)aGridPosition;
- (FLTerrainTile *)tileAtPosition:(NSPoint)aPosition;
- (NSInteger)tileIndexAtPosition:(NSPoint)aPosition;

@end
