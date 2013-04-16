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
    
    /*  Property Editor  */
    FLTerrainTilePropertyEditor *mPropertyEditor;
    
    /*  Model  */
    FLTerrainTileSet            *mTileSet;
}


@synthesize tileView = mTileView;


#pragma mark -


- (void)setupTileView
{
    [mTileView setContent:[[mTileSet arrayController] arrangedObjects]];
    [mTileView setItemPrototype:[[[FLTerrainTileItem alloc] init] autorelease]];
    [mTileView setMinItemSize:NSMakeSize(120, 120)];
    [mTileView setMaxItemSize:NSMakeSize(120, 120)];
    [mTileView bind:NSContentBinding toObject:mTileSet withKeyPath:@"arrayController.arrangedObjects" options:NULL];
    [mTileView addObserver:self forKeyPath:@"selectionIndexes" options:0 context:NULL];
    
//    [mTileView setSelectionIndexes:[NSIndexSet indexSetWithIndex:0]];
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


- (IBAction)editButtonClicked:(id)aSender
{

}


- (IBAction)exportButtonClicked:(id)aSender
{

}


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
            NSLog(@"selectionIndexes");
        }
    }
}



@end
