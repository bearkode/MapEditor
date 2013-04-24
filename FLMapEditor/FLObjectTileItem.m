/*
 *  FLObjectTileItem.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 24..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectTileItem.h"
#import "FLObjectTile.h"


@implementation FLObjectTileItem
{
    NSBox       *mBox;
    NSImageView *mTileImageView;
    NSTextField *mObjectIdLabel;
    NSTextField *mSizeLabel;
}


@synthesize box           = mBox;
@synthesize tileImageView = mTileImageView;
@synthesize objectIdLabel = mObjectIdLabel;
@synthesize sizeLabel     = mSizeLabel;


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
    
    [NSBundle loadNibNamed:@"FLObjectTileItem" owner:sResult];
    
    return sResult;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (void)awakeFromNib
{
    [mBox setTitlePosition:NSNoTitle];
    [mBox setBoxType:NSBoxCustom];
    [mBox setCornerRadius:3.0];
    [mBox setBorderType:NSLineBorder];
    [mBox setBorderWidth:1];
    [mBox setBorderColor:[NSColor grayColor]];
    [mBox setContentViewMargins:NSMakeSize(1, 1)];
}


- (void)setRepresentedObject:(id)aObject
{
    [super setRepresentedObject:aObject];
    [self update];
}


- (void)setSelected:(BOOL)aSelected
{
    [super setSelected:aSelected];
    
    if (aSelected)
    {
        [mBox setBorderWidth:2];
        [mBox setBorderColor:[NSColor redColor]];
    }
    else
    {
        [mBox setBorderWidth:1];
        [mBox setBorderColor:[NSColor grayColor]];
    }
}


#pragma mark -


- (void)update
{
    NSObject     *sObject = [self representedObject];
    FLObjectTile *sTile   = (FLObjectTile *)sObject;
    
    if (sTile)
    {
        [mTileImageView setImage:[sTile image]];
        [mObjectIdLabel setStringValue:[NSString stringWithFormat:@"ObjectID : %d", (int)[sTile objectId]]];
//        [mPassableButton setState:[sTile passable]];
    }
}


@end
