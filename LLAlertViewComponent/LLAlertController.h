//
//  LLAlertController.h
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LLAlertAction.h"

typedef NS_ENUM(NSInteger,LLAlertControllerStyle) {
    LLAlertControllerStyleActionSheet = 0,
    LLAlertControllerStyleAlert
};

@interface LLAlertController : NSObject

@property (nonatomic, readonly) NSArray<LLAlertAction *> *actions;
@property (nonatomic, readonly) NSArray<UITextField *> *textFields;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) LLAlertAction *preferredAction;
@property (nonatomic, readonly) LLAlertControllerStyle preferredStyle;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(LLAlertControllerStyle)preferredStyle;
- (void)addAction:(LLAlertAction *)action;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

- (void)ll_showInView:(UIView *)aView;
@end
