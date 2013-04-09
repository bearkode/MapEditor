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


/*  New Map  */
@property (nonatomic, assign) IBOutlet NSPanel      *fileNewPanel;
@property (nonatomic, assign) IBOutlet NSTextField  *mapWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField  *mapHeightTextField;
@property (nonatomic, assign) IBOutlet NSTextField  *tileWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField  *tileHeightTextField;

/*  Info  */
@property (nonatomic, assign) IBOutlet NSTextField  *mapSizeLabel;
@property (nonatomic, assign) IBOutlet NSTextField  *tileSizeLabel;


/*  Edit  */
@property (nonatomic, assign) IBOutlet NSScrollView *scrollView;
@property (nonatomic, assign) IBOutlet NSView       *mapView;


- (IBAction)fileNewOkButtonClicked:(id)aSender;
- (IBAction)fileNewCancelButtonClicked:(id)aSender;


@end
