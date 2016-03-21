//
//  AbstractNetworkingReachability.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "AbstractNetworkingReachability.h"

NSString *const NetworkingReachableViaWWANNotification = @"NetworkingReachableViaWWAN";
NSString *const NetworkingReachableViaWIFINotification = @"NetworkingReachableViaWIFI";
NSString *const NetworkingNotReachableNotification     = @"NetworkingNotReachable";

@implementation AbstractNetworkingReachability

+ (void)startMonitoring {
    
    [NSException raise:@"NetworkingReachability startMonitoring:"
                format:@"You must override this method."];
}

+ (void)stopMonitoring {
    
    [NSException raise:@"NetworkingReachability stopMonitoring:"
                format:@"You must override this method."];
}

+ (BOOL)isReachable {
    
    [NSException raise:@"NetworkingReachability isReachable:"
                format:@"You must override this method."];
    
    return NO;
}

+ (BOOL)isReachableViaWWAN {
    
    [NSException raise:@"NetworkingReachability isReachableViaWWAN:"
                format:@"You must override this method."];
    
    return NO;
}

+ (BOOL)isReachableViaWIFI {
    
    [NSException raise:@"NetworkingReachability isReachableViaWiFi:"
                format:@"You must override this method."];
    
    return NO;
}

@end
