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
    NSTextField *mObjectIdLabel;
}


@synthesize objectIdLabel = mObjectIdLabel;


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


- (void)setRepresentedObject:(id)aObject
{
    [super setRepresentedObject:aObject];
    [self update];
}


- (void)update
{
    NSObject     *sObject = [self representedObject];
    FLObjectTile *sTile   = (FLObjectTile *)sObject;
    
    if (sTile)
    {
//        NSImage *sImage = [[[NSImage alloc] initWithData:[sTile imageData]] autorelease];
        
//        [mTileImageView setImage:sImage];
        [mObjectIdLabel setStringValue:[NSString stringWithFormat:@"ObjectID : %d", (int)[sTile objectId]]];
//        [mPassableButton setState:[sTile passable]];
    }
}


@end
