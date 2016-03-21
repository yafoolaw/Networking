//
//  RequestBodyType.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBodyType : NSObject

+ (instancetype)type;

@end

@interface HttpBodyType : RequestBodyType

@end

@interface JsonBodyType : RequestBodyType

@end

@interface PlistBodyType : RequestBodyType

@end
