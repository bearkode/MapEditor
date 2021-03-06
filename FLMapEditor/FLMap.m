/*
 *  FLMap.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMap.h"
#import "NSDictionary+JSONAddition.h"
#import "FLMapLayer.h"
#import "FLTerrainLayer.h"
#import "FLObjectLayer.h"
#import "FLUtils.h"


NSString *const kMapSizeKey      = @"MapSize";
NSString *const kTileSizeKey     = @"TileSize";
NSString *const kLayersKey       = @"Layers";

NSString *const kTerrainLayerKey = @"TerrainLayer";
NSString *const kObjectLayerKey  = @"ObjectLayer";


//static NSInteger const kTerrainLayerIndex = 0;
//static NSInteger const kObjectLayerIndex  = 1;


@implementation FLMap
{
    NSSize             mMapSize;
    NSSize             mTileSize;
    NSArrayController *mMapLayersController;
    
    CGAffineTransform  mTransform;
}


@synthesize mapSize   = mMapSize;
@synthesize tileSize  = mTileSize;
@synthesize transform = mTransform;
@dynamic    arrayController;


#pragma mark -
#pragma mark Accessors


- (NSArrayController *)arrayController
{
    return mMapLayersController;
}


#pragma mark -


- (void)setupMapLayersController
{
    [mMapLayersController setObjectClass:[FLMapLayer class]];
    [mMapLayersController setAvoidsEmptySelection:YES];
    [mMapLayersController setPreservesSelection:YES];
    [mMapLayersController setSelectsInsertedObjects:YES];
    [mMapLayersController setClearsFilterPredicateOnInsertion:YES];
    [mMapLayersController setEditable:YES];
}


- (void)setupIntitialLayers
{
    FLMapLayer *sMapLayer;
    
    sMapLayer = [[[FLTerrainLayer alloc] init] autorelease];
    [sMapLayer setName:kTerrainLayerKey];
    [sMapLayer setMapSize:mMapSize];
    [sMapLayer setTileSize:mTileSize];
    [self insertMapLayerOnTop:sMapLayer];
    
    sMapLayer = [[[FLObjectLayer alloc] init] autorelease];
    [sMapLayer setName:kObjectLayerKey];
    [sMapLayer setMapSize:mMapSize];
    [sMapLayer setTileSize:mTileSize];
    [self insertMapLayerOnTop:sMapLayer];
}


- (void)setupTransform
{
    NSSize            sSize       = FLGetPixelSizeFromMapInfo(mMapSize, mTileSize);
    CGFloat           sHalfWidth  = mTileSize.width / 2;
    CGFloat           sHalfHeight = mTileSize.height / 2;
    CGPoint           sConerPoint = FLGetCenterPointOfGrid(mMapSize, mTileSize, NSMakePoint(mMapSize.width - 1, mMapSize.height - 1));
    CGAffineTransform sToIso;
    
    sConerPoint.y = sSize.height - sConerPoint.y;
    sConerPoint.y -= sHalfHeight;
    
    sToIso     = CGAffineTransformMake(-sHalfWidth, sHalfHeight, sHalfWidth, sHalfHeight, sConerPoint.x, sConerPoint.y);
    mTransform = CGAffineTransformInvert(sToIso);
}


#pragma mark -


- (id)initWithMapSize:(NSSize)aMapSize tileSize:(NSSize)aTileSize
{
    self = [super init];
    
    if (self)
    {
        mMapSize             = aMapSize;
        mTileSize            = aTileSize;
        mMapLayersController = [[NSArrayController alloc] init];
        
        [self setupMapLayersController];
        [self setupTransform];
        [self setupIntitialLayers];
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
            mMapSize             = [[sJSONObject objectForKey:kMapSizeKey] sizeValue];
            mTileSize            = [[sJSONObject objectForKey:kTileSizeKey] sizeValue];
            mMapLayersController = [[NSArrayController alloc] init];

            [self setupMapLayersController];
            [self setupTransform];
            
            NSArray *sLayers = [sJSONObject objectForKey:kLayersKey];
            
            for (id sLayerDict in sLayers)
            {
                FLMapLayerType sType  = (FLMapLayerType)[[sLayerDict objectForKey:@"Type"] integerValue];
                Class          sClass = NULL;
                
                if (sType == kFLMapLayerTerrainType)
                {
                    sClass = [FLTerrainLayer class];
                }
                else if (sType == kFLMapLayerObjectType)
                {
                    sClass = [FLObjectLayer class];
                }
                
                FLMapLayer *sMapLayer = [[[sClass alloc] initWithJSONObject:sLayerDict] autorelease];
                [self addMapLayer:sMapLayer];
            }
        }
    }
    
    return self;
}


- (void)dealloc
{
    [mMapLayersController release];
    
    [super dealloc];
}


#pragma mark -


- (NSData *)JSONDataRepresentation
{
    NSData              *sResult    = nil;
    NSMutableDictionary *sMapDict   = [NSMutableDictionary dictionary];
    NSError             *sError     = nil;
    NSMutableArray      *sMapLayers = [NSMutableArray array];
    
    [sMapDict setObject:[NSDictionary dictionaryWithSize:mMapSize] forKey:kMapSizeKey];
    [sMapDict setObject:[NSDictionary dictionaryWithSize:mTileSize] forKey:kTileSizeKey];
    
    for (FLMapLayer *sMapLayer in [mMapLayersController arrangedObjects])
    {
        NSDictionary *sMapLayerJSONObject = [sMapLayer JSONObject];
        [sMapLayers addObject:sMapLayerJSONObject];
    }
    [sMapDict setObject:sMapLayers forKey:kLayersKey];
    
    sResult = [NSJSONSerialization dataWithJSONObject:sMapDict options:0 error:&sError];
    if (sError)
    {
        NSLog(@"JSON Serialization error - %@", sError);
    }
    
    return sResult;
}


#pragma mark -


- (void)addMapLayer:(FLMapLayer *)aMapLayer
{
    [mMapLayersController addObject:aMapLayer];
}


- (void)insertMapLayerOnTop:(FLMapLayer *)aMapLayer
{
    [mMapLayersController insertObject:aMapLayer atArrangedObjectIndex:0];
}


- (void)removeMapLayer:(FLMapLayer *)aMapLayer
{

}


- (NSArray *)layers
{
    return [mMapLayersController arrangedObjects];
}


#pragma mark -


- (FLTerrainLayer *)terrainLayer
{
    FLTerrainLayer *sTerrainLayer = nil;
    
    for (FLMapLayer *sMapLayer in [mMapLayersController arrangedObjects])
    {
        if ([sMapLayer isKindOfClass:[FLTerrainLayer class]])
        {
            sTerrainLayer = (FLTerrainLayer *)sMapLayer;
            break;
        }
    }
    
    return sTerrainLayer;
}


- (FLObjectLayer *)objectLayer
{
    FLObjectLayer *sObjectLayer = nil;
    
    for (FLMapLayer *sMapLayer in [mMapLayersController arrangedObjects])
    {
        if ([sMapLayer isKindOfClass:[FLObjectLayer class]])
        {
            sObjectLayer = (FLObjectLayer *)sMapLayer;
            break;
        }
    }
    
    return sObjectLayer;
}


- (BOOL)canObjectPlaceAtGridPosition:(NSPoint)aGridPositoin size:(NSSize)aSize
{
    BOOL            sResult       = NO;
    FLTerrainLayer *sTerrainLayer = [self terrainLayer];
    
    sResult = [sTerrainLayer canObjectPlaceAtGridPosition:aGridPositoin size:aSize];
    if (sResult)
    {
        FLObjectLayer *sObjectLayer = [self objectLayer];
        sResult = [sObjectLayer canObjectPlaceAtGridPosition:aGridPositoin size:aSize];
    }
    
    return sResult;
}


@end
