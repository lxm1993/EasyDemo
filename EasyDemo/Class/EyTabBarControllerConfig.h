//
//  EyTabBarControllerConfig.h
//  EasyDemo
//
//  Created by lihua on 16/3/22.
//  Copyright © 2016年 sogouSearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface EyTabBarControllerConfig : NSObject

@property(nonatomic,readwrite,strong)CYLTabBarController  *tabBarController;


+ (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController;


@end
