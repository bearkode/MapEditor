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


NSPoint FLGetGridPositionFromScreenPoint(FLMap *aMap, NSPoint aPoint)
{
    NSSize            sSize    = FLGetPixelSizeFromMap(aMap);
    CGAffineTransform sFromIso = [aMap transform];
    CGPoint           sResult;
    
    aPoint.y  = sSize.height - aPoint.y;
    sResult   = CGPointApplyAffineTransform(aPoint, sFromIso);
    sResult.x = [aMap mapSize].width  - floor(sResult.x) - 1;
    sResult.y = [aMap mapSize].height - floor(sResult.y) - 1;
    
    return sResult;
}


NSPoint FLGetCenterPointOfGrid(NSSize aMapSize, NSSize aTileSize, NSPoint aGridPosition)
{
    CGFloat sXBase = aMapSize.height * aTileSize.width / 2;
    CGFloat sYBase = aTileSize.height / 2;
    NSPoint sPoint = NSZeroPoint;

    sPoint.x += sXBase;
    sPoint.y += sYBase;

    sPoint.x += aGridPosition.x * aTileSize.width / 2;
    sPoint.x -= aGridPosition.y * aTileSize.width / 2;
    sPoint.y += aGridPosition.x * aTileSize.height / 2;
    sPoint.y += aGridPosition.y * aTileSize.height / 2;
    
    return sPoint;
}


NSPoint FLGetCenterPointOfGridWithMap(FLMap *aMap, NSPoint aGridPosition)
{
    return FLGetCenterPointOfGrid([aMap mapSize], [aMap tileSize], aGridPosition);
}