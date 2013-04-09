/*
 *  FLDocument.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLDocument.h"
#import "NSTextField+Additions.h"
#import "FLMapView.h"
#import "FLMap.h"


@implementation FLDocument
{
    /*  File New  */
    NSPanel      *mFileNewPanel;
    NSTextField  *mMapWidthTextField;
    NSTextField  *mMapHeightTextField;
    NSTextField  *mTileWidthTextField;
    NSTextField  *mTileHeightTextField;
    
    /*  Edit View  */
    NSScrollView *mScrollView;
    FLMapView    *mMapView;
    
    /*  Info View  */
    NSTextField  *mMapSizeLabel;
    NSTextField  *mTileSizeLabel;
    
    /*  Model  */
    FLMap        *mMap;
}


@synthesize fileNewPanel        = mFileNewPanel;
@synthesize mapWidthTextField   = mMapWidthTextField;
@synthesize mapHeightTextField  = mMapHeightTextField;
@synthesize tileWidthTextField  = mTileWidthTextField;
@synthesize tileHeightTextField = mTileHeightTextField;

@synthesize scrollView          = mScrollView;
@synthesize mapView             = mMapView;

@synthesize mapSizeLabel        = mMapSizeLabel;
@synthesize tileSizeLabel       = mTileSizeLabel;


#pragma mark -


- (void)openSheetInWindow:(NSWindow *)aWindow
{
    [NSApp beginSheet:mFileNewPanel modalForWindow:aWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
}


- (void)updateInfoView
{
    NSSize sMapSize  = [mMap mapSize];
    NSSize sTileSize = [mMap tileSize];
    
    [mMapSizeLabel setStringValue:NSStringFromSize(sMapSize)];
    [mTileSizeLabel setStringValue:NSStringFromSize(sTileSize)];
}


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
    [super dealloc];
}


#pragma mark -


- (NSString *)windowNibName
{
    /*
     *  Override returning the nib file name of the document
     *  If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers,
     *  you should remove this method and override -makeWindowControllers instead.
     */
    
    return @"FLDocument";
}


- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    if (mMap)
    {
        [self updateInfoView];    
    }
    else
    {
        [self performSelector:@selector(openSheetInWindow:) withObject:[aController window] afterDelay:0.0];
    }
}


+ (BOOL)autosavesInPlace
{
    return YES;
}


- (NSData *)dataOfType:(NSString *)aTypeName error:(NSError **)aOutError
{
    NSData *sResult = nil;
    
    sResult = [mMap JSONDataRepresentation];

    return sResult;
}


- (BOOL)readFromData:(NSData *)aData ofType:(NSString *)aTypeName error:(NSError **)aOutError
{
    [mMap autorelease];
    mMap = [[FLMap alloc] initWithJSONData:aData];
    
    return YES;
}


#pragma mark -


- (IBAction)fileNewOkButtonClicked:(id)aSender
{
    NSSize sMapSize  = NSMakeSize([mMapWidthTextField floatValue], [mMapHeightTextField floatValue]);
    NSSize sTileSize = NSMakeSize([mTileWidthTextField floatValue], [mTileHeightTextField floatValue]);

    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
    
    [mMap autorelease];
    mMap = [[FLMap alloc] initWithMapSize:sMapSize tileSize:sTileSize];
    [self updateInfoView];
}


- (IBAction)fileNewCancelButtonClicked:(id)aSender
{
    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
}


@end
