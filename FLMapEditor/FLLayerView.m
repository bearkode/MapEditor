//
//  FLLayerView.m
//  FLMapEditor
//
//  Created by cgkim on 13. 4. 24..
//  Copyright (c) 2013년 cgkim. All rights reserved.
//

#import "FLLayerView.h"

@implementation FLLayerView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}


- (BOOL)isFlipped
{
    return YES;
}

@end
