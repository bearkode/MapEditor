/*
 *  FLTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 11..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTileSet.h"


@implementation FLTileSet
{
    NSURL   *mFileURL;
    NSImage *mImage;
}


- (id)initWithImageURL:(NSURL *)aURL
{
    self = [super init];
    
    if (self)
    {
        mFileURL = [aURL retain];
        mImage   = [[NSImage alloc] initWithContentsOfURL:mFileURL];
        
        NSLog(@"mImage = %@", mImage);
    }
    
    return self;
}


- (void)dealloc
{
    [mFileURL release];
    [mImage release];
    
    [super dealloc];
}


@end
