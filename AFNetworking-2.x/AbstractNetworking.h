//
//  AbstractNetworking.h
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMethodType.h"
#import "RequestBodyType.h"
#import "ResponseDataType.h"
#import "AbstractRequestParameterSerializer.h"
#import "AbstractRequestDataSerializer.h"

@class AbstractNetworking;

@protocol AbstractNetworkingDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param networking networking对象
 *  @param data       数据
 */
- (void)requestSucess: (AbstractNetworking *)networking data: (id)data;

/**
 *  请求失败
 *
 *  @param networking networking对象
 *  @param error      错误信息
 */
- (void)requestFailed: (AbstractNetworking *)networking error: (NSError *)error;

@end


@interface AbstractNetworking : NSObject

#pragma mark - 设置参数

/**
 *  网络请求地址（空网址直接崩溃）
 */
@property (nonatomic, strong) NSString                           *m_urlStr;

/**
 *  请求方法类型（如 GET，POST等）
 */
@property (nonatomic, strong) RequestMethodType                  *m_mehtod;

/**
 *  设置请求头部信息
 */
@property (nonatomic, strong) NSDictionary                       *m_HTTPHeaderFieldsWithValues;

/**
 *  请求方式类型（如HTTP请求的方式、JSON序列化请求方式、PropertyList请求方式等）
 */
@property (nonatomic, strong) RequestBodyType                    *m_requestBodyType;

/**
 *  回复数据的类型（如返回的数据为二进制data、序列化的JSON数据等）
 */
@property (nonatomic, strong) ResponseDataType                   *m_responseDataType;

/**
 *  代理
 */
@property (nonatomic, strong) id <AbstractNetworkingDelegate>     m_delegate;

/**
 *  请求用参数（字典或者数组）
 */
@property (nonatomic, strong) id                                  m_requestParameter;

/**
 *  请求标记
 */
@property (nonatomic)         NSInteger                          m_tag;

/**
 *  请求超时时间间隔（不设置的话默认值为5s）
 */
@property (nonatomic, strong) NSNumber                           *m_timeoutInterval;

/**
 *  处理请求字典参数（不设置的话默认不处理）
 */
@property (nonatomic, strong) AbstractRequestParameterSerializer *m_requestParameterSerializer;

/**
 *  处理返回的数据
 */
@property (nonatomic, strong) AbstractRequestDataSerializer      *m_responseDataSerializer;

#pragma mark - 运行时候的参数

/**
 *  是否正在请求当中
 */
@property (nonatomic)         BOOL                 m_isRunning;

/**
 *  没有处理过的原始数据
 */
@property (nonatomic, strong) id                   m_originalResponseData;

/**
 *  处理过的原始数据
 */
@property (nonatomic, strong) id                   m_serializerResponseData;

/**
 *  请求的一些信息
 */
@property (nonatomic, strong) NSMutableDictionary *m_networkingInfo;

#pragma mark - 初始化设置

/**
 *  初始化设置
 */
- (void)setup;

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancelRequest;

/**
 *  GET请求
 *
 *  @param urlString         网址
 *  @param requestParameter  请求参数（字典或者数组）
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)getMethodNetworkingWithUrlStr: (NSString*)urlStr
                   requestParameter: (id)requestParameter
                    requestBodyType: (RequestBodyType*)requestBodyType
                   responseDataType: (ResponseDataType*)responseDataType;

/**
 *  POST请求
 *
 *  @param urlString         网址
 *  @param requestParameter  请求参数（字典或者数组）
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)postMethodNetworkingWithUrlStr: (NSString*)urlStr
                    requestParameter: (id)requestParameter
                     requestBodyType: (RequestBodyType*)requestBodyType
                    responseDataType: (ResponseDataType*)responseDataType;


@end
