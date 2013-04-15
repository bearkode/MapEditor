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
    NSData   *mImageData;
}


@synthesize index    = mIndex;
@synthesize passable = mPassable;
@synthesize image    = mImage;
@dynamic    imageData;


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
    [mImageData release];
    
    [super dealloc];
}


#pragma mark -


- (void)setImageData:(NSData *)aImageData
{
    [mImageData autorelease];
    mImageData = [aImageData retain];
    
    [mImage autorelease];
    mImage = [[NSImage alloc] initWithData:mImageData];
}


- (NSData *)imageData
{
    return mImageData;
}


@end
