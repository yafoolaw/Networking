//
//  AbstractRequestDataSerializer.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractRequestDataSerializer : NSObject

/**
 *  处理返回的参数
 *
 *  @param data 处理前的参数
 *
 *  @return 处理后的参数
 */
- (id)serializeResponseData: (id)data;

@end
