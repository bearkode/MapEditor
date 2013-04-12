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
#import "NSScrollView+Additions.h"
#import "FLMapView.h"
#import "FLMap.h"
#import "FLUtils.h"
#import "FLMapLayer.h"
#import "FLMapLayerItem.h"
#import "FLTileSet.h"


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
    NSCollectionView  *mLayerCollectionView;
    
    /*  Model  */
    FLMap             *mMap;
    FLMapLayer        *mCurrentLayer;
    FLTileSet         *mCurrentTileSet;
}


#pragma mark - Properties


@synthesize fileNewPanel         = mFileNewPanel;
@synthesize mapWidthTextField    = mMapWidthTextField;
@synthesize mapHeightTextField   = mMapHeightTextField;
@synthesize tileWidthTextField   = mTileWidthTextField;
@synthesize tileHeightTextField  = mTileHeightTextField;

@synthesize scrollView           = mScrollView;
@synthesize mapView              = mMapView;

@synthesize mapSizeLabel         = mMapSizeLabel;
@synthesize tileSizeLabel        = mTileSizeLabel;

@synthesize layerCollectionView  = mLayerCollectionView;


#pragma mark -
#pragma mark Privates


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
    [mLayerCollectionView unbind:NSContentBinding];
    [mMap autorelease];
    mMap = [aMap retain];
    
    NSArray   *sArrangedObjects = [[mMap arrayController] arrangedObjects];
    NSUInteger sIndex           = [sArrangedObjects count] - 1;
    [mLayerCollectionView setContent:sArrangedObjects];
    [mLayerCollectionView bind:NSContentBinding toObject:mMap withKeyPath:@"arrayController.arrangedObjects" options:NULL];
    [mLayerCollectionView setSelectionIndexes:[NSIndexSet indexSetWithIndex:sIndex]];
    [mLayerCollectionView scrollRectToVisible:[mLayerCollectionView frameForItemAtIndex:sIndex]];
    
    [self updateInfoView];
    [mMapView reload];
    [mScrollView scrollToCenter];
}


#pragma mark -
#pragma mark init / dealloc


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
    [mLayerCollectionView removeObserver:self forKeyPath:@"selectionIndexes"];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Inherited


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

    [mLayerCollectionView setItemPrototype:[[[FLMapLayerItem alloc] init] autorelease]];
    [mLayerCollectionView setMinItemSize:NSMakeSize(330, 50)];
    [mLayerCollectionView setMaxItemSize:NSMakeSize(330, 50)];
    [mLayerCollectionView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
    
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


#pragma mark -


- (IBAction)addLayer:(id)aSender
{
    FLMapLayer *sLayer = [[[FLMapLayer alloc] init] autorelease];
    [sLayer setName:[NSString stringWithFormat:@"Hello"]];
    
    [mMap insertMapLayerOnTop:sLayer];
}


- (IBAction)removeLayer:(id)aSender
{
    NSLog(@"remove layer");
}


#pragma mark -


- (IBAction)loadTileSetButtonClicked:(id)aSender
{
    NSWindowController *sWindowController = [[self windowControllers] objectAtIndex:0];
    NSOpenPanel        *sOpenPanel        = [NSOpenPanel openPanel];
   
    [sOpenPanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
    [sOpenPanel beginSheetModalForWindow:[sWindowController window] completionHandler:^(NSInteger aResult) {
        if (aResult == NSFileHandlingPanelOKButton)
        {
            FLTileSet *sTileSet = [[[FLTileSet alloc] initWithImageURL:[[sOpenPanel URLs] objectAtIndex:0]] autorelease];
            [mCurrentLayer setTileSet:sTileSet];
            mCurrentTileSet = sTileSet;
        }
    }];
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


#pragma mark -
#pragma mark KVO


- (void)layerCollectionViewSelectionDidChange
{
    NSIndexSet *sIndexSet = [mLayerCollectionView selectionIndexes];
    NSUInteger  sIndex    = [sIndexSet firstIndex];

    mCurrentLayer   = [[[mMap arrayController] arrangedObjects] objectAtIndex:sIndex];
    mCurrentTileSet = [mCurrentLayer tileSet];
}


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext
{
//    NSLog(@"observeValueForKeyPath:ofObject:change:context");
//    NSLog(@"aKeyPath = %@", aKeyPath);
//    NSLog(@"aObject  = %@", aObject);
//    NSLog(@"aChange  = %@", aChange);
//    NSLog(@"aContext = %p", aContext);
    
    if (aObject == mLayerCollectionView)
    {
        if ([aKeyPath isEqualToString:@"selectionIndexes"])
        {
            [self layerCollectionViewSelectionDidChange];
        }
    }
}


@end
