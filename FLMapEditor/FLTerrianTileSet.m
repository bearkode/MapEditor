/*
 *  FLTerrianTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrianTileSet.h"


@implementation FLTerrianTileSet
{
    NSManagedObjectContext *mMOContext;
}


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

#if (1)
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
    }
    
    return self;
}


- (void)dealloc
{
    [mMOContext release];
    
    [super dealloc];
}


#pragma mark -


@end
