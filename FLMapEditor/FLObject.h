/*
 *  FLObject.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 25..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@class FLObjectTile;


@interface FLObject : NSObject


@property (nonatomic, assign)   NSRect        frame;
@property (nonatomic, readonly) FLObjectTile *objectTile;


- (id)initWithObjectTile:(FLObjectTile *)aObjectTile position:(NSPoint)aPosition;
- (id)initWithJSONObject:(NSDictionary *)aJSONObject;


- (NSComparisonResult)compare:(id)aObject;

- (NSMutableDictionary *)JSONObject;

@end
