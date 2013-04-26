/*
 *  FLDocument.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLDocument.h"
#import <QuartzCore/QuartzCore.h>
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
#import "FLTerrainTile.h"
#import "FLObjectTile.h"
#import "FLObject.h"
#import "FLTileSet.h"
#import "FLLayerView.h"


typedef enum
{
    kFLToolUnknownType = 0,
    kFLToolFillType,
    kFLToolBrushType,
} FLToolType;


@implementation FLDocument
{
    NSWindow            *mWindow;
    
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
    
    CALayer             *mTileLayer;
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
    
    FLTileSet *sTileSet = [mSelectedLayer tileSet];
    [mTileSetView setContent:[sTileSet tiles]];
    [mTileSetView bind:NSContentBinding toObject:sTileSet withKeyPath:@"tiles" options:NULL];
    [mTileSetView setSelectionIndexes:[NSIndexSet indexSet]];
    
    mSelectedTile = nil;
    [self setTileLayerContents:nil];
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

    if (mSelectedTile && [mMapView isMouseTracking])
    {
        [self setTileLayerContents:[mSelectedTile image]];
    }
}


- (void)setTileLayerContents:(NSImage *)aImage
{
    CGSize sImageSize = [aImage size];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [mTileLayer setContents:aImage];
    [mTileLayer setFrame:CGRectMake(0, 0, sImageSize.width, sImageSize.height)];
    [CATransaction commit];
}


- (void)setTileLayerAtPosition:(NSPoint)aPosition
{
    NSPoint sGridPositoin = FLGetGridPositionFromScreenPoint(mMap, aPosition);
    NSPoint sPoint        = FLGetCenterPointOfGridWithMap(mMap, sGridPositoin);
    
    if ([mSelectedTile isKindOfClass:[FLObjectTile class]])
    {
        FLObjectTile *sObjectTile = (FLObjectTile *)mSelectedTile;
        NSInteger     sWidth      = [sObjectTile width];
        NSInteger     sHeight     = [sObjectTile height];
        NSImage      *sImage      = [sObjectTile image];
        NSSize        sImageSize  = [sImage size];
        
        sPoint.y -= (sImageSize.height / 2);
        sPoint.y += ([mMap tileSize].height * sWidth);
        sPoint.y -= ([mMap tileSize].height / 2);
    
        if ([mMap canObjectPlaceAtGridPosition:sGridPositoin size:NSMakeSize(sWidth, sHeight)])
        {
            [mTileLayer setFilters:nil];
        }
        else
        {
            if ([[mTileLayer filters] count] == 0)
            {
                CIFilter *sFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
                [sFilter setDefaults];
                [sFilter setValue:[CIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"inputColor"];
                
                [mTileLayer setFilters:[NSArray arrayWithObject:sFilter]];
            }
        }
    }

    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [mTileLayer setPosition:sPoint];
    [CATransaction commit];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:NSViewBoundsDidChangeNotification];
    
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

    [[mScrollView contentView] setPostsBoundsChangedNotifications:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewBoundsDidChange:) name:NSViewBoundsDidChangeNotification object:[mScrollView contentView]];

    mTileLayer = [CATiledLayer layer];
    [mTileLayer setOpacity:0.7];
    [[[mMapView layerView] layer] addSublayer:mTileLayer];

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


- (NSArray *)layersForMapView:(FLMapView *)aMapView
{
    return [mMap layers];
}


- (void)mapView:(FLMapView *)aMapView didMouseDownAtPoint:(NSPoint)aPoint
{
    NSPoint sGridPosition = FLGetGridPositionFromScreenPoint(mMap, aPoint);
    
    [self setTileLayerAtPosition:aPoint];
    
    if ([mSelectedLayer type] == kFLMapLayerTerrainType)
    {
        FLTerrainLayer *sTerrainLayer = (FLTerrainLayer *)mSelectedLayer;
        
        if ([mSelectedTile isKindOfClass:[FLTerrainTile class]])
        {
            if (mSelectedTool == kFLToolFillType)
            {
                [sTerrainLayer fillWithTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition];
            }
            else if (mSelectedTool == kFLToolBrushType)
            {
                if ([sTerrainLayer setTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition])
                {
                    [mMapView setNeedsDisplayAtGridPosition:sGridPosition];
                }
            }
        }
    }
    else
    {
        if ([mSelectedTile isKindOfClass:[FLObjectTile class]])
        {
            FLObjectLayer *sObjectLayer = (FLObjectLayer *)mSelectedLayer;
            FLObject      *sObject      = [[[FLObject alloc] initWithObjectTile:(FLObjectTile *)mSelectedTile position:sGridPosition] autorelease];
            
            [sObjectLayer addObject:sObject];
            [mMapView setNeedsDisplayAtGridPosition:sGridPosition];
        }
    }
}


- (void)mapView:(FLMapView *)aMapView didMouseUpAtPoint:(NSPoint)aPoint
{

}


- (void)mapView:(FLMapView *)aMapView didMouseDragAtPoint:(NSPoint)aPoint
{
    NSPoint sGridPosition = FLGetGridPositionFromScreenPoint(mMap, aPoint);
    
    [self setTileLayerAtPosition:aPoint];
    
    if ([mSelectedLayer type] == kFLMapLayerTerrainType)
    {
        FLTerrainLayer *sTerrainLayer = (FLTerrainLayer *)mSelectedLayer;
        
        if (mSelectedTile)
        {
            if (mSelectedTool == kFLToolBrushType)
            {
                if ([sTerrainLayer setTile:(FLTerrainTile *)mSelectedTile atPosition:sGridPosition])
                {
                    [mMapView setNeedsDisplayAtGridPosition:sGridPosition];
                }
            }
        }
    }
    else
    {
    
    }
}


- (void)mapView:(FLMapView *)aMapView didMouseMoveAtPoint:(NSPoint)aPoint
{
//    NSLog(@"aPoint = %@", NSStringFromPoint(aPoint));
    
    NSPoint sGridPosition = FLGetGridPositionFromScreenPoint(mMap, aPoint);
    [mGridPositionLabel setStringValue:NSStringFromPoint(sGridPosition)];
    
    [self setTileLayerAtPosition:aPoint];
}


- (void)mapView:(FLMapView *)aMapView didMouseEnterAtPoint:(NSPoint)aPoint
{
    [self setTileLayerContents:[mSelectedTile image]];
    [self setTileLayerAtPosition:aPoint];
}


- (void)mapViewDidMouseExit:(FLMapView *)aMapView
{
    [self setTileLayerContents:nil];
}


#pragma mark -


- (void)viewBoundsDidChange:(NSNotification *)aNotification
{
    NSWindow *sWindow = [[[self windowControllers] objectAtIndex:0] window];
    NSPoint   sPoint  = [NSEvent mouseLocation];
    
    sPoint = [sWindow convertScreenToBase:sPoint];
    sPoint = [mMapView convertPoint:sPoint fromView:nil];

    [self setTileLayerAtPosition:sPoint];
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
