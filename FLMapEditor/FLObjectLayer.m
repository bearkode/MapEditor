/*
 *  FLObjectLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectLayer.h"
#import "FLObject.h"
#import "FLObjectTile.h"
#import "FLUtils.h"


@implementation FLObjectLayer
{
    NSMutableArray *mObjects;
}


- (id)init
{
    self = [super initWithType:kFLMapLayerObjectType];
    
    if (self)
    {
        mObjects = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (id)initWithJSONObject:(NSDictionary *)aDict
{
    self = [super initWithJSONObject:aDict];
    
    if (self)
    {
        mObjects = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [mObjects release];
    
    [super dealloc];
}


#pragma mark -


- (BOOL)intersectsWithObject:(FLObject *)aObject
{
    BOOL sResult = NO;
    
    for (FLObject *sObject in mObjects)
    {
        if (NSIntersectsRect([sObject frame], [aObject frame]))
        {
            sResult = YES;
            break;
        }
    }
    
    return sResult;
}


- (BOOL)intersectsWithFrame:(NSRect)aFrame
{
    BOOL sResult = NO;
    
    for (FLObject *sObject in mObjects)
    {
        if (NSIntersectsRect([sObject frame], aFrame))
        {
            sResult = YES;
            break;
        }
    }
    
    return sResult;
}


- (BOOL)addObject:(FLObject *)aObject
{
    if (![self intersectsWithObject:aObject])
    {
        [mObjects addObject:aObject];
        [mObjects sortUsingSelector:@selector(compare:)];
        return YES;
    }

    return NO;
}


- (void)removeObject:(FLObject *)aObject
{
    [mObjects removeObject:aObject];
}


- (FLObject *)objectAtGridPosition:(NSPoint)aPosition
{
    FLObject *sResult = nil;
    
    for (FLObject *sObject in mObjects)
    {
        if (NSPointInRect(aPosition, [sObject frame]))
        {
            sResult = sObject;
            break;
        }
    }
    
    return sResult;
}


- (void)drawObjects
{
    for (FLObject *sObject in mObjects)
    {
        NSRect   sFrame = [sObject frame];
        NSImage *sImage = [[sObject objectTile] image];
        NSPoint  sPoint = FLGetCenterPointOfGrid([self mapSize], [self tileSize], sFrame.origin);
        NSSize   sSize  = FLGetPixelSizeFromMapInfo(sFrame.size, [self tileSize]);
        
        sPoint.x -= ([sImage size].width / 2);
        sPoint.y -= ([sImage size].height - sSize.height);
        sPoint.y -= ([self tileSize].height / 2);
        
        [sImage drawInRect:NSMakeRect(sPoint.x, sPoint.y, [sImage size].width, [sImage size].height)
                  fromRect:NSMakeRect(0, 0, [sImage size].width, [sImage size].height)
                 operation:NSCompositeSourceAtop
                  fraction:1.0
            respectFlipped:YES
                     hints:nil];
    }
}


#pragma mark -


- (BOOL)canObjectPlaceAtGridPosition:(NSPoint)aGridPositoin size:(NSSize)aSize
{
    BOOL sResult = YES;
    
    if ([self intersectsWithFrame:NSMakeRect(aGridPositoin.x, aGridPositoin.y, aSize.width, aSize.height)])
    {
        sResult = NO;
    }
    
    return sResult;
}


@end
