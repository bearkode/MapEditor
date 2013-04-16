/*
 *  FLTerrainTileSetEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTileSetEditor.h"
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
    [mTileView setContent:[[mTileSet arrayController] arrangedObjects]];
    [mTileView setItemPrototype:[[[FLTerrainTileItem alloc] init] autorelease]];
    [mTileView setMinItemSize:NSMakeSize(120, 120)];
    [mTileView setMaxItemSize:NSMakeSize(120, 120)];
    [mTileView bind:NSContentBinding toObject:mTileSet withKeyPath:@"arrayController.arrangedObjects" options:NULL];
    [mTileView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
}


#pragma mark -


- (id)initWithWindow:(NSWindow *)aWindow
{
    self = [super initWithWindow:aWindow];
    
    if (self)
    {
        mTileSet = [[FLTerrainTileSet alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [mTileSet release];
    [mTileView removeObserver:self forKeyPath:@"selectionIndexes"];
    
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
    FLTerrainTile *sTerrainTile = [mTileSet insertNewTerrainTile];
    
    if (!mPropertyEditor)
    {
        mPropertyEditor = [[FLTerrainTilePropertyEditor alloc] initWithWindowNibName:@"FLTerrainTilePropertyEditor"];
    }

    [mPropertyEditor setTerrainTile:sTerrainTile];
    [mPropertyEditor showWindowWithDoneBlock:^void (id aObject) {
        [mTileSet save];
    } cancelBlock:^void (id aObject) {
        [mTileSet rollback];
    }];
}


- (IBAction)deleteButtonClicked:(id)aSender
{
    NSInteger sIndex = [[mTileView selectionIndexes] firstIndex];
    
    [mTileSet deleteTerrainTileAtIndex:sIndex];
    [mTileSet save];
}


- (IBAction)editButtonClicked:(id)aSender
{

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
    
    NSLog(@"selectionIndexes - %@", sIndexSet);
}


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext
{
    NSLog(@"observeValueForKeyPath:ofObject:change:context");
    NSLog(@"aKeyPath = %@", aKeyPath);
    NSLog(@"aObject  = %@", aObject);
    NSLog(@"aChange  = %@", aChange);
    NSLog(@"aContext = %p", aContext);
    
    if (aObject == mTileView)
    {
        if ([aKeyPath isEqualToString:@"selectionIndexes"])
        {
            [self tileViewSelectionDidChange];
        }
    }
}



@end
