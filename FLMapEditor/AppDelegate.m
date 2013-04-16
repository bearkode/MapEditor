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
    FLTerrainTileSetEditor *mTerrainTileSetEditorWindowController;
    FLObjectTileSetEditor  *mObjectTileSetEditorWindowController;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    
    [self terrainTileSetEditorSelected:self];
}


#pragma mark -
#pragma mark MenuItem Actions


- (IBAction)terrainTileSetEditorSelected:(id)aSender
{
    if (!mTerrainTileSetEditorWindowController)
    {
        mTerrainTileSetEditorWindowController = [[FLTerrainTileSetEditor alloc] initWithWindowNibName:@"FLTerrainTileSetEditor"];
    }
    
    [mTerrainTileSetEditorWindowController showWindow:self];
}


- (IBAction)objectTileSetEditorSelected:(id)aSender
{
    if (!mObjectTileSetEditorWindowController)
    {
        mObjectTileSetEditorWindowController = [[FLObjectTileSetEditor alloc] initWithWindowNibName:@"FLObjectTileSetEditor"];
    }
    
    [mObjectTileSetEditorWindowController showWindow:self];
}


@end
