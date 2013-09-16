//
//  BitcoinPriceView.h
//  BitcoinPrice
//
//  Created by Colin Dean on 9/15/13.
//  Copyright (c) 2013 Colin Dean. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface BitcoinPriceView : ScreenSaverView {
    NSAttributedString* currentText;
    NSPoint currentPosition;
    NSDate* lastPriceUpdate;
}
@property (retain) NSAttributedString* currentText;
@property (readwrite) NSPoint currentPosition;
@property (readwrite) NSDate* lastPriceUpdate;
@end
