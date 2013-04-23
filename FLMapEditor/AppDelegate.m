/*
 *  AppDelegate.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "FLTerrainTileSetEditor.h"
#import "FLObjectTileSetEditor.h"


@implementation AppDelegate
{
    FLTerrainTileSetEditor *mTerrainTileSetEditor;
    FLObjectTileSetEditor  *mObjectTileSetEditor;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    
    [self terrainTileSetEditorSelected:self];
//    [self objectTileSetEditorSelected:self];
}


#pragma mark -
#pragma mark MenuItem Actions


- (IBAction)terrainTileSetEditorSelected:(id)aSender
{
    if (!mTerrainTileSetEditor)
    {
        mTerrainTileSetEditor = [[FLTerrainTileSetEditor alloc] initWithWindowNibName:@"FLTerrainTileSetEditor"];
    }
    
    [mTerrainTileSetEditor showWindow:self];
}


- (IBAction)objectTileSetEditorSelected:(id)aSender
{
    if (!mObjectTileSetEditor)
    {
        mObjectTileSetEditor = [[FLObjectTileSetEditor alloc] initWithWindowNibName:@"FLObjectTileSetEditor"];
    }
    
    [mObjectTileSetEditor showWindow:self];
}


@end
