/*
 *  FLTerrainTileItem.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 16..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTileItem.h"
#import "FLTerrainTile.h"


@implementation FLTerrainTileItem
{
    NSImageView *mTileImageView;
    NSTextField *mIndexLabel;
    NSButton    *mPassableButton;
}


@synthesize tileImageView  = mTileImageView;
@synthesize indexLabel     = mIndexLabel;
@synthesize passableButton = mPassableButton;


#pragma mark -


- (id)initWithNibName:(NSString *)aNibNameOrNil bundle:(NSBundle *)aNibBundleOrNil
{
    self = [super initWithNibName:aNibNameOrNil bundle:aNibBundleOrNil];

    if (self)
    {

    }
    
    return self;
}


- (id)copyWithZone:(NSZone *)aZone
{
    id sResult = [super copyWithZone:aZone];
    
    [NSBundle loadNibNamed:@"FLTerrainTileItem" owner:sResult];
    
//    NSColor *sFillColor   = [NSColor controlBackgroundColor];
//    NSColor *sBorderColor = [NSColor controlBackgroundColor];
//    
//    [mBox setBorderColor:sBorderColor];
//    [mBox setFillColor:sFillColor];
    
    return sResult;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (void)setRepresentedObject:(id)aObject
{
    [super setRepresentedObject:aObject];

    FLTerrainTile *sTile = (FLTerrainTile *)aObject;
    
    if (sTile)
    {
        NSImage *sImage = [[[NSImage alloc] initWithData:[sTile imageData]] autorelease];
        
        [mTileImageView setImage:sImage];
        [mIndexLabel setStringValue:[NSString stringWithFormat:@"Index : %d", (int)[sTile index]]];
        [mPassableButton setState:[sTile passable]];
    }
}


@end
