//
//  AbstractNetworkingIndicator.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "AbstractNetworkingIndicator.h"

@implementation AbstractNetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {

    [NSException raise:@"NetworkingIndicator showNetworkActivityIndicator:"
                format:@"You must override this method."];
}

@end
