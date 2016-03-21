//
//  WeatherInfoModel.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "WeatherInfoModel.h"

@implementation WeatherInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    key = [NSString stringWithFormat:@"m_%@",key];
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        self = [super init];
        if (self) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
        
        return self;
        
    } else {
        
        return nil;
    }
}

@end
