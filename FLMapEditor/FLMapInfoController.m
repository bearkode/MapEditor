/*
 *  FLMapInfoController.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 16..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapInfoController.h"
#import "NSTextField+Additions.h"


@implementation FLMapInfoController
{
    NSTextField *mMapWidthTextField;
    NSTextField *mMapHeightTextField;
    NSTextField *mTileWidthTextField;
    NSTextField *mTileHeightTextField;
}


@synthesize mapWidthTextField   = mMapWidthTextField;
@synthesize mapHeightTextField  = mMapHeightTextField;
@synthesize tileWidthTextField  = mTileWidthTextField;
@synthesize tileHeightTextField = mTileHeightTextField;


#pragma mark -


- (id)initWithWindow:(NSWindow *)aWindow
{
    self = [super initWithWindow:aWindow];
    
    if (self)
    {

    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


- (void)windowDidLoad
{
    [super windowDidLoad];
}


- (NSSize)mapSize
{
    return NSMakeSize([mMapWidthTextField floatValue], [mMapHeightTextField floatValue]);
}


- (NSSize)tileSize
{
    return NSMakeSize([mTileWidthTextField floatValue], [mTileHeightTextField floatValue]);
}


#pragma mark -


- (IBAction)okButtonClicked:(id)aSender
{
    [NSApp endSheet:[self window] returnCode:NSOKButton];
}


- (IBAction)cancelButtonClicked:(id)aSender
{
    [NSApp endSheet:[self window] returnCode:NSCancelButton];
}


@end
