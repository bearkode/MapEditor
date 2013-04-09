/*
 *  FLUtils.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 9..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLUtils.h"
#import "FLMap.h"


NSSize FLGetPixelSizeFromMap(FLMap *aMap)
{
    NSSize  sMapSize   = [aMap mapSize];
    NSSize  sTileSize  = [aMap tileSize];
    
    return FLGetPixelSizeFromMapInfo(sMapSize, sTileSize);
}


NSSize FLGetPixelSizeFromMapInfo(NSSize aMapSize, NSSize aTileSize)
{
    CGFloat sGridCount = aMapSize.width + aMapSize.height;
    
    return NSMakeSize(aTileSize.width / 2 * sGridCount, aTileSize.height / 2 * sGridCount);
}