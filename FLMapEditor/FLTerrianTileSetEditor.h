/*
 *  FLTerrianTileSetEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLTerrianTileSetEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSCollectionView *tileView;


- (IBAction)addButtonClicked:(id)aSender;
- (IBAction)editButtonClicked:(id)aSender;
- (IBAction)exportButtonClicked:(id)aSender;


@end
