/*
 *  FLMapView.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapView.h"
#import <QuartzCore/QuartzCore.h>
#import "FLUtils.h"
#import "FLLayerView.h"
#import "FLMapGridView.h"
#import "FLMapLayer.h"
#import "FLTerrainLayer.h"
#import "FLObjectLayer.h"
#import "FLTerrainTile.h"
#import "FLUtils.h"


#define PBBeginTimeCheck()           double __sCurrentTime = CACurrentMediaTime()
#define PBEndTimeCheck()             NSLog(@"time = %f", CACurrentMediaTime() - __sCurrentTime)


@implementation FLMapView
{
    FLLayerView    *mLayerView;
    FLMapGridView  *mGridView;
    
    NSTrackingArea *mTrackingArea;
    BOOL            mMouseTracking;
    NSSize          mMapSize;
    NSSize          mTileSize;
    
    id              mDelegate;
    id              mDataSource;
}


@synthesize layerView     = mLayerView;
@synthesize mouseTracking = mMouseTracking;


#pragma mark -


- (id)initWithFrame:(NSRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {
        mLayerView = [[[FLLayerView alloc] initWithFrame:NSMakeRect(0, 0, aFrame.size.width, aFrame.size.height)] autorelease];
        [mLayerView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
        [mLayerView setWantsLayer:YES];
        [self addSubview:mLayerView];
        
        mGridView = [[[FLMapGridView alloc] initWithFrame:NSMakeRect(0, 0, aFrame.size.width, aFrame.size.height)] autorelease];
        [mGridView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
        [self addSubview:mGridView];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        NSRect sFrame = [self frame];
        
        mLayerView = [[[FLLayerView alloc] initWithFrame:NSMakeRect(0, 0, sFrame.size.width, sFrame.size.height)] autorelease];
        [mLayerView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
        [mLayerView setWantsLayer:YES];        
        [self addSubview:mLayerView];
        
        mGridView = [[[FLMapGridView alloc] initWithFrame:NSMakeRect(0, 0, sFrame.size.width, sFrame.size.height)] autorelease];
        [mGridView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
        [self addSubview:mGridView];
    }
    
    return self;
}


- (void)dealloc
{
    [mTrackingArea release];
    
    [super dealloc];
}


#pragma mark -


- (BOOL)isFlipped
{
    return YES;
}


#pragma mark -


- (void)mouseDown:(NSEvent *)aEvent
{
    NSPoint sLocation = [self convertPoint:[aEvent locationInWindow] fromView:nil];
    
    if ([mDelegate respondsToSelector:@selector(mapView:didMouseDownAtPoint:)])
    {
        [mDelegate mapView:self didMouseDownAtPoint:sLocation];
    }
}


- (void)mouseDragged:(NSEvent *)aEvent
{
    NSPoint sLocation = [self convertPoint:[aEvent locationInWindow] fromView:nil];
    
    if (NSPointInRect(sLocation, [mTrackingArea rect]))
    {
        mMouseTracking = YES;
    }
    
    if (mMouseTracking)
    {
        if ([mDelegate respondsToSelector:@selector(mapView:didMouseDragAtPoint:)])
        {
            [mDelegate mapView:self didMouseDragAtPoint:sLocation];
        }
    }
}


- (void)mouseUp:(NSEvent *)aEvent
{
    NSPoint sLocation = [self convertPoint:[aEvent locationInWindow] fromView:nil];

    if ([mDelegate respondsToSelector:@selector(mapView:didMouseUpAtPoint:)])
    {
        [mDelegate mapView:self didMouseUpAtPoint:sLocation];
    }
}


- (void)mouseEntered:(NSEvent *)aEvent
{
    NSPoint sLocation = [self convertPoint:[aEvent locationInWindow] fromView:nil];
    
    mMouseTracking = YES;
    
    if ([mDelegate respondsToSelector:@selector(mapView:didMouseEnterAtPoint:)])
    {
        [mDelegate mapView:self didMouseEnterAtPoint:sLocation];
    }
}


- (void)mouseExited:(NSEvent *)aEvent
{
    mMouseTracking = NO;
    
    if ([mDelegate respondsToSelector:@selector(mapViewDidMouseExit:)])
    {
        [mDelegate mapViewDidMouseExit:self];
    }
}


- (void)mouseMoved:(NSEvent *)aEvent
{
    NSPoint sLocation = [self convertPoint:[aEvent locationInWindow] fromView:nil];
    
    if ([mDelegate respondsToSelector:@selector(mapView:didMouseMoveAtPoint:)])
    {
        [mDelegate mapView:self didMouseMoveAtPoint:sLocation];
    }
}


- (void)updateTrackingAreas
{
    if (mTrackingArea)
    {
        [self removeTrackingArea:mTrackingArea];
        [mTrackingArea release];
    }
    
    NSRect sVisibleRect = [self visibleRect];
    mTrackingArea = [[NSTrackingArea alloc] initWithRect:sVisibleRect
                                                 options: (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingMouseMoved)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:mTrackingArea];
}


- (void)drawBackgroundWithDirtyRect:(NSRect)aDirtyRect
{
    NSRect sBounds   = [self bounds];
    NSSize sGridSize = NSMakeSize(15, 15);
    
    BOOL sIsDark = NO;
    for (NSInteger y = 0; y < sBounds.size.height; y += sGridSize.height)
    {
        sIsDark = ((y % 2) == 1) ? NO : YES;
        
        for (NSInteger x = 0; x < sBounds.size.width; x += sGridSize.width)
        {
            sIsDark = (sIsDark) ? NO : YES;

            NSRect sRect = NSMakeRect(x, y, sGridSize.width, sGridSize.height);            
            if (NSIntersectsRect(aDirtyRect, sRect))
            {
                if (sIsDark)
                {
                    [[NSColor colorWithCalibratedRed:(214.0 / 255.0) green:(214.0 / 255.0) blue:(214.0 / 255.0) alpha:(214.0 / 255.0)] set];
                }
                else
                {
                    [[NSColor whiteColor] set];
                }
                
                [NSBezierPath fillRect:sRect];
            }
        }
    }
}


- (void)drawTerrainLayer:(FLTerrainLayer *)aTerrainLayer dirtyRect:(NSRect)aDirtyRect
{
    for (NSInteger y = 0; y < mMapSize.height; y++)
    {
        for (NSInteger x = 0; x < mMapSize.width; x++)
        {
            NSPoint        sGridPosition = NSMakePoint(x, y);
            FLTerrainTile *sTile         = [aTerrainLayer tileAtPosition:sGridPosition];
            
            if (sTile)
            {
                NSPoint  sPoint     = FLGetCenterPointOfGrid(mMapSize, mTileSize, NSMakePoint(x, y));
                NSImage *sTileImage = [sTile image];
                NSRect   sInRect    = NSMakeRect(sPoint.x - mTileSize.width / 2, sPoint.y - mTileSize.height / 2, mTileSize.width, mTileSize.height);
                NSRect   sFromRect  = NSMakeRect(0, 0, [sTileImage size].width, [sTileImage size].height);

                if (NSIntersectsRect(aDirtyRect, sInRect))
                {
                    [sTileImage drawAtPoint:sInRect.origin fromRect:sFromRect operation:NSCompositeSourceAtop fraction:1.0];
                }
            }
        }
    }
}


- (void)drawObjectLayer:(FLObjectLayer *)aObjectLayer
{

}


- (void)drawRect:(NSRect)aRect
{
    [self drawBackgroundWithDirtyRect:aRect];
    
    NSArray *sLayers = [[[mDelegate layersForMapView:self] reverseObjectEnumerator] allObjects];
    for (FLMapLayer *sLayer in sLayers)
    {
        if ([sLayer isKindOfClass:[FLTerrainLayer class]])
        {
            PBBeginTimeCheck();
            [self drawTerrainLayer:(FLTerrainLayer *)sLayer dirtyRect:aRect];
            PBEndTimeCheck();
        }
        else
        {
            [self drawObjectLayer:(FLObjectLayer *)sLayer];
        }
    }
}


#pragma mark -


- (void)setDataSource:(id<FLMapViewProtocol>)aDataSource
{
    mDataSource = aDataSource;
}


- (void)setDelegate:(id<FLMapViewProtocol>)aDelegate
{
    mDelegate = aDelegate;
}


- (void)reload
{
    NSSize sPixelSize = NSZeroSize;
    
    mMapSize   = [mDataSource mapSizeOfMapView:self];
    mTileSize  = [mDataSource tileSizeOfMapView:self];
    sPixelSize = FLGetPixelSizeFromMapInfo(mMapSize, mTileSize);
    
    [self setFrame:NSMakeRect(0, 0, sPixelSize.width, sPixelSize.height)];
    [self setNeedsDisplay:YES];
    [mGridView setMapSize:mMapSize tileSize:mTileSize];
}


- (void)setNeedsDisplayAtGridPosition:(NSPoint)aPosition
{
    NSPoint sPoint          = FLGetCenterPointOfGrid(mMapSize, mTileSize, aPosition);
    NSRect  sInvalidateRect = NSMakeRect(sPoint.x - 50, sPoint.y - 50, 100, 100);
    
    [self setNeedsDisplayInRect:sInvalidateRect];
}


@end
