/*
 *  FLObjectTilePropertyEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 23..
 *  Copyright (c) 2013년 cgkim. All rights reserved.
 *
 */

#import "FLObjectTilePropertyEditor.h"
#import "FLObjectTile.h"


@implementation FLObjectTilePropertyEditor
{
    NSTextField                  *mObjectIDField;
    NSTextField                  *mWidthField;
    NSTextField                  *mHeightField;
    NSButton                     *mPassableButton;
    NSButton                     *mSaveButton;
    
    FLObjectTile                 *mObjectTile;
    FLPropertyEditorCallbackBlock mDoneBlock;
    FLPropertyEditorCallbackBlock mCancelBlock;
}


@synthesize objectIDField  = mObjectIDField;
@synthesize widthField     = mWidthField;
@synthesize heightField    = mHeightField;
@synthesize passableButton = mPassableButton;
@synthesize saveButton     = mSaveButton;


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
    [super dealloc];
}


#pragma mark -


- (void)windowDidLoad
{
    [super windowDidLoad];
}


#pragma mark -


- (IBAction)widthStepperTapped:(id)aSender
{
    NSLog(@"widthStepperTapped:");
}


- (IBAction)heightStepperTapped:(id)aSender
{
    NSLog(@"heightStepperTapped:");
}


- (IBAction)loadImageButtonTapped:(id)aSender
{
    NSLog(@"loadImageButtonTapped:");
}


- (IBAction)cancelButtonTapped:(id)aSender
{
    NSLog(@"cancelButtonTapped:");

    [NSApp abortModal];
    [[self window] orderOut:aSender];

    if (mCancelBlock)
    {
        mCancelBlock(mObjectTile);
    }
}


- (IBAction)saveButtonTapped:(id)aSender
{
    NSLog(@"saveButtonTapped:");

    [NSApp abortModal];
    [[self window] orderOut:aSender];

    if (mDoneBlock)
    {
        mDoneBlock(mObjectTile);
    }
}


#pragma mark -


- (void)setObjectTile:(FLObjectTile *)aObjectTile
{
    [mObjectTile autorelease];
    mObjectTile = [aObjectTile retain];
    
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


@end
