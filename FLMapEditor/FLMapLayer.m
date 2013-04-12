/*
 *  FLMapLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"


static NSString *const kTypeKey = @"Type";
static NSString *const kNameKey = @"Name";


@implementation FLMapLayer
{
    FLMapLayerType mType;
    NSString      *mName;
    FLTileSet     *mTileSet;
}


@synthesize type    = mType;
@synthesize name    = mName;
@synthesize tileSet = mTileSet;


#pragma mark -


- (id)initWithType:(FLMapLayerType)aType
{
    self = [super init];
    
    if (self)
    {
        mType = aType;
    }
    
    return self;
}


- (id)initWithJSONObject:(NSDictionary *)aDict
{
    self = [super init];
    
    if (self)
    {
        mType = (FLMapLayerType)[[aDict objectForKey:kTypeKey] integerValue];
        mName = [[aDict objectForKey:kNameKey] retain];
    }
    
    return self;
}


- (void)dealloc
{
    [mName release];
    
    [super dealloc];
}


#pragma mark -


- (NSDictionary *)JSONObject
{
    NSMutableDictionary *sResult = [NSMutableDictionary dictionary];
    
    [sResult setObject:[NSNumber numberWithInteger:mType] forKey:kTypeKey];
    [sResult setObject:mName forKey:kNameKey];
    
    return sResult;
}


@end
