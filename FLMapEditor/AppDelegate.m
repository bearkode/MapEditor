/*
 *  AppDelegate.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "AppDelegate.h"
#import "FLTopographyTileSetEditor.h"
#import "FLObjectTileSetEditor.h"


@implementation AppDelegate
{
    FLTopographyTileSetEditor *mTopographyTileSetEditorWindowController;
    FLObjectTileSetEditor     *mObjectTileSetEditorWindowController;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    
    [self topographyTileSetEditorSelected:self];
}


#pragma mark -
#pragma mark MenuItem Actions


- (IBAction)topographyTileSetEditorSelected:(id)aSender
{
    if (!mTopographyTileSetEditorWindowController)
    {
        mTopographyTileSetEditorWindowController = [[FLTopographyTileSetEditor alloc] initWithWindowNibName:@"FLTopographyTileSetEditor"];
    }
    
    [mTopographyTileSetEditorWindowController showWindow:self];
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
