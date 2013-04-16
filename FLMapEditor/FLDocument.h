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


/*  Edit  */
@property (nonatomic, assign) IBOutlet NSScrollView     *scrollView;
@property (nonatomic, assign) IBOutlet NSView           *mapView;

/*  Info  */
@property (nonatomic, assign) IBOutlet NSTextField      *mapSizeLabel;
@property (nonatomic, assign) IBOutlet NSTextField      *tileSizeLabel;

/*  Layer  */
@property (nonatomic, assign) IBOutlet NSCollectionView *layerCollectionView;

/*  TileSet  */
@property (nonatomic, assign) IBOutlet NSCollectionView *tileSetCollectionView;


#pragma mark -


/*  Layer  */
- (IBAction)addLayer:(id)aSender;
- (IBAction)removeLayer:(id)aSender;

/*  Tile Set  */
- (IBAction)loadTileSetButtonClicked:(id)aSender;


@end
