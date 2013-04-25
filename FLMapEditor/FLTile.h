/*
 *  FLTile.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <CoreData/CoreData.h>


@interface FLTile : NSManagedObject


@property (nonatomic, assign) NSInteger objectId;


- (NSImage *)image;


@end
