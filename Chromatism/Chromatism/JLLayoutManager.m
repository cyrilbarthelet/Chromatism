//
//  JLLayoutManager.m
//  Chromatism
//
//  Created by Johannes Lund on 2013-08-20.
//  Copyright (c) 2013 Anviking. All rights reserved.
//

#import "JLLayoutManager.h"
#import "UIColor+Chromatism.h"

NSString *const JLMarkdownCodeAttribute = @"Code";

@implementation JLLayoutManager

- (void)drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin
{
    NSRange range = [self characterRangeForGlyphRange:glyphsToShow actualGlyphRange:NULL];
    [self.textStorage enumerateAttribute:JLMarkdownCodeAttribute inRange:range options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            NSRange wholeGlyphRange = [self glyphRangeForCharacterRange:range actualCharacterRange:NULL];
            [self enumerateEnclosingRectsForGlyphRange:wholeGlyphRange withinSelectedGlyphRange:wholeGlyphRange inTextContainer:self.textContainers.firstObject usingBlock:^(CGRect rect, BOOL *stop) {
                [self drawCodeContainerInRect:CGRectOffset(rect, origin.x, origin.y + 4)];
            }];
        }
    }];
    
    [super drawBackgroundForGlyphRange:glyphsToShow atPoint:origin];
}

- (void)drawCodeContainerInRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* borderColor = [UIColor colorWithRed: 0.867 green: 0.867 blue: 0.867 alpha: 1];
    UIColor* backgroundColor = [UIColor colorWithRed: 0.972549 green: 0.972549 blue: 0.972549 alpha: 1];
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: 3];
    [backgroundColor setFill];
    [roundedRectanglePath fill];
    [borderColor setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
}

@end