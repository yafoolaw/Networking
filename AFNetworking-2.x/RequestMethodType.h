//
//  RequestMethodType.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestMethodType : NSObject

+ (instancetype)type;

@end

@interface GetMethod : RequestMethodType

@end

@interface PostMethod : RequestMethodType

@end
