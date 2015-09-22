/*
 *  FLMapLayerItem.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 10..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayerItem.h"
#import "FLMapLayer.h"


@implementation FLMapLayerItem
{
    NSBox       *mBox;
    NSTextField *mNameField;
    
    NSString    *mName;
}


@synthesize box       = mBox;
@synthesize nameField = mNameField;


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
    
    [[NSBundle mainBundle] loadNibNamed:@"FLMapLayerItem" owner:self topLevelObjects:nil];
    
    NSColor *sFillColor   = [NSColor controlBackgroundColor];
    NSColor *sBorderColor = [NSColor controlBackgroundColor];
    
    [mBox setBorderColor:sBorderColor];
    [mBox setFillColor:sFillColor];
    
    return sResult;
}


- (void)dealloc
{
    [mName release];
    
    [super dealloc];
}


#pragma mark -


- (void)awakeFromNib
{
    [mBox setTitlePosition:NSNoTitle];
    [mBox setBoxType:NSBoxCustom];
    [mBox setCornerRadius:3.0];
    [mBox setBorderType:NSLineBorder];
    [mBox setContentViewMargins:NSMakeSize(1, 1)];
}


- (void)setRepresentedObject:(id)aObject
{
    [super setRepresentedObject:aObject];
    
    if (aObject)
    {
        NSString *sName = [(FLMapLayer *)aObject name];
    
        if (sName)
        {
            [mNameField setStringValue:sName];
        }
    }
}


- (void)setSelected:(BOOL)aSelected
{
    [super setSelected:aSelected];

    NSColor *sFillColor   = (aSelected) ? [NSColor selectedControlColor] : [NSColor controlBackgroundColor];
    NSColor *sBorderColor = (aSelected) ? [NSColor grayColor] : [NSColor controlBackgroundColor];
    
    [mBox setBorderColor:sBorderColor];
    [mBox setFillColor:sFillColor];
}


@end
