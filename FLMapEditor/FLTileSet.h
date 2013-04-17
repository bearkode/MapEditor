/*
 *  FLTileSet.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface FLTileSet : NSObject
{
    NSArrayController *mArrayController;
}


@property (nonatomic, readonly) NSArrayController *arrayController;


@end
