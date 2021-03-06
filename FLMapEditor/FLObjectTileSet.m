/*
 *  FLObjectTileSet.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 17..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLObjectTileSet.h"


@implementation FLObjectTileSet


#pragma mark -


- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self fetch];
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark -


- (NSString *)entityName
{
    return @"FLObjectTile";
}


- (NSURL *)storeURL
{
    NSArray  *sDocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *sDocPath  = ([sDocPaths count] > 0) ? [sDocPaths objectAtIndex:0] : nil;
    NSURL    *sStoreURL = [NSURL fileURLWithPath:[sDocPath stringByAppendingPathComponent:@"ObjectTileSet.sqlite"]];
    
    return sStoreURL;
}


@end
