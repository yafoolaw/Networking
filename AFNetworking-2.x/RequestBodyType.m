//
//  RequestBodyType.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "RequestBodyType.h"

@implementation RequestBodyType

+ (instancetype)type {

    RequestBodyType *bodyType = [[self class] new];
    
    return bodyType;
}

@end

@implementation HttpBodyType

@end

@implementation JsonBodyType

@end

@implementation PlistBodyType

@end
