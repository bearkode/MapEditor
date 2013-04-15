/*
 *  FLTerrianTile.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface FLTerrianTile : NSManagedObject


@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL      passable;
@property (nonatomic, retain) NSImage  *image;


@end
