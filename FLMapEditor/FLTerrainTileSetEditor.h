/*
 *  FLTerrainTileSetEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLTerrainTileSetEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSCollectionView *tileView;
@property (nonatomic, assign) IBOutlet NSButton         *editButton;
@property (nonatomic, assign) IBOutlet NSButton         *deleteButton;


- (IBAction)addButtonClicked:(id)aSender;
- (IBAction)deleteButtonClicked:(id)aSender;
- (IBAction)editButtonClicked:(id)aSender;
- (IBAction)exportButtonClicked:(id)aSender;


@end
