/*
 *  FLTileSetManager.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTileSetManager.h"
#import "FLObjCUtil.h"
#import "FLTileSet.h"
#import "FLTerrainTileSet.h"
#import "FLObjectTileSet.h"


@implementation FLTileSetManager
{
    FLTileSet *mTerrainTileSet;
    FLTileSet *mObjectTileSet;
}


@synthesize terrainTileSet = mTerrainTileSet;
@synthesize objectTileSet  = mObjectTileSet;


SYNTHESIZE_SHARED_INSTANCE(FLTileSetManager, sharedManager);


- (id)init
{
    self = [super init];
    
    if (self)
    {
        mTerrainTileSet = [[FLTerrainTileSet alloc] init];
        mObjectTileSet  = [[FLObjectTileSet alloc] init];
    }
    
    return self;
}


@end
