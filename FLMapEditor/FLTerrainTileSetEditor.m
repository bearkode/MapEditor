/*
 *  FLTerrainTileSetEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTileSetEditor.h"
#import "FLTileSetManager.h"
#import "FLTerrainTileSet.h"
#import "FLTerrainTile.h"
#import "FLTerrainTileItem.h"
#import "FLTerrainTilePropertyEditor.h"


@implementation FLTerrainTileSetEditor
{
    NSCollectionView            *mTileView;
    NSButton                    *mDeleteButton;
    NSButton                    *mEditButton;
    
    /*  Property Editor  */
    FLTerrainTilePropertyEditor *mPropertyEditor;
    
    /*  Model  */
    FLTerrainTileSet            *mTileSet;
}


@synthesize tileView     = mTileView;
@synthesize editButton   = mEditButton;
@synthesize deleteButton = mDeleteButton;


#pragma mark -


- (void)setupTileView
{
    [mTileView setItemPrototype:[[[FLTerrainTileItem alloc] initWithNibName:@"FLTerrainTileItem" bundle:nil] autorelease]];
    [mTileView setContent:[mTileSet tiles]];
    [mTileView setMinItemSize:NSMakeSize(120, 120)];
    [mTileView setMaxItemSize:NSMakeSize(120, 120)];
    [mTileView bind:NSContentBinding toObject:mTileSet withKeyPath:@"tiles" options:NULL];
    [mTileView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
}


- (void)showPropertyEditorWithTerrainTile:(FLTerrainTile *)aTerrainTile collectionItem:(FLTerrainTileItem *)aItem
{
    if (!mPropertyEditor)
    {
        mPropertyEditor = [[FLTerrainTilePropertyEditor alloc] initWithWindowNibName:@"FLTerrainTilePropertyEditor"];
    }
    
    [mPropertyEditor setTerrainTile:aTerrainTile];
    [mPropertyEditor showWindowWithDoneBlock:^void (id aObject) {
        [mTileSet save];
        [aItem update];
    } cancelBlock:^void (id aObject) {
        [mTileSet rollback];
    }];
}


#pragma mark -


- (id)initWithWindow:(NSWindow *)aWindow
{
    self = [super initWithWindow:aWindow];
    
    if (self)
    {
        mTileSet = (FLTerrainTileSet *)[[[FLTileSetManager sharedManager] terrainTileSet] retain];
    }
    
    return self;
}


- (void)dealloc
{
    [mTileSet release];
    [mTileView removeObserver:self forKeyPath:@"selectionIndexes"];
    [mPropertyEditor release];
    
    [super dealloc];
}


#pragma mark -


- (void)windowDidLoad
{
    [super windowDidLoad];

    [self setupTileView];
    [self tileViewSelectionDidChange];
}


#pragma mark -
#pragma mark Actions


- (IBAction)addButtonClicked:(id)aSender
{
    FLTerrainTile *sTerrainTile = (FLTerrainTile *)[mTileSet insertNewTile];
    [self showPropertyEditorWithTerrainTile:sTerrainTile collectionItem:nil];
}


- (IBAction)deleteButtonClicked:(id)aSender
{
    NSInteger sIndex = [[mTileView selectionIndexes] firstIndex];
    
    [mTileSet deleteTileAtIndex:sIndex];
    [mTileSet save];
}


- (IBAction)editButtonClicked:(id)aSender
{
    NSIndexSet        *sIndexSet        = [mTileView selectionIndexes];
    NSInteger          sIndex           = [sIndexSet firstIndex];
    FLTerrainTile     *sTerrainTile     = (FLTerrainTile *)[mTileSet tileAtIndex:sIndex];
    FLTerrainTileItem *sTerrainTileItem = (FLTerrainTileItem *)[mTileView itemAtIndex:sIndex];
    
    [self showPropertyEditorWithTerrainTile:sTerrainTile collectionItem:sTerrainTileItem];
}


- (IBAction)exportButtonClicked:(id)aSender
{

}


#pragma mark -


- (void)tileViewSelectionDidChange
{
    NSIndexSet *sIndexSet = [mTileView selectionIndexes];
    
    [mDeleteButton setEnabled:([sIndexSet count] > 0)];
    [mEditButton setEnabled:([sIndexSet count] > 0)];
}


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext
{
//    NSLog(@"observeValueForKeyPath:ofObject:change:context");
//    NSLog(@"aKeyPath = %@", aKeyPath);
//    NSLog(@"aObject  = %@", aObject);
//    NSLog(@"aChange  = %@", aChange);
//    NSLog(@"aContext = %p", aContext);
    
    if (aObject == mTileView)
    {
        if ([aKeyPath isEqualToString:@"selectionIndexes"])
        {
            [self tileViewSelectionDidChange];
        }
    }
}



@end
