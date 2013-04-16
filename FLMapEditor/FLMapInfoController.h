/*
 *  FLMapInfoController.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 16..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@interface FLMapInfoController : NSWindowController


@property (nonatomic, assign) IBOutlet NSTextField *mapWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField *mapHeightTextField;
@property (nonatomic, assign) IBOutlet NSTextField *tileWidthTextField;
@property (nonatomic, assign) IBOutlet NSTextField *tileHeightTextField;


- (IBAction)okButtonClicked:(id)aSender;
- (IBAction)cancelButtonClicked:(id)aSender;


- (NSSize)mapSize;
- (NSSize)tileSize;


@end
