/*
 *  FLTerrainTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTileSet.h"
#import "FLTerrainTile.h"


@implementation FLTerrainTileSet


- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self fetch];
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (NSString *)entityName
{
    return @"FLTerrainTile";
}


- (NSURL *)storeURL
{
    NSArray  *sDocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *sDocPath  = ([sDocPaths count] > 0) ? [sDocPaths objectAtIndex:0] : nil;
    NSURL    *sStoreURL = [NSURL fileURLWithPath:[sDocPath stringByAppendingPathComponent:@"TerrainTileSet.sqlite"]];
    
    return sStoreURL;
}


@end
