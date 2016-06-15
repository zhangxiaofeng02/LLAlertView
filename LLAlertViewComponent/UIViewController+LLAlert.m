//
//  UIViewController+LLAlert.m
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "UIViewController+LLAlert.h"
#import <objc/runtime.h>
#import "LLAlertController.h"

@implementation UIViewController (LLAlert)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(ll_presentViewController:animated:completion:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)ll_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void(^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[LLAlertController class]]) {
        [(LLAlertController *)viewControllerToPresent ll_showInView:self.view];
    } else {
        [self ll_presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}
@end
