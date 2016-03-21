//
//  AbstractNetworkingIndicator.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractNetworkingIndicator : NSObject

/**
 *  是否显示网络加载指示器
 *
 *  @param show 是否显示
 */
+ (void)showNetworkActivityIndicator : (BOOL)show;

@end
