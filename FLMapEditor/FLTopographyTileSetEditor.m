/*
 *  FLTopographyTileSetEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTopographyTileSetEditor.h"
#import "FLTerrianTileSet.h"
#import "FLTerrianTile.h"
#import "FLTerrianTilePropertyEditor.h"


@implementation FLTopographyTileSetEditor
{
    NSCollectionView            *mTileView;
    
    /*  Property Editor  */
    FLTerrianTilePropertyEditor *mPropertyEditor;
    
    /*  Model  */
    FLTerrianTileSet            *mTileSet;
}


@synthesize tileView = mTileView;


#pragma mark -


- (id)initWithWindow:(NSWindow *)aWindow
{
    self = [super initWithWindow:aWindow];
    
    if (self)
    {
        mTileSet = [[FLTerrianTileSet alloc] init];
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
#pragma mark Actions


- (IBAction)addButtonClicked:(id)aSender
{
    FLTerrianTile *sTerrianTile = [mTileSet insertNewTerrianTile];
    
    if (!mPropertyEditor)
    {
        mPropertyEditor = [[FLTerrianTilePropertyEditor alloc] initWithWindowNibName:@"FLTerrianTilePropertyEditor"];
    }

    [mPropertyEditor setTerrianTile:sTerrianTile];
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


@end
