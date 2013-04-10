/*
 *  FLMapLayer.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface FLMapLayer : NSObject


@property (nonatomic, retain) NSString *name;


- (id)initWithJSONObject:(NSDictionary *)aDict;

- (NSDictionary *)JSONObject;


@end
