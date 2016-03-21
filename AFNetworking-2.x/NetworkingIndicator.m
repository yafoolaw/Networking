//
//  NetworkingIndicator.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "NetworkingIndicator.h"
#import "UIKit+AFNetworking.h"

@implementation NetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {

    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:show];
}

@end
