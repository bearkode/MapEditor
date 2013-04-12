/*
 *  AppDelegate.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "FLTopographyTileSetEditorWindowController.h"
#import "FLObjectTileSetEditorWindowController.h"


@implementation AppDelegate
{
    FLTopographyTileSetEditorWindowController *mTopographyTileSetEditorWindowController;
    FLObjectTileSetEditorWindowController     *mObjectTileSetEditorWindowController;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
}


#pragma mark -
#pragma mark MenuItem Actions


- (IBAction)topographyTileSetEditorSelected:(id)aSender
{
    if (!mTopographyTileSetEditorWindowController)
    {
        mTopographyTileSetEditorWindowController = [[FLTopographyTileSetEditorWindowController alloc] initWithWindowNibName:@"FLTopographyTileSetEditorWindowController"];
    }
    
    [mTopographyTileSetEditorWindowController showWindow:self];
}


- (IBAction)objectTileSetEditorSelected:(id)aSender
{
    if (!mObjectTileSetEditorWindowController)
    {
        mObjectTileSetEditorWindowController = [[FLObjectTileSetEditorWindowController alloc] initWithWindowNibName:@"FLObjectTileSetEditorWindowController"];
    }
    
    [mObjectTileSetEditorWindowController showWindow:self];
}


@end
