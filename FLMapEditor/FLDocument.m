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
#import "FLUtils.h"
#import "FLMapLayer.h"
#import "FLMapLayerItem.h"


@implementation FLDocument
{
    /*  File New  */
    NSPanel           *mFileNewPanel;
    NSTextField       *mMapWidthTextField;
    NSTextField       *mMapHeightTextField;
    NSTextField       *mTileWidthTextField;
    NSTextField       *mTileHeightTextField;
    
    /*  Edit View  */
    NSScrollView      *mScrollView;
    FLMapView         *mMapView;
    
    /*  Info View  */
    NSTextField       *mMapSizeLabel;
    NSTextField       *mTileSizeLabel;
    
    /*  Layers  */
    NSArrayController *mLayerArrayController;
    NSCollectionView  *mLayerCollectionView;
    
    /*  Model  */
    FLMap             *mMap;
}


@synthesize fileNewPanel         = mFileNewPanel;
@synthesize mapWidthTextField    = mMapWidthTextField;
@synthesize mapHeightTextField   = mMapHeightTextField;
@synthesize tileWidthTextField   = mTileWidthTextField;
@synthesize tileHeightTextField  = mTileHeightTextField;

@synthesize scrollView           = mScrollView;
@synthesize mapView              = mMapView;

@synthesize mapSizeLabel         = mMapSizeLabel;
@synthesize tileSizeLabel        = mTileSizeLabel;

@synthesize layerArrayController = mLayerArrayController;
@synthesize layerCollectionView  = mLayerCollectionView;


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


- (void)setMap:(FLMap *)aMap
{
    [mMap autorelease];
    mMap = [aMap retain];
    
    [self updateInfoView];
    [mMapView reload];
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

    [mMapView setDataSource:self];
    
    FLMapLayerItem *sLayerItem = [[[FLMapLayerItem alloc] init] autorelease];
    [mLayerCollectionView setItemPrototype:sLayerItem];
    [mLayerCollectionView setMinItemSize:NSMakeSize(330, 80)];
    [mLayerCollectionView setMaxItemSize:NSMakeSize(330, 80)];
    
    if (mMap)
    {
        [self setMap:mMap];
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
    FLMap *sMap = [[[FLMap alloc] initWithJSONData:aData] autorelease];
    [self setMap:sMap];
    
    return YES;
}


#pragma mark -
#pragma mark Actions


- (IBAction)fileNewOkButtonClicked:(id)aSender
{
    NSSize sMapSize  = NSMakeSize([mMapWidthTextField floatValue], [mMapHeightTextField floatValue]);
    NSSize sTileSize = NSMakeSize([mTileWidthTextField floatValue], [mTileHeightTextField floatValue]);

    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
    
    FLMap *sMap = [[[FLMap alloc] initWithMapSize:sMapSize tileSize:sTileSize] autorelease];
    [self setMap:sMap];
}


- (IBAction)fileNewCancelButtonClicked:(id)aSender
{
    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
}


- (IBAction)addLayer:(id)aSender
{
    NSInteger sCount = [[mLayerArrayController arrangedObjects] count];
    
    FLMapLayer *sLayer = [[[FLMapLayer alloc] init] autorelease];
    [sLayer setName:[NSString stringWithFormat:@"Hello %d", (int)sCount]];
    
    [mLayerArrayController addObject:sLayer];
}


- (IBAction)removeLayer:(id)aSender
{
    NSLog(@"remove layer");
}


#pragma mark -
#pragma mark MapViewDataSource


- (NSSize)mapSizeOfMapView:(FLMapView *)aMapView
{
    return [mMap mapSize];
}


- (NSSize)tileSizeOfMapView:(FLMapView *)aMapView
{
    return [mMap tileSize];
}


@end
