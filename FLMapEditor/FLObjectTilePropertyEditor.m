/*
 *  FLObjectTilePropertyEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 23..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectTilePropertyEditor.h"
#import "FLObjectTile.h"
#import "NSTextField+Additions.h"


@implementation FLObjectTilePropertyEditor
{
    NSTextField                  *mObjectIDField;

    NSTextField                  *mWidthField;
    NSStepper                    *mWidthStepper;
    NSTextField                  *mHeightField;
    NSStepper                    *mHeightStepper;
    
    NSButton                     *mPassableButton;
    
    NSImageView                  *mImageView;
    
    NSButton                     *mSaveButton;
    
    FLObjectTile                 *mObjectTile;
    FLPropertyEditorCallbackBlock mDoneBlock;
    FLPropertyEditorCallbackBlock mCancelBlock;
}


@synthesize objectIDField  = mObjectIDField;
@synthesize widthField     = mWidthField;
@synthesize widthStepper   = mWidthStepper;
@synthesize heightField    = mHeightField;
@synthesize heightStepper  = mHeightStepper;
@synthesize passableButton = mPassableButton;
@synthesize imageView      = mImageView;
@synthesize saveButton     = mSaveButton;


#pragma mark -


- (void)update
{
    NSImage *sImage = [mObjectTile image];
    
    [mImageView setImage:sImage];
    [mObjectIDField setStringValue:[NSString stringWithFormat:@"%d", (int)[mObjectTile objectId]]];
    [mWidthField setStringValue:[NSString stringWithFormat:@"%d", (int)[mObjectTile width]]];
    [mHeightField setStringValue:[NSString stringWithFormat:@"%d", (int)[mObjectTile height]]];
    [mPassableButton setState:([mObjectTile passable]) ? NSOnState : NSOffState];
    
    if ([mObjectTile imageData] && [mObjectTile width] != 0 && [mObjectTile height] != 0 && [mObjectTile objectId] != 0)
    {
        [mSaveButton setEnabled:YES];
    }
    else
    {
        [mSaveButton setEnabled:NO];
    }
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
    [mObjectTile release];
    
    [mDoneBlock release];
    [mCancelBlock release];
    
    [super dealloc];
}


#pragma mark -


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [mWidthStepper setIntegerValue:1];
    [mHeightStepper setIntegerValue:1];
    
    [mSaveButton setEnabled:NO];
}


#pragma mark -


- (IBAction)widthStepperTapped:(id)aSender
{
    NSStepper *sStepper = (NSStepper *)aSender;
    NSInteger  sValue   = [sStepper integerValue];
    
    [mObjectTile setWidth:sValue];
    [self update];
}


- (IBAction)heightStepperTapped:(id)aSender
{
    NSStepper *sStepper = (NSStepper *)aSender;
    NSInteger  sValue   = [sStepper integerValue];
    
    [mObjectTile setHeight:sValue];
    [self update];
}


- (IBAction)loadImageButtonTapped:(id)aSender
{
    NSOpenPanel *sOpenPanel = [NSOpenPanel openPanel];
    
    [sOpenPanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
    [sOpenPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger aResult) {
        if (aResult == NSFileHandlingPanelOKButton)
        {
            NSData *sData = [NSData dataWithContentsOfURL:[[sOpenPanel URLs] objectAtIndex:0]];
            [mObjectTile setImageData:sData];
            [self update];
        }
    }];
}


- (IBAction)cancelButtonTapped:(id)aSender
{
    [NSApp abortModal];
    [[self window] orderOut:aSender];

    if (mCancelBlock)
    {
        mCancelBlock(mObjectTile);
    }
}


- (IBAction)saveButtonTapped:(id)aSender
{
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


#pragma mark -


- (BOOL)control:(NSControl *)aControl textShouldEndEditing:(NSText *)aFieldEditor
{
    NSInteger sValue = [(NSTextField *)aControl integer];

    if (aControl == mObjectIDField)
    {
        [mObjectTile setObjectId:sValue];
    }
    else if (aControl == mWidthField)
    {
        [mObjectTile setWidth:sValue];
        [mWidthStepper setIntegerValue:sValue];
    }
    else if (aControl == mHeightField)
    {
        [mObjectTile setHeight:sValue];
        [mHeightStepper setIntegerValue:sValue];
    }
    
    [self update];
    
    return YES;
}


@end
