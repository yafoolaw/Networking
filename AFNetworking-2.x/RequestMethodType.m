//
//  RequestMethodType.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "RequestMethodType.h"

@implementation RequestMethodType

+ (instancetype)type {

    RequestMethodType *method = [[[self class] alloc] init];
    
    return method;
}

@end

@implementation GetMethod

@end

@implementation PostMethod

@end
