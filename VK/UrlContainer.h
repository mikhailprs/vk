//
//  UrlContainer.h
//  VK
//
//  Created by Mikhail Prysiazhniy on 11.09.16.
//  Copyright © 2016 Mikhail Prysiazhniy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlContainer : NSObject

+ (instancetype)sharedContainer;

@property (strong, nonatomic, readonly) NSString *urlAuthorizationDemo;

@end
