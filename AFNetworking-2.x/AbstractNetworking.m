//
//  AbstractNetworking.m
//  AFNetworking-2.x
//
//  Created by FrankLiu on 16/3/16.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "AbstractNetworking.h"

@implementation AbstractNetworking

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.m_mehtod                     = [GetMethod type];
    self.m_requestBodyType            = [HttpBodyType type];
    self.m_responseDataType           = [HttpDataType type];
    self.m_requestParameterSerializer = [AbstractRequestParameterSerializer new];
    self.m_responseDataSerializer     = [AbstractRequestDataSerializer new];
    self.m_HTTPHeaderFieldsWithValues = [NSMutableDictionary dictionary];
    self.m_networkingInfo             = [NSMutableDictionary dictionary];
    self.m_timeoutInterval              = @5;
    
}

- (void)startRequest {
    
    [NSException raise:@"Networking startRequest"
                format:@"You must override this method."];
}

- (void)cancelRequest {
    
    [NSException raise:@"Networking cancelRequest"
                format:@"You must override this method."];
}

+ (id)getMethodNetworkingWithUrlStr:(NSString *)urlStr
                   requestParameter:(id)requestParameter
                    requestBodyType:(RequestBodyType *)requestBodyType
                   responseDataType:(ResponseDataType *)responseDataType {
    
    [NSException raise:@"Networking getMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

+ (id)postMethodNetworkingWithUrlStr:(NSString *)urlStr
                    requestParameter:(id)requestParameter
                     requestBodyType:(RequestBodyType *)requestBodyType
                    responseDataType:(ResponseDataType *)responseDataType {
    
    [NSException raise:@"Networking postMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

@end


