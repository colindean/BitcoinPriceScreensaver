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
    return [self retrievePriceFromCoindesk];
}


- (double) retrievePriceFromBitcoinCharts
{
    NSDictionary *response;
    response = [self getJSONDataFromURL: @"http://api.bitcoincharts.com/v1/weighted_prices.json"];
    NSHashTable* usd = [response objectForKey: @"USD"];
    NSString* value = [usd valueForKey:@"24h"];
    return [value doubleValue];
}

- (double) retrievePriceFromCoindesk
{
    NSDictionary *response;
    response = [self getJSONDataFromURL: @"http://api.coindesk.com/v1/bpi/currentprice/USD.json"];
    NSHashTable* bpi = [response objectForKey: @"bpi"];
    NSHashTable* usd = [bpi valueForKey: @"USD"];
    NSString* rate = [usd valueForKey: @"rate_float"];
    return [rate doubleValue];
}

- (NSDictionary *) getJSONDataFromURL: (NSString*)jsonURL
{
    NSURL *url = [NSURL URLWithString: jsonURL];
    NSLog(@"Accessing URL %@", url);
    NSData *data = [NSData dataWithContentsOfURL: url];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];
    //TODO: Actually check the error
    return response;
}

@end