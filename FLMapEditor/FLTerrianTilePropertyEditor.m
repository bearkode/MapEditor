/*
 *  FLTerrianTilePropertyEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 15..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrianTilePropertyEditor.h"
#import "FLTerrainTile.h"


@implementation FLTerrianTilePropertyEditor
{
    NSTextField                  *mIndexField;
    NSButton                     *mPassableButton;
    NSImageView                  *mImageView;
    
    FLTerrainTile                *mTerrianTile;
    FLPropertyEditorCallbackBlock mDoneBlock;
    FLPropertyEditorCallbackBlock mCancelBlock;
}


@synthesize indexField     = mIndexField;
@synthesize passableButton = mPassableButton;
@synthesize imageView      = mImageView;


#pragma mark -


- (void)update
{
    [mIndexField setStringValue:[NSString stringWithFormat:@"%d", (int)[mTerrianTile index] + 1]];
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
    [mTerrianTile release];
    
    [super dealloc];
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [mIndexField setEditable:NO];
    [self update];
}


#pragma mark -


- (void)setTerrianTile:(FLTerrainTile *)aTerrianTile
{
    [mTerrianTile autorelease];
    mTerrianTile = [aTerrianTile retain];
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
    
    [mTerrianTile setPassable:([mPassableButton state] == NSOnState)];

    if (mDoneBlock)
    {
        mDoneBlock(mTerrianTile);
    }
}


- (IBAction)cancelButtonClicked:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];
    
    if (mCancelBlock)
    {
        mCancelBlock(mTerrianTile);
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
            [mTerrianTile setImageData:sData];
        }
    }];
    
}


@end
