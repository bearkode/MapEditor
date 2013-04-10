/*
 *  FLDocument.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>
#import "FLMapView.h"


@interface FLDocument : NSDocument <FLMapViewProtocol>


/*  New Map  */
@property (nonatomic, assign) IBOutlet NSPanel          *fileNewPanel;
@property (nonatomic, assign) IBOutlet NSTextField      *mapWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField      *mapHeightTextField;
@property (nonatomic, assign) IBOutlet NSTextField      *tileWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField      *tileHeightTextField;

/*  Edit  */
@property (nonatomic, assign) IBOutlet NSScrollView     *scrollView;
@property (nonatomic, assign) IBOutlet NSView           *mapView;

/*  Info  */
@property (nonatomic, assign) IBOutlet NSTextField      *mapSizeLabel;
@property (nonatomic, assign) IBOutlet NSTextField      *tileSizeLabel;

/*  Layer  */
@property (nonatomic, assign) IBOutlet NSCollectionView *layerCollectionView;
@property (nonatomic, retain)          NSMutableArray   *layerArray;


#pragma mark -


/*  New Map  */
- (IBAction)fileNewOkButtonClicked:(id)aSender;
- (IBAction)fileNewCancelButtonClicked:(id)aSender;

/*  Layer  */
- (IBAction)addLayer:(id)aSender;
- (IBAction)removeLayer:(id)aSender;


@end
