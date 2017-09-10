//
//  ViewController.m
//  JJScroller
//
//  Created by JieFei on 2017/9/9.
//  Copyright © 2017年 RobberJJ. All rights reserved.
//

#import "ViewController.h"
#import "JJScroller.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[@"" stringByPaddingToLength:4000 withString: @"asdasd" startingAtIndex:0]];
    [string addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:16] range:NSMakeRange(0, [string length])];
    
    [self.textView.textStorage setAttributedString:string];

    [[self.scrollView contentView] setPostsBoundsChangedNotifications: YES];
    
    //监听NSScrollView 滑动的偏移量
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter] ;
    [center addObserver: self
               selector: @selector(boundsDidChangeNotification:)
                   name: NSViewBoundsDidChangeNotification
                 object: [self.scrollView contentView]];

    
    
}

- (void) boundsDidChangeNotification: (NSNotification *) notification
{
    // 在这里进行处理
    NSClipView *changedContentView=[notification object];
    
    // get the origin of the NSClipView of the scroll view that
    // we're watching
    
    NSPoint changedBoundsOrigin = [changedContentView documentVisibleRect].origin;
    
    
} // boundsDidChangeNotification



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
