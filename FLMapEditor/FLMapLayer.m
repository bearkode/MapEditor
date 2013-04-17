/*
 *  FLMapLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"
#import "FLTileSetManager.h"


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


- (void)setupTileSet
{
    [mTileSet autorelease];

    if (mType == kFLMapLayerTerrainType)
    {
        mTileSet = [[[FLTileSetManager sharedManager] terrainTileSet] retain];
    }
    else if (mType == kFLMapLayerObjectType)
    {
        mTileSet = [[[FLTileSetManager sharedManager] objectTileSet] retain];
    }
}



#pragma mark -


- (id)init
{
    NSAssert(NO, @"");
    
    return nil;
}



- (id)initWithType:(FLMapLayerType)aType
{
    self = [super init];
    
    if (self)
    {
        mType = aType;
        
        [self setupTileSet];
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
        
        [self setupTileSet];
    }
    
    return self;
}


- (void)dealloc
{
    [mName release];
    [mTileSet release];
    
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
