/*
 *  FLObjectTileItem.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 24..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLObjectTileItem : NSCollectionViewItem


@property (nonatomic, assign) IBOutlet NSBox       *box;
@property (nonatomic, assign) IBOutlet NSImageView *tileImageView;
@property (nonatomic, assign) IBOutlet NSTextField *objectIdLabel;
@property (nonatomic, assign) IBOutlet NSTextField *sizeLabel;


- (void)update;


@end
