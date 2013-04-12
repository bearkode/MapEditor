/*
 *  AppDelegate.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <AppKit/AppKit.h>


@interface AppDelegate : NSObject <NSApplicationDelegate>


//@property (nonatomic, assign) IBOutlet NSMenuItem *topographyEditorMenuItem;
//@property (nonatomic, assign) IBOutlet


- (IBAction)topographyTileSetEditorSelected:(id)aSender;
- (IBAction)objectTileSetEditorSelected:(id)aSender;


@end
