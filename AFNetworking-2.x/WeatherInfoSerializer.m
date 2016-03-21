//
//  WeatherInfoSerializer.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "WeatherInfoSerializer.h"
#import "WeatherInfoModel.h"

@implementation WeatherInfoSerializer

- (id)serializeResponseData:(id)data {

    return [[WeatherInfoModel alloc]initWithDictionary:data];
}

@end
