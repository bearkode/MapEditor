/*
 *  FLMap.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMap.h"
#import "FLMapLayer.h"
#import "FLJSONHelper.h"


NSString *const kMapSizeKey         = @"MapSize";
NSString *const kTopographyLayerKey = @"TopographyLayer";
NSString *const kStructureLayerKey  = @"StructureLayer";


@implementation FLMap
{
    NSSize      mSize;
    
    FLMapLayer *mStructureLayer;
    FLMapLayer *mTopographyLayer;
}


#pragma mark -


- (id)initWithSize:(NSSize)aSize
{
    self = [super init];
    
    if (self)
    {
        mSize            = aSize;
        mTopographyLayer = [[FLMapLayer alloc] init];
        mStructureLayer  = [[FLMapLayer alloc] init];
    }
    
    return self;
}


- (id)initWithJSONData:(NSData *)aData
{
    self = [super init];
    
    if (self)
    {
        NSError      *sError      = nil;
        NSDictionary *sJSONObject = [NSJSONSerialization JSONObjectWithData:aData options:0 error:&sError];
        
        if (!sError)
        {
            mSize            = [FLJSONHelper sizeWithDictionary:[sJSONObject objectForKey:kMapSizeKey]];
            mTopographyLayer = [[FLMapLayer alloc] initWithJSONObject:[sJSONObject objectForKey:kTopographyLayerKey]];
            mStructureLayer  = [[FLMapLayer alloc] initWithJSONObject:[sJSONObject objectForKey:kStructureLayerKey]];
        }
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (NSData *)JSONDataRepresentation
{
    NSData              *sResult  = nil;
    NSMutableDictionary *sMapDict = [NSMutableDictionary dictionary];
    NSError             *sError   = nil;
    
    [sMapDict setObject:[FLJSONHelper dictionaryWithSize:mSize] forKey:kMapSizeKey];
    [sMapDict setObject:[mTopographyLayer JSONObject] forKey:kTopographyLayerKey];
    [sMapDict setObject:[mStructureLayer JSONObject] forKey:kStructureLayerKey];
    
    sResult = [NSJSONSerialization dataWithJSONObject:sMapDict options:0 error:&sError];
    if (sError)
    {
        NSLog(@"JSON Serialization error - %@", sError);
    }
    
    return sResult;
}


@end
