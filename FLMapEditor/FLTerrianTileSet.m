/*
 *  FLTerrianTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrianTileSet.h"
#import "FLTerrianTile.h"


NSString *const kEntityName = @"FLTerrianTile";


@implementation FLTerrianTileSet
{
    NSManagedObjectContext *mMOContext;
    NSArrayController      *mArrayController;
}


@synthesize arrayController = mArrayController;


#pragma mark -
#pragma mark Privates


- (NSURL *)storeURL
{
    NSArray  *sDocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *sDocPath  = ([sDocPaths count] > 0) ? [sDocPaths objectAtIndex:0] : nil;
    NSURL    *sStoreURL = [NSURL fileURLWithPath:[sDocPath stringByAppendingPathComponent:@"Topography.sqlite"]];
    
    return sStoreURL;
}


- (NSDictionary *)storeOptions
{
    NSDictionary *sPragmaOpts = [NSDictionary dictionaryWithObjectsAndKeys:@"MEMORY", @"journal_mode", nil];
    NSDictionary *sOptions    = [NSDictionary dictionaryWithObject:sPragmaOpts forKey:NSSQLitePragmasOption];
    
    return sOptions;
}


#pragma mark -


- (id)init
{
    self = [super init];
    
    if (self)
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
        
        NSLog(@"context ready");
        
        [sMOModel release];
        [sCoordinator release];
        
        mArrayController = [[NSArrayController alloc] init];
//        [mArrayController setObjectClass:[FLTerrianTile class]];
        [mArrayController setManagedObjectContext:mMOContext];
        [mArrayController setEntityName:@"FLTerrianTile"];
        [mArrayController setAutomaticallyPreparesContent:YES];        
        [mArrayController setAvoidsEmptySelection:YES];
        [mArrayController setPreservesSelection:YES];
        [mArrayController setSelectsInsertedObjects:YES];
        [mArrayController setClearsFilterPredicateOnInsertion:YES];
        [mArrayController setEditable:YES];
        [mArrayController fetch:self];
        
        NSArray *content = [mArrayController arrangedObjects];
        NSLog(@"content = %@", content);
    }
    
    return self;
}


- (void)dealloc
{
    [mMOContext release];
    [mArrayController release];
    
    [super dealloc];
}


#pragma mark -


- (NSUInteger)count
{
    NSEntityDescription *sEntity       = [NSEntityDescription entityForName:kEntityName inManagedObjectContext:mMOContext];
    NSFetchRequest      *sFetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    
    [sFetchRequest setEntity:sEntity];
    
    NSError   *sError = nil;
    NSUInteger sCount = [mMOContext countForFetchRequest:sFetchRequest error:&sError];
    
    return sCount;
}


- (FLTerrianTile *)insertNewTerrianTile
{
    NSUInteger     sIndex  = [self count];
    FLTerrianTile *sResult = (FLTerrianTile *)[NSEntityDescription insertNewObjectForEntityForName:kEntityName inManagedObjectContext:mMOContext];

    [sResult setIndex:(int)(sIndex + 1)];
    
    return sResult;
}


- (void)deleteTerrianTile:(FLTerrianTile *)aTerrianTile
{
    [mMOContext deleteObject:aTerrianTile];
}


- (void)save
{
    [mMOContext save:nil];
}


- (void)rollback
{
    [mMOContext rollback];
}


@end
