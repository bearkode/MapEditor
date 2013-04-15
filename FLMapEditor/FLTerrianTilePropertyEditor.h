/*
 *  FLTerrianTilePropertyEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 15..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@class FLTerrianTile;


@interface FLTerrianTilePropertyEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSTextField *indexField;
@property (nonatomic, assign) IBOutlet NSButton    *passableButton;
@property (nonatomic, assign) IBOutlet NSImageView *imageView;


- (void)setTerrianTile:(FLTerrianTile *)aTerrianTile;
- (void)setIndex:(NSUInteger)aIndex;


@end
