//
//  ResizeTextBox.m
//  TextBox
//
//  Created by Linus Geffarth on 18.04.16.
//  Copyright © 2016 Linus Geffarth. All rights reserved.
//

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIKit.h>

@interface ResizeTextBox: UITextField
@end

CGRect newRect;
BOOL isResizingLR;
BOOL isResizingUL;
BOOL isResizingUR;
BOOL isResizingLL;
CGPoint touchStart;
CGFloat kResizeThumbSize = 45.0f;

@implementation ResizeTextBox

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchStart = [[touches anyObject] locationInView:self];
    isResizingLR = (self.bounds.size.width - touchStart.x < kResizeThumbSize && self.bounds.size.height - touchStart.y < kResizeThumbSize);
    isResizingUL = (touchStart.x <kResizeThumbSize && touchStart.y <kResizeThumbSize);
    isResizingUR = (self.bounds.size.width-touchStart.x < kResizeThumbSize && touchStart.y<kResizeThumbSize);
    isResizingLL = (touchStart.x <kResizeThumbSize && self.bounds.size.height -touchStart.y <kResizeThumbSize);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touching... %@", NSStringFromCGRect(newRect));
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGPoint previous = [[touches anyObject] previousLocationInView:self];
    
    CGFloat deltaWidth = touchPoint.x - previous.x;
    CGFloat deltaHeight = touchPoint.y - previous.y;
    
    // get the frame values so we can calculate changes below
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (isResizingLR) {
        self.frame = CGRectMake(x, y, touchPoint.x+deltaWidth, touchPoint.y+deltaWidth);
    } else if (isResizingUL) {
        self.frame = CGRectMake(x+deltaWidth, y+deltaHeight, width-deltaWidth, height-deltaHeight);
    } else if (isResizingUR) {
        self.frame = CGRectMake(x, y+deltaHeight, width+deltaWidth, height-deltaHeight);      
    } else if (isResizingLL) {
        self.frame = CGRectMake(x+deltaWidth, y, width-deltaWidth, height+deltaHeight);   
    } else {
        // not dragging from a corner -- move the view
        self.center = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                  self.center.y + touchPoint.y - touchStart.y);
    }
    newRect = self.frame;
}

@end
