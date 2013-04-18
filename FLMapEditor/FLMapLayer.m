/*
 *  FLMapLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"
#import "NSDictionary+JSONAddition.h"
#import "FLTileSetManager.h"


static NSString *const kTypeKey    = @"Type";
static NSString *const kNameKey    = @"Name";
static NSString *const kMapSizeKey = @"MapSize";


@implementation FLMapLayer
{
    FLMapLayerType  mType;
    NSString       *mName;
    NSSize          mMapSize;
    
    FLTileSet      *mTileSet;
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
        NSLog(@"FLMapLayer initWithObject");
        
        mType    = (FLMapLayerType)[[aDict objectForKey:kTypeKey] integerValue];
        mName    = [[aDict objectForKey:kNameKey] retain];

        [self setMapSize:[[aDict objectForKey:kMapSizeKey] sizeValue]];
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
    NSLog(@"JSONObject - %@", self);
    NSMutableDictionary *sResult = [NSMutableDictionary dictionary];
    
    [sResult setObject:[NSNumber numberWithInteger:mType] forKey:kTypeKey];
    [sResult setObject:mName forKey:kNameKey];
    [sResult setObject:[NSDictionary dictionaryWithSize:mMapSize] forKey:kMapSizeKey];
    
    return sResult;
}


- (void)setMapSize:(NSSize)aMapSize
{
    mMapSize = aMapSize;
}


- (NSSize)mapSize
{
    return mMapSize;
}


@end
