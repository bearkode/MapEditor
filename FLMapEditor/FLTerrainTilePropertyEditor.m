/*
 *  FLTerrainTilePropertyEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 15..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTilePropertyEditor.h"
#import "FLTerrainTile.h"


@implementation FLTerrainTilePropertyEditor
{
    NSTextField                  *mIndexField;
    NSButton                     *mPassableButton;
    NSImageView                  *mImageView;
    
    FLTerrainTile                *mTerrainTile;
    FLPropertyEditorCallbackBlock mDoneBlock;
    FLPropertyEditorCallbackBlock mCancelBlock;
}


@synthesize indexField     = mIndexField;
@synthesize passableButton = mPassableButton;
@synthesize imageView      = mImageView;


#pragma mark -


- (void)update
{
    [mIndexField setStringValue:[NSString stringWithFormat:@"%d", (int)[mTerrainTile index] + 1]];
}


#pragma mark -


- (id)initWithWindow:(NSWindow *)aWindow
{
    self = [super initWithWindow:aWindow];

    if (self)
    {

    }
    
    return self;
}


- (void)dealloc
{
    [mTerrainTile release];
    
    [super dealloc];
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [mIndexField setEditable:NO];
    [self update];
}


#pragma mark -


- (void)setTerrainTile:(FLTerrainTile *)aTerrainTile
{
    [mTerrainTile autorelease];
    mTerrainTile = [aTerrainTile retain];
    [self update];
}


- (void)showWindowWithDoneBlock:(FLPropertyEditorCallbackBlock)aDoneBlock cancelBlock:(FLPropertyEditorCallbackBlock)aCancelBlock
{
    [mDoneBlock release];
    mDoneBlock = [aDoneBlock copy];
    
    [mCancelBlock release];
    mCancelBlock = [aCancelBlock copy];
    
    [NSApp runModalForWindow:[self window]];
}


#pragma mark -


- (IBAction)saveButtonClicked:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];
    
    [mTerrainTile setPassable:([mPassableButton state] == NSOnState)];

    if (mDoneBlock)
    {
        mDoneBlock(mTerrainTile);
    }
}


- (IBAction)cancelButtonClicked:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];
    
    if (mCancelBlock)
    {
        mCancelBlock(mTerrainTile);
    }
}


- (IBAction)loadImageButtonClicked:(id)aSender
{
    NSOpenPanel *sOpenPanel = [NSOpenPanel openPanel];
    
    [sOpenPanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
    [sOpenPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger aResult) {
        if (aResult == NSFileHandlingPanelOKButton)
        {
            NSData  *sData  = [NSData dataWithContentsOfURL:[[sOpenPanel URLs] objectAtIndex:0]];
            NSImage *sImage = [[[NSImage alloc] initWithData:sData] autorelease];
            
            [mImageView setImage:sImage];
            [mTerrainTile setImageData:sData];
        }
    }];
    
}


@end