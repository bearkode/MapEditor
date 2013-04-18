/*
 *  FLDocument.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLDocument.h"
#import "NSScrollView+Additions.h"
#import "FLMapView.h"
#import "FLMap.h"
#import "FLUtils.h"
#import "FLMapLayer.h"
#import "FLTerrainLayer.h"
#import "FLObjectLayer.h"
#import "FLMapLayerItem.h"
#import "FLMapInfoController.h"
#import "FLTerrainTileItem.h"
#import "FLTile.h"
#import "FLTileSet.h"


typedef enum
{
    kFLToolUnknownType = 0,
    kFLToolFillType,
    kFLToolBrushType,
} FLToolType;


@implementation FLDocument
{
    /*  MapInfo  */
    FLMapInfoController *mMapInfoController;
    
    /*  Edit View  */
    NSScrollView        *mScrollView;
    FLMapView           *mMapView;
    
    /*  Info View  */
    NSTextField         *mMapSizeLabel;
    NSTextField         *mTileSizeLabel;
    NSTextField         *mGridPositionLabel;
    
    /*  Layers  */
    NSCollectionView    *mLayerView;
    
    /*  TileSet  */
    NSCollectionView    *mTileSetView;
    
    /*  Model  */
    FLMap               *mMap;
    FLMapLayer          *mSelectedLayer;
    FLTile              *mSelectedTile;
    FLToolType           mSelectedTool;
}


#pragma mark - Properties


/*  Edit View  */
@synthesize scrollView        = mScrollView;
@synthesize mapView           = mMapView;

/*  Info View  */
@synthesize mapSizeLabel      = mMapSizeLabel;
@synthesize tileSizeLabel     = mTileSizeLabel;
@synthesize gridPositionLabel = mGridPositionLabel;

/*  Layers  */
@synthesize layerView         = mLayerView;

/*  TileSet  */
@synthesize tileSetView       = mTileSetView;


#pragma mark -
#pragma mark Privates


- (void)openSheetInWindow:(NSWindow *)aWindow
{
    if (!mMapInfoController)
    {
        mMapInfoController = [[FLMapInfoController alloc] initWithWindowNibName:@"FLMapInfoController"];
    }
    
    [NSApp beginSheet:[mMapInfoController window]
       modalForWindow:aWindow
        modalDelegate:self
       didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
          contextInfo:mMapInfoController];
}


- (void)sheetDidEnd:(NSWindow *)aSheet returnCode:(NSInteger)aReturnCode contextInfo:(void *)aContextInfo
{
    if (aContextInfo == mMapInfoController)
    {
        if (aReturnCode == NSOKButton)
        {
            NSSize sMapSize  = [mMapInfoController mapSize];
            NSSize sTileSize = [mMapInfoController tileSize];
            
            NSLog(@"sMapSize  = %@", NSStringFromSize(sMapSize));
            NSLog(@"sTileSize = %@", NSStringFromSize(sTileSize));
            
            FLMap *sMap = [[[FLMap alloc] initWithMapSize:sMapSize tileSize:sTileSize] autorelease];
            [self setMap:sMap];
            
        }
        else
        {
            [self close];
        }
    }
    
    [aSheet orderOut:self];
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
    [mLayerView unbind:NSContentBinding];
    [mMap autorelease];
    mMap = [aMap retain];
    
    NSArray   *sArrangedObjects = [[mMap arrayController] arrangedObjects];
    NSUInteger sIndex           = [sArrangedObjects count] - 1;
    [mLayerView setContent:sArrangedObjects];
    [mLayerView bind:NSContentBinding toObject:mMap withKeyPath:@"arrayController.arrangedObjects" options:NULL];
    [mLayerView setSelectionIndexes:[NSIndexSet indexSetWithIndex:sIndex]];
    [mLayerView scrollRectToVisible:[mLayerView frameForItemAtIndex:sIndex]];
    
    [self updateInfoView];
    [mMapView reload];
    [mScrollView scrollToCenter];
}


- (void)layerViewSelectionDidChange
{
    NSIndexSet *sIndexSet = [mLayerView selectionIndexes];
    NSUInteger  sIndex    = [sIndexSet firstIndex];
    
    mSelectedLayer = [[[mMap arrayController] arrangedObjects] objectAtIndex:sIndex];
    
    FLTileSet *sTileSet         = [mSelectedLayer tileSet];
    NSArray   *sArrangedObjects = [[sTileSet arrayController] arrangedObjects];
    [mTileSetView setContent:sArrangedObjects];
    [mTileSetView bind:NSContentBinding toObject:sTileSet withKeyPath:@"arrayController.arrangedObjects" options:NULL];
    [mTileSetView setSelectionIndexes:[NSIndexSet indexSet]];
}


- (void)tileSetViewSelectionDidChange
{
    NSIndexSet *sIndexSet = [mTileSetView selectionIndexes];
    NSUInteger  sIndex    = [sIndexSet firstIndex];
    
    if (sIndex != NSNotFound)
    {
        mSelectedTile = [[mSelectedLayer tileSet] tileAtIndex:sIndex];
    }
    else
    {
        mSelectedTile = nil;
    }
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
    [mLayerView removeObserver:self forKeyPath:@"selectionIndexes"];
    [mTileSetView removeObserver:self forKeyPath:@"selectionIndexes"];

    [mMapInfoController release];
    
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
    [mMapView setDelegate:self];

    [mLayerView setItemPrototype:[[[FLMapLayerItem alloc] initWithNibName:@"FLMapLayerItem" bundle:nil] autorelease]];
    [mLayerView setMinItemSize:NSMakeSize(330, 50)];
    [mLayerView setMaxItemSize:NSMakeSize(330, 50)];
    [mLayerView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
    
    [mTileSetView setItemPrototype:[[[FLTerrainTileItem alloc] initWithNibName:@"FLTerrainTileItem" bundle:nil] autorelease]];
    [mTileSetView setMinItemSize:NSMakeSize(120, 120)];
    [mTileSetView setMaxItemSize:NSMakeSize(120, 120)];
    [mTileSetView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
    
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


- (IBAction)saveButtonClicked:(id)aSender
{
    NSLog(@"save button clicked");
    [self saveDocument:self];
    NSLog(@"save end");
}


- (IBAction)fillButtonClicked:(id)aSender
{
    mSelectedTool = kFLToolFillType;
}


- (IBAction)brushButtonClicked:(id)aSender
{
    mSelectedTool = kFLToolBrushType;
}


#pragma mark -


- (IBAction)addLayer:(id)aSender
{
    FLMapLayer *sLayer = [[[FLMapLayer alloc] initWithType:kFLMapLayerObjectType] autorelease];
    [sLayer setName:[NSString stringWithFormat:@"Hello"]];
    
    [mMap insertMapLayerOnTop:sLayer];
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


- (void)mapView:(FLMapView *)aMapView didMouseDownAtPoint:(NSPoint)aPoint
{
    NSPoint sGridPosition = [mMap gridPositionFromViewPoint:aPoint];
    
    if ([mSelectedLayer type] == kFLMapLayerTerrainType)
    {
        FLTerrainLayer *sTerrainLayer = (FLTerrainLayer *)mSelectedLayer;
        
        if (mSelectedTile)
        {
            if (mSelectedTool == kFLToolFillType)
            {
                [sTerrainLayer fillWithTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition];
            }
            else if (mSelectedTool == kFLToolBrushType)
            {
                [sTerrainLayer setTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition];
            }
        }
    }
    else
    {
    
    }
}


- (void)mapView:(FLMapView *)aMapView didMouseUpAtPoint:(NSPoint)aPoint
{

}


- (void)mapView:(FLMapView *)aMapView didMouseDragAtPoint:(NSPoint)aPoint
{
    NSPoint sGridPosition = [mMap gridPositionFromViewPoint:aPoint];
    
    if ([mSelectedLayer type] == kFLMapLayerTerrainType)
    {
        FLTerrainLayer *sTerrainLayer = (FLTerrainLayer *)mSelectedLayer;
        
        if (mSelectedTile)
        {
            if (mSelectedTool == kFLToolBrushType)
            {
                [sTerrainLayer setTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition];
            }
        }
    }
    else
    {
    
    }
}


- (void)mapView:(FLMapView *)aMapView didMouseMoveAtPoint:(NSPoint)aPoint
{
    NSPoint sGridPosition = [mMap gridPositionFromViewPoint:aPoint];
    [mGridPositionLabel setStringValue:NSStringFromPoint(sGridPosition)];
}



#pragma mark -
#pragma mark KVO


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext
{
//    NSLog(@"observeValueForKeyPath:ofObject:change:context");
//    NSLog(@"aKeyPath = %@", aKeyPath);
//    NSLog(@"aObject  = %@", aObject);
//    NSLog(@"aChange  = %@", aChange);
//    NSLog(@"aContext = %p", aContext);
    
    if (aObject == mLayerView)
    {
        if ([aKeyPath isEqualToString:@"selectionIndexes"])
        {
            [self layerViewSelectionDidChange];
        }
    }
    else if (aObject == mTileSetView)
    {
        if ([aKeyPath isEqualToString:@"selectionIndexes"])
        {
            [self tileSetViewSelectionDidChange];
        }
    }
}


@end
