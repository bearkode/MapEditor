/*
 *  FLTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTileSet.h"
#import "FLTile.h"


@implementation FLTileSet
{
    NSManagedObjectContext *mMOContext;
    
    NSMutableArray         *mTiles;
    NSMutableArray         *mAddedTiles;
    NSMutableArray         *mRemovedTiles;
}


@synthesize context = mMOContext;
@synthesize tiles   = mTiles;


#pragma mark -


- (void)setupContext
{
    NSError                      *sError       = [NSError errorWithDomain:@"DummyError" code:0 userInfo:nil];
    NSManagedObjectModel         *sMOModel     = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    NSPersistentStoreCoordinator *sCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:sMOModel];
    
#if (0)
    [sCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:[self storeOptions] error:&sError];
#else
    while (sError)
    {
        sError = nil;
        [sCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:[self storeOptions] error:&sError];
        if (sError)
        {
            NSLog(@"sError = %@", sError);
            [[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:nil];
        }
    }
#endif
    
    if (sCoordinator)
    {
        mMOContext = [[NSManagedObjectContext alloc] init];
        [mMOContext setPersistentStoreCoordinator:sCoordinator];
    }
    
//    NSLog(@"context ready");
    
    [sMOModel release];
    [sCoordinator release];
}


#pragma mark -


- (id)init
{
    self = [super init];
    
    if (self)
    {
        mTiles        = [[NSMutableArray alloc] init];
        mAddedTiles   = [[NSMutableArray alloc] init];
        mRemovedTiles = [[NSMutableArray alloc] init];
        
        [self setupContext];
    }
    
    return self;
}


- (void)dealloc
{
    [mTiles release];
    [mAddedTiles release];
    [mRemovedTiles release];
    
    [mMOContext release];
    
    [super dealloc];
}


#pragma mark -


- (NSString *)entityName
{
    return nil;
}


- (NSURL *)storeURL
{
    return nil;
}


- (NSDictionary *)storeOptions
{
    NSDictionary *sPragmaOpts = [NSDictionary dictionaryWithObjectsAndKeys:@"MEMORY", @"journal_mode", nil];
    NSDictionary *sOptions    = [NSDictionary dictionaryWithObject:sPragmaOpts forKey:NSSQLitePragmasOption];
    
    return sOptions;
}


#pragma mark -


//- (void)setTilesFromArray:(NSArray *)aTiles
//{
//}
//
//
//- (void)addTile:(FLTile *)aTile
//{
//    [mTiles addObject:aTile];
//}
//
//
//- (void)removeTile:(FLTile *)aTile
//{
//    [mTiles removeObject:aTile];
//}


- (NSUInteger)count
{
    NSEntityDescription *sEntity       = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:mMOContext];
    NSFetchRequest      *sFetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    
    [sFetchRequest setEntity:sEntity];
    
    NSError   *sError = nil;
    NSUInteger sCount = [mMOContext countForFetchRequest:sFetchRequest error:&sError];
    
    return sCount;
}


- (FLTile *)insertNewTile
{
    NSUInteger  sIndex  = [self count];
    FLTile     *sResult = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:mMOContext];
    
    [sResult setObjectId:(int)(sIndex + 1)];
    [mAddedTiles addObject:sResult];
    
    return sResult;
}


//- (void)deleteTile:(FLTile *)aTile
//{
//    [mMOContext deleteObject:aTile];
//    [mRemovedTiles addObject:aTile];
//}


- (void)deleteTileAtIndex:(NSInteger)aIndex
{
    FLTile *sTile = [self tileAtIndex:aIndex];
    
    [mMOContext deleteObject:sTile];
    [mRemovedTiles addObject:sTile];
}


- (FLTile *)tileAtIndex:(NSInteger)aIndex
{
    FLTile *sTile = [mTiles objectAtIndex:aIndex];
    
    return sTile;
}


- (FLTile *)tileForObjectId:(NSInteger)aObjectId
{
    FLTile *sResult = nil;
    
    for (FLTile *sTile in mTiles)
    {
        if ([sTile objectId] == aObjectId)
        {
            sResult = sTile;
            break;
        }
    }
    
    return sResult;
}


#pragma mark -


- (void)fetch
{
    NSEntityDescription *sEntityDescription = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[self context]];
    NSFetchRequest      *sRequest           = [[[NSFetchRequest alloc] init] autorelease];
    NSSortDescriptor    *sSortDescriptor    = [[[NSSortDescriptor alloc] initWithKey:@"objectId" ascending:YES] autorelease];
    
    [sRequest setEntity:sEntityDescription];
    [sRequest setSortDescriptors:[NSArray arrayWithObject:sSortDescriptor]];
    
    NSError *sError;
    NSArray *sArray = [[self context] executeFetchRequest:sRequest error:&sError];
    
    [self willChangeValueForKey:@"tiles"];
    [mTiles removeAllObjects];
    [mTiles addObjectsFromArray:sArray];
    [self didChangeValueForKey:@"tiles"];
}


- (void)save
{
    [self willChangeValueForKey:@"tiles"];
    [mMOContext save:nil];
    
    [mTiles addObjectsFromArray:mAddedTiles];
    [mTiles removeObjectsInArray:mRemovedTiles];
    [mTiles sortUsingComparator:^NSComparisonResult(FLTile *aTile1, FLTile *aTile2) {
        if ([aTile1 objectId] > [aTile2 objectId])
        {
            return NSOrderedDescending;
        }
        else if ([aTile1 objectId] < [aTile2 objectId])
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    [self didChangeValueForKey:@"tiles"];
}


- (void)rollback
{
    [mMOContext rollback];
    [mAddedTiles removeAllObjects];
    [mRemovedTiles removeAllObjects];
}


@end
