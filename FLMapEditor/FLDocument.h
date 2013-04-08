/*
 *  FLDocument.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLDocument : NSDocument


@property (nonatomic, assign) IBOutlet NSPanel      *fileNewPanel;
@property (nonatomic, assign) IBOutlet NSTextField  *fileNewWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField  *fileNewHeightTextField;

@property (nonatomic, assign) IBOutlet NSScrollView *scrollView;
@property (nonatomic, assign) IBOutlet NSView       *mapView;


- (IBAction)fileNewOkButtonClicked:(id)aSender;
- (IBAction)fileNewCancelButtonClicked:(id)aSender;


@end
