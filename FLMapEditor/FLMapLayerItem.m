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
    NSTextField *mNameField;
    NSString    *mName;
}


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
    
    [NSBundle loadNibNamed:@"FLMapLayerItem" owner:sResult];
    
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
    NSBox *sBox = (NSBox *)[self view];
    
    [sBox setTitlePosition:NSNoTitle];
    [sBox setBoxType:NSBoxCustom];
    [sBox setCornerRadius:3.0];
    [sBox setBorderType:NSLineBorder];
    [sBox setContentViewMargins:NSMakeSize(1, 1)];
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

    NSBox   *sBox         = (NSBox *)[self view];
    NSColor *sFillColor   = (aSelected) ? [NSColor selectedControlColor] : [NSColor controlBackgroundColor];
    NSColor *sBorderColor = (aSelected) ? [NSColor blackColor] : [NSColor controlBackgroundColor];
    
    [sBox setBorderColor:sBorderColor];
    [sBox setFillColor:sFillColor];
}

@end
