/*
 *  FLTerrianTile.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrianTile.h"


@implementation FLTerrianTile
 {
     NSInteger mIndex;
     BOOL      mPassable;
     NSImage  *mImage;
 }


@synthesize index    = mIndex;
@synthesize passable = mPassable;
@synthesize image    = mImage;


 #pragma mark -

 
- (id)initWithImage:(NSImage *)aImage
{
    self = [super init];
 
    if (self)
    {
        mImage = [aImage retain];
    }
 
    return self;
}
 
 
- (void)dealloc
{
    [mImage release];
    
    [super dealloc];
}

 
@end
