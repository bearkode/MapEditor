/*
 *  FLTerrainTilePropertyEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 15..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


typedef void (^FLPropertyEditorCallbackBlock)(id aObject);


@class FLTerrainTile;


@interface FLTerrainTilePropertyEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSTextField *indexField;
@property (nonatomic, assign) IBOutlet NSButton    *passableButton;
@property (nonatomic, assign) IBOutlet NSImageView *imageView;


- (void)setTerrainTile:(FLTerrainTile *)aTerrainTile;
- (void)showWindowWithDoneBlock:(FLPropertyEditorCallbackBlock)aDoneBlock cancelBlock:(FLPropertyEditorCallbackBlock)aCancelBlock;


@end
