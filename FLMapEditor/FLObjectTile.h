/*
 *  FLObjectTile.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 23..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTile.h"


@interface FLObjectTile : FLTile


@property (nonatomic, assign) NSInteger objectId;
@property (nonatomic, assign) BOOL      passable;
@property (nonatomic, retain) NSData   *imageData;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;


@end
