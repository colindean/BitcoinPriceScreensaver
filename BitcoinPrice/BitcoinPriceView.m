//
//  BitcoinPriceView.m
//  BitcoinPrice
//
//  Created by Colin Dean on 9/15/13.
//  Copyright (c) 2013 Colin Dean. All rights reserved.
//

#import "BitcoinPriceView.h"
#import "BitcoinPriceRetriever.h"

@implementation BitcoinPriceView

@synthesize currentPosition;
@synthesize currentText;
@synthesize lastPriceUpdate;

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        [self setCurrentText: [[NSAttributedString alloc] initWithString:@"Loading..." attributes: [self getAttributes]]];
        [self setCurrentPosition: NSMakePoint(0, 0)];
        
        [self updatePrice];
        
    }

    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    
    //[[NSColor redColor] set];
    //NSRectFill([self bounds]);
    
    [currentText drawAtPoint: currentPosition];
}

- (void)animateOneFrame
{
    CGSize bounds = [self bounds].size;
    if (currentPosition.y++ > bounds.height){
        currentPosition.y = 0;
    }
    if (currentPosition.x++ > bounds.width){
        currentPosition.x = 0;
    }
    
    NSDate* now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:lastPriceUpdate];
    if (interval > 60 ) {
        [self updatePrice];
    }
    
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)updatePrice
{
    BitcoinPriceRetriever *bpr = [[BitcoinPriceRetriever alloc] init];
    double price = [bpr retrievePrice];
    NSString *theString = [NSString stringWithFormat:@"%f", price];
    currentText = [[NSAttributedString alloc] initWithString: theString attributes: [self getAttributes]];
    lastPriceUpdate = [NSDate date];
    
}
     
- (NSDictionary*) getAttributes
{
    //note we are using the convenience method, so we don't need to autorelease the object
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:26], NSFontAttributeName, [NSColor whiteColor], NSForegroundColorAttributeName, nil];
    return attributes;
}

@end
