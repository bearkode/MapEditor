/*
 *  FLTerrainTile.m
 *  FLMapEditor
 *
 *  Created by cgkim on 13. 4. 12..
 *  Copyright (c) 2013 cgkim. All rights reserved.
 *
 */

#import "FLTerrainTile.h"


@implementation FLTerrainTile
{
    NSImage *mImage;
}


@dynamic passable;
@dynamic imageData;


- (void)didTurnIntoFault
{
    [mImage release];
    
    [super didTurnIntoFault];
}


- (NSImage *)image
{
    if (!mImage && [self imageData])
    {
        NSImage *sImage     = [[[NSImage alloc] initWithData:[self imageData]] autorelease];
        NSSize   sImageSize = NSMakeSize([sImage size].width / 2, [sImage size].height / 2);
        
        mImage = [[NSImage alloc] initWithSize:sImageSize];
        [mImage lockFocus];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sImage drawInRect:NSMakeRect(0, 0, sImageSize.width, sImageSize.height)
                  fromRect:NSMakeRect(0, 0, [sImage size].width, [sImage size].height)
                 operation:NSCompositeCopy
                  fraction:1.0];
        [mImage unlockFocus];
    }
    
    return mImage;
}


@end
