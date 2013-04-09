/*
 *  FLMapGridView.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 9..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapGridView.h"
#import "FLUtils.h"


@implementation FLMapGridView
{
    NSSize  mMapSize;
    NSSize  mTileSize;
}


- (id)initWithFrame:(NSRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
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


- (void)setMapSize:(NSSize)aMapSize tileSize:(NSSize)aTileSize
{
    mMapSize  = aMapSize;
    mTileSize = aTileSize;
    
    [self setNeedsDisplay:YES];
}


- (BOOL)isFlipped
{
    return YES;
}


- (NSBezierPath *)bezierPathForGrid:(NSPoint)aPoint
{
    NSBezierPath *sPath = [NSBezierPath bezierPath];
    
    [sPath moveToPoint:NSMakePoint(aPoint.x, aPoint.y - mTileSize.height / 2)];
    [sPath lineToPoint:NSMakePoint(aPoint.x + mTileSize.width / 2, aPoint.y)];
    [sPath lineToPoint:NSMakePoint(aPoint.x, aPoint.y + mTileSize.height / 2)];
    [sPath lineToPoint:NSMakePoint(aPoint.x - mTileSize.width / 2, aPoint.y)];
    [sPath closePath];

    return sPath;
}


- (void)drawRect:(NSRect)aRect
{
    [[NSColor blueColor] set];
    
    for (NSInteger y = 0; y < mMapSize.height; y++)
    {
        for (NSInteger x = 0; x < mMapSize.width; x++)
        {
            NSPoint       sPoint = FLGetCenterPointOfGrid(mMapSize, mTileSize, NSMakePoint(x, y));
            NSBezierPath *sPath  = [self bezierPathForGrid:sPoint];
            
            [sPath stroke];
        }
    }
}


@end
