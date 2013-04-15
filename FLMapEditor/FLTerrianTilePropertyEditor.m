/*
 *  FLTerrianTilePropertyEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 15..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrianTilePropertyEditor.h"
#import "FLTerrianTile.h"


@implementation FLTerrianTilePropertyEditor
{
    NSTextField *mIndexField;
    NSButton    *mPassableButton;
    NSImageView *mImageView;
    
    FLTerrianTile *mTerrianTile;
}


@synthesize indexField     = mIndexField;
@synthesize passableButton = mPassableButton;
@synthesize imageView      = mImageView;


#pragma mark -


- (void)update
{

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
    
    if (!mTerrianTile)
    {
        mTerrianTile = [[FLTerrianTile alloc] init];
    }
    
    [self update];
}


#pragma mark -


- (void)setTerrianTile:(FLTerrianTile *)aTerrianTile
{
    [mTerrianTile autorelease];
    mTerrianTile = [aTerrianTile retain];
    [self update];
}


- (void)setIndex:(NSUInteger)aIndex
{
    [mTerrianTile setIndex:aIndex];
    [self update];
}


#pragma mark -


- (IBAction)saveButtonClicked:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];
}


- (IBAction)cancelButtonClicked:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];
}


- (IBAction)loadImageButtonClicked:(id)aSender
{
    NSOpenPanel *sOpenPanel = [NSOpenPanel openPanel];
    
    [sOpenPanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
    [sOpenPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger aResult) {
        if (aResult == NSFileHandlingPanelOKButton)
        {
            NSData *sData = [NSData dataWithContentsOfURL:[[sOpenPanel URLs] objectAtIndex:0]];
            NSLog(@"sData = %@", sData);
        }
    }];
    
}


@end
