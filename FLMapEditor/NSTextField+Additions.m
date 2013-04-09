/*
 *  NSTextField+Additions.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 9..
 *  Copyright (c) 2013년 cgkim. All rights reserved.
 *
 */

#import "NSTextField+Additions.h"


@implementation NSTextField (Additions)


- (CGFloat)floatValue
{
    NSString *sValueStr = ([[self stringValue] length] != 0)  ? [self stringValue]  : [[self cell] placeholderString];

    return [sValueStr floatValue];
}


@end
