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