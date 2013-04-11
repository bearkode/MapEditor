/*
 *  FLMapLayer.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLMapLayer.h"


static NSString *const kNameKey = @"Name";


@implementation FLMapLayer
{
    NSString *mName;
}


@synthesize name = mName;


#pragma mark -


- (id)initWithJSONObject:(NSDictionary *)aDict
{
    self = [super init];
    
    if (self)
    {
        mName = [[aDict objectForKey:kNameKey] retain];
    }
    
    return self;
}


- (void)dealloc
{
    [mName release];
    
    [super dealloc];
}


#pragma mark -


- (NSDictionary *)JSONObject
{
    NSMutableDictionary *sResult = [NSMutableDictionary dictionary];
    
    [sResult setObject:mName forKey:kNameKey];
    
    return sResult;
}


@end
