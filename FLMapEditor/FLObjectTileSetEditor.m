/*
 *  FLObjectTileSetEditor.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectTileSetEditor.h"


@implementation FLObjectTileSetEditor
{
    NSCollectionView *mTileView;
    NSButton         *mEditButton;
    NSButton         *mDeleteButton;
}


@synthesize tileView     = mTileView;
@synthesize editButton   = mEditButton;
@synthesize deleteButton = mDeleteButton;


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


- (IBAction)addButtonClicked:(id)aSender
{
    NSLog(@"addButtonClicked:");
}


- (IBAction)deleteButtonClicked:(id)aSender
{
    NSLog(@"deleteButtonClicked:");
}


- (IBAction)editButtonClicked:(id)aSender
{
    NSLog(@"editButtonClicked:");
}


@end
