/*
 *  FLLayerItem.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 9..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLLayerItem.h"


@implementation FLLayerItem
{
    NSString *mName;
}


@synthesize name = mName;


#pragma mark -


- (id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}


- (void)dealloc
{
    [mName release];
    
    [super dealloc];
}


@end
