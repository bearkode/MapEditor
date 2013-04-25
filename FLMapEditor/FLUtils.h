/*
 *  FLUtils.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 9..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLMap;


NSSize FLGetPixelSizeFromMap(FLMap *aMap);
NSSize FLGetPixelSizeFromMapInfo(NSSize aMapSize, NSSize aTileSize);

NSPoint FLGetGridPositionFromScreenPoint(FLMap *aMap, NSPoint aPoint);
NSPoint FLGetCenterPointOfGrid(NSSize aMapSize, NSSize aTileSize, NSPoint aGridPosition);
NSPoint FLGetCenterPointOfGridWithMap(FLMap *aMap, NSPoint aGridPosition);