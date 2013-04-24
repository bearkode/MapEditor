/*
 *  FLObjectTileSetEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectTileSetEditor.h"
#import "FLObjectTilePropertyEditor.h"
#import "FLObjectTile.h"
#import "FLObjectTileItem.h"
#import "FLObjectTileSet.h"
#import "FLTileSetManager.h"


@implementation FLObjectTileSetEditor
{
    NSCollectionView           *mTileView;
    NSButton                   *mEditButton;
    NSButton                   *mDeleteButton;
    
    FLObjectTilePropertyEditor *mPropertyEditor;
    
    FLObjectTileSet            *mTileSet;
}


@synthesize tileView     = mTileView;
@synthesize editButton   = mEditButton;
@synthesize deleteButton = mDeleteButton;


#pragma mark -


- (void)setupTileView
{
    [mTileView setItemPrototype:[[[FLObjectTileItem alloc] initWithNibName:@"FLTerrainTileItem" bundle:nil] autorelease]];
    [mTileView setContent:[mTileSet tiles]];
    [mTileView setMinItemSize:NSMakeSize(120, 120)];
    [mTileView setMaxItemSize:NSMakeSize(120, 120)];
    [mTileView bind:NSContentBinding toObject:mTileSet withKeyPath:@"tiles" options:NULL];
    [mTileView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
}


- (void)tileViewSelectionDidChange
{
    NSIndexSet *sIndexSet = [mTileView selectionIndexes];
    
    [mDeleteButton setEnabled:([sIndexSet count] > 0)];
    [mEditButton setEnabled:([sIndexSet count] > 0)];
}


- (void)showPropertyEditorWithTile:(FLObjectTile *)aTile collectionItem:(FLObjectTileItem *)aItem
{
    if (!mPropertyEditor)
    {
        mPropertyEditor = [[FLObjectTilePropertyEditor alloc] initWithWindowNibName:@"FLObjectTilePropertyEditor"];
    }
    
    [mPropertyEditor setObjectTile:aTile];
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
        mTileSet = (FLObjectTileSet *)[[[FLTileSetManager sharedManager] objectTileSet] retain];
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


- (IBAction)addButtonClicked:(id)aSender
{
    NSLog(@"addButtonClicked:");

    FLObjectTile *sTile = (FLObjectTile *)[mTileSet insertNewTile];
    [self showPropertyEditorWithTile:sTile collectionItem:nil];
}


- (IBAction)deleteButtonClicked:(id)aSender
{
    NSLog(@"deleteButtonClicked:");
}


- (IBAction)editButtonClicked:(id)aSender
{
    NSLog(@"editButtonClicked:");
}


#pragma mark -


#pragma mark -


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
