//
//  JJScroller.m
//  JJScroller
//
//  Created by JieFei on 2017/9/9.
//  Copyright © 2017年 RobberJJ. All rights reserved.
//

#import "JJScroller.h"

@implementation JJScroller

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self == nil) {
        return nil;
    }
    [self commonInitializer];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitializer];
}

- (void)commonInitializer
{
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                                options:(
                                                                         NSTrackingMouseEnteredAndExited
                                                                         | NSTrackingActiveInActiveApp
                                                                         | NSTrackingMouseMoved
                                                                         )
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)drawRect:(NSRect)dirtyRect {
    
    // Do some custom drawing...
    
    // Call NSScroller's drawKnob method (or your own if you overrode it)
    [self drawKnob];
}

- (void)drawKnobSlotInRect:(NSRect)slotRect highlight:(BOOL)flag
{
    // Don't draw the background. Should only be invoked when using overlay scrollers
}


- (void)mouseExited:(NSEvent *)theEvent
{
    [super mouseExited:theEvent];
    [self fadeOut];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [super mouseEntered:theEvent];
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.1f;
        [self.animator setAlphaValue:1.0f];
    } completionHandler:^{
    }];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    [super mouseMoved:theEvent];
    self.alphaValue = 1.0f;
}

- (void)setFloatValue:(float)aFloat
{
    [super setFloatValue:aFloat];
    [self.animator setAlphaValue:1.0f];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
    [self performSelector:@selector(fadeOut) withObject:nil afterDelay:1.5f];
}

- (void)fadeOut
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.3f;
        [self.animator setAlphaValue:0.0f];
    } completionHandler:^{
    }];
}

+(CGFloat)scrollerWidthForControlSize:(NSControlSize)controlSize scrollerStyle:(NSScrollerStyle)scrollerStyle{
    return 15;
}

+ (BOOL)isCompatibleWithOverlayScrollers
{
    return self == [JJScroller class];
}



@end
