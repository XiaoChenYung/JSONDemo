//
//  WeData.m
//  JSONDemo
//
//  Created by 杨晓晨 on 15/10/29.
//  Copyright © 2015年 杨晓晨. All rights reserved.
//

#import "WeData.h"
#import <MJExtension.h>
#import "Aqi.h"
#import "City.h"
@interface WeData ()

@property (nonatomic ,strong) NSDictionary *tempDict;
@property (nonatomic ,strong) NSArray *tempArray;
@property (nonatomic ,strong) NSDictionary *DataDict;
@property (nonatomic ,strong) Aqi *aqi;

@end

@implementation WeData

- (void)loadData {
    [self request:httpUrl withHttpArg:httpArg];
}

NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
NSString *httpArg = @"city=beijing";
/**
 *  网络请求
 *
 *  @param httpUrl url
 *  @param HttpArg arg
 */
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"712798c784173aecd74084c9bbbd9b14" forHTTPHeaderField: @"apikey"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            
            self.tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.tempArray = self.tempDict[@"HeWeather data service 3.0"];
            self.DataDict = self.tempArray.firstObject;
            WeData *data = [WeData objectWithKeyValues:self.DataDict];
            NSString *str = data.aqi.city.aqi;
            NSLog(@"%@",str);
            
        }
    }] resume];
}

#pragma MARK --懒加载

- (NSDictionary *)tempDict {
    if (_tempDict == nil) {
        _tempDict = [NSDictionary dictionary];
    }
    return _tempDict;
}

- (NSDictionary *)DataDict {
    if (_DataDict == nil) {
        _DataDict = [NSDictionary dictionary];
    }
    return _DataDict;
}

- (NSArray *)tempArray {
    if (_tempArray == nil) {
        _tempArray = [NSArray array];
    }
    return _tempArray;
}

@end


