/*
 *  AppDelegate.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "FLTerrianTileSetEditor.h"
#import "FLObjectTileSetEditor.h"


@implementation AppDelegate
{
    FLTerrianTileSetEditor *mTerrianTileSetEditorWindowController;
    FLObjectTileSetEditor  *mObjectTileSetEditorWindowController;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    
    [self terrianTileSetEditorSelected:self];
}


#pragma mark -
#pragma mark MenuItem Actions


- (IBAction)terrianTileSetEditorSelected:(id)aSender
{
    if (!mTerrianTileSetEditorWindowController)
    {
        mTerrianTileSetEditorWindowController = [[FLTerrianTileSetEditor alloc] initWithWindowNibName:@"FLTerrianTileSetEditor"];
    }
    
    [mTerrianTileSetEditorWindowController showWindow:self];
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
