//
//  ViewController.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "ViewController.h"
#import "WeatherInfoSerializer.h"
#import "Networking.h"
#import "NetworkingIndicator.h"
#import "NetworkingReachability.h"

typedef enum : NSUInteger {
    
    kForecastDaily = 1000,

} ENetworkingTag;

@interface ViewController ()<AbstractNetworkingDelegate>

@property (nonatomic, strong) Networking *m_networking;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [NetworkingIndicator showNetworkActivityIndicator:YES];
    
    [NetworkingReachability startMonitoring];
    
    // 添加网络监听
    [self addNetworkingObserver];
    
    // 初始化网络请求
    self.m_networking = [Networking getMethodNetworkingWithUrlStr:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                                                 requestParameter:@{@"lat"   :  @"39.907501",
                                                                    @"lon"   :  @"116.397232",
                                                                    @"APPID" :  @"8781e4ef1c73ff20a180d3d7a42a8c04"}
                                                  requestBodyType:[HttpBodyType type]
                                                 responseDataType:[JsonDataType type]];
    
    // 可以注释掉（设置结果的序列化）
//    self.m_networking.m_responseDataSerializer = [WeatherInfoSerializer new];
    
    self.m_networking.m_timeoutInterval = @(5.f);
    self.m_networking.m_delegate        = self;
    self.m_networking.m_tag             = kForecastDaily;
    [self.m_networking startRequest];
}

- (void)requestSucess:(AbstractNetworking *)networking data:(id)data {
    
    if (networking.m_tag == kForecastDaily) {
        
        NSLog(@"%@", networking.m_networkingInfo);
        NSLog(@"%@", data);
    }
}

- (void)requestFailed:(AbstractNetworking *)networking error:(NSError *)error {
    
    if (networking.m_tag == kForecastDaily) {
        
        NSLog(@"%@", error);
    }
}

#pragma mark - 监听网络状态
- (void)addNetworkingObserver {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationEvent:)
                                                 name:NetworkingReachableViaWIFINotification
                                               object:nil];
}

- (void)notificationEvent: (id)sender {

    NSLog(@"%@",sender);
}

@end
