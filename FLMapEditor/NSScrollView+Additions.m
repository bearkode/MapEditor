/*
 *  NSScrollView+Additions.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 11..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "NSScrollView+Additions.h"


@implementation NSScrollView (Additions)


- (void)scrollToCenter
{
    CGFloat sMidX       = NSMidX([[self documentView] bounds]);
    CGFloat sMidY       = NSMidY([[self documentView] bounds]);
    CGFloat sHalfWidth  = NSWidth([[self contentView] frame]) / 2.0;
    CGFloat sHalfHeight = NSHeight([[self contentView] frame]) / 2.0;
    NSPoint sNewOrigin  = NSMakePoint(sMidX - sHalfWidth, sMidY + (([[self documentView] isFlipped]) ? sHalfHeight : -sHalfHeight));
    
    [[self documentView] scrollPoint:sNewOrigin];
}


@end
