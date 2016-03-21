//
//  AbstractRequestParameterSerializer.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractRequestParameterSerializer : NSObject

/**
 *  处理请求参数（字典或者数组）
 *
 *  @param requestParameter 请求参数
 *
 *  @return 处理后的参数
 */
- (id)serializeRequestParameter: (id)requestParameter;

@end
