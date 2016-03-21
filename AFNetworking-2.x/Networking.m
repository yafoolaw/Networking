//
//  Networking.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/21.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@interface Networking ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *m_manager;
@property (nonatomic, strong) AFHTTPRequestOperation        *m_httpOperation;

@end

@implementation Networking

- (void)setup {

    [super setup];
    
    // AFNetworking 2.x 相关初始化
    self.m_manager = [AFHTTPRequestOperationManager manager];
}

- (void)startRequest {

    NSParameterAssert(self.m_urlStr);
    NSParameterAssert(self.m_requestParameterSerializer);
    NSParameterAssert(self.m_responseDataSerializer);
    
    [self resetData];
    [self accessRequestSerializer];
    [self accessResponseSerializer];
    [self accessHeaderField];
    [self accessTimeoutInterval];
    
    if ([self.m_mehtod isKindOfClass:[GetMethod class]]) {
        
        [self accessGetRequest];
    
    } else if ([self.m_mehtod isKindOfClass:[PostMethod class]]) {
    
        [self accessPostRequest];
    }
    
    [self safetySetKey:@"absoluteString"         object:self.m_httpOperation.request.URL.absoluteString];
    [self safetySetKey:@"host"                   object:self.m_httpOperation.request.URL.host];
    [self safetySetKey:@"query"                  object:self.m_httpOperation.request.URL.query];
    [self safetySetKey:@"scheme"                 object:self.m_httpOperation.request.URL.scheme];
    [self safetySetKey:@"timeoutInterval"        object:@(self.m_httpOperation.request.timeoutInterval)];
    [self safetySetKey:@"allHTTPHeaderFields"    object:self.m_httpOperation.request.allHTTPHeaderFields];
    [self safetySetKey:@"acceptableContentTypes" object:self.m_manager.responseSerializer.acceptableContentTypes];
    [self safetySetKey:@"parameter"              object:self.m_requestParameter];
}

// 重置数据
- (void)resetData {

    self.m_originalResponseData   	= nil;
    self.m_serializerResponseData = nil;
}

// 处理请求body类型
- (void)accessRequestSerializer {

    if ([self.m_requestBodyType isKindOfClass:[HttpBodyType class]]) {
        
        self.m_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    } else if ([self.m_requestBodyType isKindOfClass:[JsonBodyType class]]) {
    
        self.m_manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    } else if ([self.m_requestBodyType isKindOfClass:[PlistBodyType class]]) {
    
        self.m_manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    
    } else {
    
        self.m_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

// 处理回复data类型
- (void)accessResponseSerializer {

    if ([self.m_responseDataType isKindOfClass:[HttpDataType class]]) {
        
        self.m_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if ([self.m_responseDataType isKindOfClass:[JsonDataType class]]) {
    
        self.m_manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    } else {
    
        self.m_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.m_manager.responseSerializer.acceptableContentTypes
    = [self.m_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    self.m_manager.responseSerializer.acceptableContentTypes
    = [self.m_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
}

// 处理头部信息
- (void)accessHeaderField {

    if (self.m_HTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.m_HTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.m_HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.m_manager.responseSerializer setValue:value forKey:headerField];
        }
    }
}

// 设置超时时间
- (void)accessTimeoutInterval {

    if (self.m_timeoutInterval && self.m_timeoutInterval.floatValue > 0) {
        
        [self.m_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.m_manager.requestSerializer.timeoutInterval = self.m_timeoutInterval.floatValue;
        [self.m_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

- (void)accessGetRequest {

    self.m_isRunning = YES;
    __weak Networking *weakSelf = self;
    
    self.m_httpOperation = [self.m_manager GET:self.m_urlStr
                                    parameters:[self.m_requestParameterSerializer serializeRequestParameter:self.m_requestParameter]
                                       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
                                           weakSelf.m_isRunning              = NO;
                                           weakSelf.m_originalResponseData   = responseObject;
                                           weakSelf.m_serializerResponseData = [weakSelf.m_responseDataSerializer serializeResponseData:responseObject];
                                           
                                           if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                           
                                               [weakSelf.m_delegate requestSucess:weakSelf data:weakSelf.m_serializerResponseData];
                                           }
        
                                     } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
                                         weakSelf.m_isRunning = NO;
                                         
                                         if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                             
                                             [weakSelf.m_delegate requestFailed:weakSelf error:error];
                                         }
    }];
}

- (void)accessPostRequest {

    self.m_isRunning = NO;
    
    __weak Networking *weakSelf = self;
    
    self.m_httpOperation = [self.m_manager POST:self.m_urlStr
                                     parameters:[self.m_requestParameterSerializer serializeRequestParameter:self.m_requestParameter]
                                        success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                         
                                            weakSelf.m_isRunning              = NO;
                                            weakSelf.m_originalResponseData   = responseObject;
                                            weakSelf.m_serializerResponseData = [weakSelf.m_responseDataSerializer serializeResponseData: responseObject];
                                            
                                            if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                                
                                                [weakSelf.m_delegate requestSucess:weakSelf data:weakSelf.m_serializerResponseData];
                                            }
                                            
                                     } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                         
                                         weakSelf.m_isRunning = NO;
                                         
                                         if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                             
                                             [weakSelf.m_delegate requestFailed:weakSelf error:error];
                                         }
                                         
                                     }];

}

- (void)safetySetKey: (NSString*)key object: (id)object {

    if (object) {
        
        [self.m_networkingInfo setObject:object forKey:key];
    }
}

- (void)cancelRequest {

    [self.m_httpOperation cancel];
}

+ (id)getMethodNetworkingWithUrlStr:(NSString *)urlStr
                   requestParameter:(id)requestParameter
                    requestBodyType:(RequestBodyType *)requestBodyType
                   responseDataType:(ResponseDataType *)responseDataType {

    Networking *networking = [Networking new];
    
    networking.m_urlStr           = urlStr;
    networking.m_requestParameter = requestParameter;
    
    if (requestBodyType) {
        
        networking.m_requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.m_responseDataType = responseDataType;
    }
    
    return networking;
}
                            
+ (id)postMethodNetworkingWithUrlStr:(NSString *)urlStr
                    requestParameter:(id)requestParameter
                     requestBodyType:(RequestBodyType *)requestBodyType
                    responseDataType:(ResponseDataType *)responseDataType {

    Networking *networking = [Networking new];
    
    networking.m_urlStr           = urlStr;
    networking.m_requestParameter = requestParameter;
    networking.m_mehtod           = [PostMethod type];
    
    if (requestBodyType) {
        
        networking.m_requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.m_responseDataType = responseDataType;
    }
    
    return networking;
}

@end
