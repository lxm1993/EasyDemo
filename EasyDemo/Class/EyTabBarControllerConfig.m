//
//  EyTabBarControllerConfig.m
//  EasyDemo
//
//  Created by lihua on 16/3/22.
//  Copyright © 2016年 sogouSearch. All rights reserved.
//

#import "EyTabBarControllerConfig.h"

@import Foundation;
@import UIKit;
@interface  EyBaseNavigationController : UINavigationController
@end

@implementation EyBaseNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [(CYLTabBarController*)self.tabBarController rootWindow].backgroundColor  = [UIColor whiteColor];
    
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    

}

@end

//View Controllers
#import "EyHomeViewController.h"
#import "EyMainViewController.h"

@interface EyTabBarControllerConfig()

@end

@implementation EyTabBarControllerConfig

-(CYLTabBarController *)tabBarController{

    if (_tabBarController == nil) {
        EyHomeViewController * homeViewController = [[EyHomeViewController alloc]init];
        homeViewController.title = @"首页";
        UIViewController *homeNavigationController = [[EyBaseNavigationController alloc]
                                                       initWithRootViewController:homeViewController];
        
        EyMainViewController * mainViewController = [[EyMainViewController alloc]init];
        mainViewController.title = @"个人";
        UIViewController *mainNavigationController = [[EyBaseNavigationController alloc]
                                                       initWithRootViewController:mainViewController];
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
        [tabBarController setViewControllers:@[
                                               homeNavigationController,
                                               mainNavigationController,
                                               ]];
        // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
#warning IF YOU NEED CUSTOMIZE TABBAR APPEARANCE, REMOVE THE COMMENT '//'
        //        [[self class] customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;

        
    }
    return _tabBarController;

}
/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
+ (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    NSUInteger allItemsInTabBarCount = [CYLTabBarController allItemsInTabBarCount];
    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor yellowColor] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / allItemsInTabBarCount, 49.f) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}
@end
