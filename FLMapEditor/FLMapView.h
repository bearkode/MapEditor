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


- (void)setDelegate:(id<FLMapViewProtocol>)aDelegate;
- (void)setDataSource:(id<FLMapViewProtocol>)aDataSource;

- (void)reload;
- (void)setNeedsDisplayAtGridPosition:(NSPoint)aPosition;


@end


@protocol FLMapViewProtocol <NSObject>


@required
- (NSSize)mapSizeOfMapView:(FLMapView *)aMapView;
- (NSSize)tileSizeOfMapView:(FLMapView *)aMapView;
- (NSArray *)layersForMapView:(FLMapView *)aMapView;

- (void)mapView:(FLMapView *)aMapView didMouseDownAtPoint:(NSPoint)aPoint;
- (void)mapView:(FLMapView *)aMapView didMouseUpAtPoint:(NSPoint)aPoint;
- (void)mapView:(FLMapView *)aMapView didMouseDragAtPoint:(NSPoint)aPoint;
- (void)mapView:(FLMapView *)aMapView didMouseMoveAtPoint:(NSPoint)aPoint;


@end
