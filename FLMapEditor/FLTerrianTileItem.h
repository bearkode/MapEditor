/*
 *  FLTerrianTileItem.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 16..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLTerrianTileItem : NSCollectionViewItem


@property (nonatomic, assign) IBOutlet NSImageView *tileImageView;
@property (nonatomic, assign) IBOutlet NSTextField *indexLabel;
@property (nonatomic, assign) IBOutlet NSButton    *passableButton;


@end
