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
#import "FLMapGridView.h"


@implementation FLMapView
{
    FLMapGridView  *mGridView;
    NSTrackingArea *mTrackingArea;
    BOOL            mMouseTracking;
    
    id              mDelegate;
    id              mDataSource;
}


#pragma mark -


- (id)initWithFrame:(NSRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {
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
    mMouseTracking = YES;
}


- (void)mouseExited:(NSEvent *)aEvent
{
    mMouseTracking = NO;
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
                                                 options: (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:mTrackingArea];
}


- (void)drawRect:(NSRect)aRect
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
            
            if (sIsDark)
            {
                [[NSColor colorWithCalibratedRed:(214.0 / 255.0) green:(214.0 / 255.0) blue:(214.0 / 255.0) alpha:(214.0 / 255.0)] set];
            }
            else
            {
                [[NSColor whiteColor] set];
            }
            
            [NSBezierPath fillRect:NSMakeRect(x, y, sGridSize.width, sGridSize.height)];
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
    NSSize sMapSize   = [mDataSource mapSizeOfMapView:self];
    NSSize sTileSize  = [mDataSource tileSizeOfMapView:self];
    NSSize sPixelSize = FLGetPixelSizeFromMapInfo(sMapSize, sTileSize);
    
    [self setFrame:NSMakeRect(0, 0, sPixelSize.width, sPixelSize.height)];
    [mGridView setMapSize:sMapSize tileSize:sTileSize];    
}


@end
