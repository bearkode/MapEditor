/*
 *  FLTerrainLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainLayer.h"


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
    NSLog(@"setTile:atPosition");
    NSLog(@"aTile = %@", aTile);
    NSLog(@"aPosition = %@", NSStringFromPoint(aGridPosition));
}


@end
