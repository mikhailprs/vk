//
//  UrlContainer.m
//  VK
//
//  Created by Mikhail Prysiazhniy on 11.09.16.
//  Copyright © 2016 Mikhail Prysiazhniy. All rights reserved.
//

#import "UrlContainer.h"

// https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V

NSString *const urlScheme                       = @"https://";
NSString *const platfromDomain                  = @"cfdapi.wmoption-stage.com";

@implementation UrlContainer

+ (instancetype)sharedContainer{
    static UrlContainer *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (NSString *)urlAuthorizationDemo{
    return [NSString stringWithFormat:@"%@%@/usercabinet/auth_mobile", urlScheme, platfromDomain];
}

@end
