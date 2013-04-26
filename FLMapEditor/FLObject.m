/*
 *  FLObject.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 25..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObject.h"
#import "NSDictionary+JSONAddition.h"
#import "FLObjectTile.h"
#import "FLTileSetManager.h"
#import "FLObjectTileSet.h"


NSString const *kJSONObjectIDKey = @"ObjectId";
NSString const *kJSONFrameKey    = @"Frame";


@implementation FLObject
{
    NSRect        mFrame;
    FLObjectTile *mObjectTile;
}


@synthesize frame      = mFrame;
@synthesize objectTile = mObjectTile;


#pragma mark -


- (id)initWithObjectTile:(FLObjectTile *)aObjectTile position:(NSPoint)aPosition
{
    self = [super init];
    
    if (self)
    {
        mObjectTile = [aObjectTile retain];
        mFrame.origin = aPosition;
        mFrame.size   = NSMakeSize([mObjectTile width], [mObjectTile height]);
    }
    
    return self;
}


- (id)initWithJSONObject:(NSDictionary *)aJSONObject
{
    self = [super init];
    
    if (self)
    {
        FLObjectTileSet *sObjectTileSet = (FLObjectTileSet *)[[FLTileSetManager sharedManager] objectTileSet];
        
        NSInteger sObjectId = [[aJSONObject objectForKey:kJSONObjectIDKey] integerValue];
        
        mObjectTile = (FLObjectTile *)[[sObjectTileSet tileForObjectId:sObjectId] retain];
        mFrame      = [[aJSONObject objectForKey:kJSONFrameKey] rectValue];
    }
    
    return self;
}


- (void)dealloc
{
    [mObjectTile release];
    
    [super dealloc];
}


#pragma mark -


- (NSMutableDictionary *)JSONObject
{
    NSMutableDictionary *sJSONObject = [NSMutableDictionary dictionary];
    
    [sJSONObject setObject:[NSNumber numberWithInteger:[mObjectTile objectId]] forKey:kJSONObjectIDKey];
    [sJSONObject setObject:[NSDictionary dictionaryWithRect:mFrame] forKey:kJSONFrameKey];
    
    return sJSONObject;
}


- (NSInteger)zorder
{
    return mFrame.origin.x * mFrame.origin.y;
}


- (NSComparisonResult)compare:(id)aObject
{
    FLObject *sObject  = (FLObject *)aObject;
    NSInteger sZorder1 = [self zorder];
    NSInteger sZorder2 = [sObject zorder];
    
    if (sZorder1 < sZorder2)
    {
        return NSOrderedAscending;
    }
    else if (sZorder1 > sZorder2)
    {
        return NSOrderedDescending;
    }
    else
    {
        return NSOrderedSame;
    }
}


@end
