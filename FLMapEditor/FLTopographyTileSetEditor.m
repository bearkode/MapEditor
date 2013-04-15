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


@implementation FLTopographyTileSetEditor
{
    NSCollectionView *mTileView;
    
    FLTerrianTileSet *mTileSet;
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


- (IBAction)addImageButtonClicked:(id)aSender
{

}


- (IBAction)editPropertyButtonClicked:(id)aSender
{

}


- (IBAction)exportButtonClicked:(id)aSender
{

}


@end
