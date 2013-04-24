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


- (void)showPropertyEditorWithTile:(FLObjectTile *)aTile //collectionItem:(FLObjectTileItem *)aItem
{
    if (!mPropertyEditor)
    {
        mPropertyEditor = [[FLObjectTilePropertyEditor alloc] initWithWindowNibName:@"FLObjectTilePropertyEditor"];
    }
    
    [mPropertyEditor setObjectTile:aTile];
    [mPropertyEditor showWindowWithDoneBlock:^void (id aObject) {
//        [mTileSet save];
//        [aItem update];
    } cancelBlock:^void (id aObject) {
//        [mTileSet rollback];
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
    
    [super dealloc];
}


#pragma mark -


- (void)windowDidLoad
{
    [super windowDidLoad];
}


#pragma mark -


- (IBAction)addButtonClicked:(id)aSender
{
    NSLog(@"addButtonClicked:");

    FLObjectTile *sTile = (FLObjectTile *)[mTileSet insertNewTile];
    [self showPropertyEditorWithTile:sTile];// collectionItem:nil];
}


- (IBAction)deleteButtonClicked:(id)aSender
{
    NSLog(@"deleteButtonClicked:");
}


- (IBAction)editButtonClicked:(id)aSender
{
    NSLog(@"editButtonClicked:");
}


@end
