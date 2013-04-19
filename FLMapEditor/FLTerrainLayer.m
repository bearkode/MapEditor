/*
 *  FLTerrainLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainLayer.h"
#import "FLTerrainTile.h"
#import "FLTileSet.h"


static NSString *const kTilesKey = @"Tiles";


@implementation FLTerrainLayer
{
    NSMutableArray *mTiles;
}


#pragma mark -


- (void)setupTiles
{
    NSInteger sCount = [self mapSize].width * [self mapSize].height;
    
    [mTiles removeAllObjects];
    for (NSInteger i = 0; i < sCount; i++)
    {
        NSNumber *sEmptyID = [NSNumber numberWithInteger:0];
        [mTiles addObject:sEmptyID];
    }
}


#pragma mark -


- (id)init
{
    NSLog(@"FLTerrainLayer init");
    self = [super initWithType:kFLMapLayerTerrainType];
    
    if (self)
    {
        mTiles = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (id)initWithJSONObject:(NSDictionary *)aDict
{
    NSLog(@"FLTerrainLayer initWithJSONObject");
    self = [super initWithJSONObject:aDict];
    
    if (self)
    {
        mTiles = [[NSMutableArray alloc] init];
        [mTiles addObjectsFromArray:[aDict objectForKey:kTilesKey]];
    }
    
    return self;
}


- (void)dealloc
{
    [mTiles release];
    
    [super dealloc];
}


#pragma mark -


- (NSDictionary *)JSONObject
{
    NSMutableDictionary *sResult = (NSMutableDictionary *)[super JSONObject];

    [sResult setObject:mTiles forKey:kTilesKey];
    
    return sResult;
}


- (void)setMapSize:(NSSize)aMapSize
{
    [super setMapSize:aMapSize];
    [self setupTiles];
}


#pragma mark -


- (void)fillWithTile:(FLTerrainTile *)aTile atPosition:(NSPoint)aPosition
{
    NSLog(@"fillWithTile:atPosition");
    NSLog(@"aTile = %@", aTile);
    NSLog(@"aPosition = %@", NSStringFromPoint(aPosition));
}


- (void)setTile:(FLTerrainTile *)aTile atPosition:(NSPoint)aGridPosition
{
    if (aGridPosition.x >= 0 && aGridPosition.x < [self mapSize].width &&
        aGridPosition.y >= 0 && aGridPosition.y < [self mapSize].height)
    {
        [self setTileIndex:[aTile index] atPosition:aGridPosition];
    }
}


- (FLTerrainTile *)tileAtPosition:(NSPoint)aPosition
{
    NSInteger      sTileIndex = [self tileIndexAtPosition:aPosition];
    FLTerrainTile *sTile      = (FLTerrainTile *)[[self tileSet] tileForTileIndex:sTileIndex];
    
    return sTile;
}


- (NSInteger)tileIndexAtPosition:(NSPoint)aPosition
{
    NSInteger sIndex  = [self mapSize].width * aPosition.y + aPosition.x;
    NSNumber *sNumber = [mTiles objectAtIndex:sIndex];
    
    return [sNumber integerValue];
}


- (void)setTileIndex:(NSInteger)aIndex atPosition:(NSPoint)aPosition
{
    NSInteger sIndex  = [self mapSize].width * aPosition.y + aPosition.x;
    NSNumber *sNumber = [NSNumber numberWithInteger:aIndex];
    
    [mTiles replaceObjectAtIndex:sIndex withObject:sNumber];
}


@end
