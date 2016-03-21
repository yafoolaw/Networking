//
//  NetworkingReachability.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "NetworkingReachability.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

// 用于测试网络是否可以连接的基准URL地址
static NSString *reachableBaseURL = @"http://baidu.com/";

static AFHTTPRequestOperationManager *m_manager    = nil;

static BOOL                           m_canSendMsg = YES;

@implementation NetworkingReachability

+ (void)initialize {
    
    if (self == [NetworkingReachability class]) {
        
        NSURL *baseURL = [NSURL URLWithString:reachableBaseURL];
        m_manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
        
        NSOperationQueue *operationQueue = m_manager.operationQueue;
        
        [m_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    
                    [operationQueue setSuspended:NO];
                    
                    if (m_canSendMsg) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachableViaWWANNotification
                                                                            object:nil
                                                                          userInfo:nil];
                        
                    }
                    
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                
                    [operationQueue setSuspended:NO];
                    
                    if (m_canSendMsg) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachableViaWIFINotification
                                                                            object:nil
                                                                          userInfo:nil];
                        
                    }
                    
                    break;
                }
                    
                case AFNetworkReachabilityStatusNotReachable: {
                    
                    [operationQueue setSuspended:NO];
                    
                    if (m_canSendMsg) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingNotReachableNotification
                                                                            object:nil
                                                                          userInfo:nil];
                        
                    }
                    
                    break;
                }
                    
                default: {
                
                    [operationQueue setSuspended:NO];
                    
                    if (m_canSendMsg) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingNotReachableNotification
                                                                            object:nil
                                                                          userInfo:nil];
                        
                    }
                     break;
                }
                   
            }
        }];
    }
}

+ (void)startMonitoring {

    m_canSendMsg = YES;
    [m_manager.reachabilityManager startMonitoring];
}

+ (void)stopMonitoring {

    m_canSendMsg = NO;
    [m_manager.reachabilityManager stopMonitoring];
}

+ (BOOL)isReachable {

    return m_manager.reachabilityManager.isReachable;
}

+ (BOOL)isReachableViaWWAN {

    return m_manager.reachabilityManager.isReachableViaWWAN;
}

+ (BOOL)isReachableViaWIFI {

    return m_manager.reachabilityManager.isReachableViaWiFi;
}

@end
