/*
 *  FLDocument.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLDocument.h"
#import "FLMapView.h"
#import "FLMap.h"


@implementation FLDocument
{
    /*  File New  */
    NSPanel      *mFileNewPanel;
    NSTextField  *mFileNewWidthTextField;
    NSTextField  *mFileNewHeightTextField;
    
    /*  Edit View  */
    NSScrollView *mScrollView;
    FLMapView    *mMapView;
    
    
    /*  Model  */
    FLMap        *mMap;
}


@synthesize fileNewPanel           = mFileNewPanel;
@synthesize fileNewWidthTextField  = mFileNewWidthTextField;
@synthesize fileNewHeightTextField = mFileNewHeightTextField;

@synthesize scrollView             = mScrollView;
@synthesize mapView                = mMapView;


#pragma mark -


- (void)openSheetInWindow:(NSWindow *)aWindow
{
    [NSApp beginSheet:mFileNewPanel modalForWindow:aWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
}


#pragma mark -


- (id)init
{
    self = [super init];
    
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


- (NSString *)windowNibName
{
    /*
     *  Override returning the nib file name of the document
     *  If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers,
     *  you should remove this method and override -makeWindowControllers instead.
     */
    
    return @"FLDocument";
}


- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    if (!mMap)
    {
        [self performSelector:@selector(openSheetInWindow:) withObject:[aController window] afterDelay:0.0];
    }
}


+ (BOOL)autosavesInPlace
{
    return YES;
}


- (NSData *)dataOfType:(NSString *)aTypeName error:(NSError **)aOutError
{
    NSData *sResult = nil;
    
    sResult = [mMap JSONDataRepresentation];

    return sResult;
}


- (BOOL)readFromData:(NSData *)aData ofType:(NSString *)aTypeName error:(NSError **)aOutError
{
    [mMap autorelease];
    mMap = [[FLMap alloc] initWithJSONData:aData];
    
    return YES;
}


#pragma mark -


- (IBAction)fileNewOkButtonClicked:(id)aSender
{
    NSString *sWidthStr  = ([[mFileNewWidthTextField stringValue] length] != 0)  ? [mFileNewWidthTextField stringValue]  : [[mFileNewWidthTextField cell] placeholderString];
    NSString *sHeightStr = ([[mFileNewHeightTextField stringValue] length] != 0) ? [mFileNewHeightTextField stringValue] : [[mFileNewHeightTextField cell] placeholderString];
    NSSize    sMapSize   = NSMakeSize([sWidthStr floatValue], [sHeightStr floatValue]);
    
    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
    
    [mMap autorelease];
    mMap = [[FLMap alloc] initWithSize:sMapSize];
}


- (IBAction)fileNewCancelButtonClicked:(id)aSender
{
    [NSApp endSheet:mFileNewPanel];
    [mFileNewPanel orderOut:aSender];
}


@end
