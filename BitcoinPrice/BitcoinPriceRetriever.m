//
//  BitcoinPriceRetriever.m
//  BitcoinPrice
//
//  Created by Colin Dean on 9/15/13.
//  Copyright (c) 2013 Colin Dean. All rights reserved.
//

#import "BitcoinPriceRetriever.h"

@implementation BitcoinPriceRetriever

- (double) retrievePrice
{
    NSURL *url = [NSURL URLWithString: @"http://api.bitcoincharts.com/v1/weighted_prices.json"];
    NSLog(@"Accessing URL %@", url);
    NSData *data = [NSData dataWithContentsOfURL: url];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];
    NSHashTable* usd = [response objectForKey: @"USD"];
    NSString* value = [usd valueForKey:@"24h"];
    return [value doubleValue];
}

@end