//
//  WeatherInfoModel.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfoModel : NSObject

@property (nonatomic, strong) NSArray        *m_list;
@property (nonatomic, strong) NSDictionary   *m_city;
@property (nonatomic, strong) NSNumber       *m_message;
@property (nonatomic, strong) NSNumber       *m_cnt;
@property (nonatomic, strong) NSString       *m_cod;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
