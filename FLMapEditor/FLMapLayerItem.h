/*
 *  FLMapLayerItem.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 10..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLMapLayerItem : NSCollectionViewItem


@property (nonatomic, assign) IBOutlet NSBox       *box;
@property (nonatomic, assign) IBOutlet NSTextField *nameField;


@end
