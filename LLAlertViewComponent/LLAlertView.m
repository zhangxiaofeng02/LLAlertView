//
//  LLAlertView.m
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LLAlertView.h"

@implementation LLAlertView

+ (id)showAlertViewWithTitle:(NSString *)aTitle
                     message:(NSString *)aMessage
           cancelButtonTitle:(NSString *)cancel
            otherButtonTitle:(NSString *)other
              cancleCallBack:(CancleCallBack)cancleBlock
             confirmCallBack:(ConfirmCallBack)confirmBlock
              textFieldCount:(NSInteger)count {
    if (!aTitle) {
        aTitle = @"";
    }
    if (!aMessage) {
        aMessage = @"";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:aTitle message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancel && cancel.length) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock(alertController.textFields);
            }
        }]];
    }
    if (other && other.length) {
        [alertController addAction:[UIAlertAction actionWithTitle:other style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock(alertController.textFields);
            }
        }]];
    }
    
    
    if (count) {
        for (int i =0 ; i<count; i++) {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"";
            }];
        }
    }
    
    UIViewController *viewController = (UIViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    while (viewController.presentedViewController && ![viewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
        viewController = viewController.presentedViewController;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (id)showActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   cancleTitle:(NSString *)cancle
                cancleCallBack:(ActionCancleCallBack)cancleCallBack
                   actionTitle:(NSArray<NSString *> *)titlesArr
                   actionBlock:(NSArray<ActionCallBack> *)blockArr {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (titlesArr.count != blockArr.count) {
        return nil;
    }
    for (int i = 0; i<titlesArr.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:titlesArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (blockArr[i]) {
                blockArr[i](action.title);
            }
        }]];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancleCallBack) {
            cancleCallBack(action.title);
        }
    }]];
    
    UIViewController *viewController = (UIViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    while (viewController.presentedViewController && ![viewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
        viewController = viewController.presentedViewController;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
@end
