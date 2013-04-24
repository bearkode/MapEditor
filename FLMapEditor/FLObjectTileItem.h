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


@property (nonatomic, assign) IBOutlet NSTextField *objectIdLabel;


- (void)update;


@end
