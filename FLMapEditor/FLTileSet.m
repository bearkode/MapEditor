/*
 *  FLTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTileSet.h"


@implementation FLTileSet


@synthesize arrayController = mArrayController;


#pragma mark -


- (id)init
{
    self = [super init];
    
    if (self)
    {
    
    }
    
    return self;
}


- (void)dealloc
{
    [mArrayController release];
    
    [super dealloc];
}


#pragma mark -


@end
