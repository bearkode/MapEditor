/*
 *  FLObjectTilePropertyEditor.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 23..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


typedef void (^FLPropertyEditorCallbackBlock)(id aObject);


@class FLObjectTile;


@interface FLObjectTilePropertyEditor : NSWindowController


@property (nonatomic, assign) IBOutlet NSTextField *objectIDField;
@property (nonatomic, assign) IBOutlet NSTextField *widthField;
@property (nonatomic, assign) IBOutlet NSTextField *heightField;
@property (nonatomic, assign) IBOutlet NSButton    *passableButton;
@property (nonatomic, assign) IBOutlet NSButton    *saveButton;


- (IBAction)widthStepperTapped:(id)aSender;
- (IBAction)heightStepperTapped:(id)aSender;
- (IBAction)loadImageButtonTapped:(id)aSender;
- (IBAction)cancelButtonTapped:(id)aSender;
- (IBAction)saveButtonTapped:(id)aSender;


- (void)setObjectTile:(FLObjectTile *)aObjectTile;
- (void)showWindowWithDoneBlock:(FLPropertyEditorCallbackBlock)aDoneBlock cancelBlock:(FLPropertyEditorCallbackBlock)aCancelBlock;


@end
