/*
 *  FLTopographyTileSetEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLTopographyTileSetEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSCollectionView *tileView;


- (IBAction)addImageButtonClicked:(id)aSender;
- (IBAction)editPropertyButtonClicked:(id)aSender;
- (IBAction)exportButtonClicked:(id)aSender;


@end