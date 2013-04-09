/*
 *  FLMapView.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapView.h"
#import "FLUtils.h"


@implementation FLMapView
{
    id mDataSource;
}


- (id)initWithFrame:(NSRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {

    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
    
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (void)drawRect:(NSRect)aRect
{
    [[NSColor lightGrayColor] set];
    [NSBezierPath fillRect:aRect];
}


#pragma mark -


- (void)setDataSource:(id<FLMapViewProtocol>)aDataSource
{
    mDataSource = aDataSource;
}


- (void)reload
{
    NSSize sMapSize   = [mDataSource mapSizeOfMapView:self];
    NSSize sTileSize  = [mDataSource tileSizeOfMapView:self];
    NSSize sPixelSize = FLGetPixelSizeFromMapInfo(sMapSize, sTileSize);
    
    [self setFrame:NSMakeRect(0, 0, sPixelSize.width, sPixelSize.height)];
}


@end
