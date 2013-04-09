/*
 *  FLMapView.h
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 8..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>


@protocol FLMapViewProtocol;


@interface FLMapView : NSView


- (void)setDataSource:(id<FLMapViewProtocol>)aDataSource;

- (void)reload;


@end


@protocol FLMapViewProtocol <NSObject>


@required
- (NSSize)mapSizeOfMapView:(FLMapView *)aMapView;
- (NSSize)tileSizeOfMapView:(FLMapView *)aMapView;


@end
