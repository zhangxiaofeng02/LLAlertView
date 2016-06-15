//
//  LLAlertView.h
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ConfirmCallBack)(NSArray<UITextField *> *textFieldArr);
typedef void (^CancleCallBack)(NSArray<UITextField *> *textFieldArr);

typedef void(^ActionCallBack)(NSString *);
typedef void(^ActionCancleCallBack)(NSString *);

@interface LLAlertView : UIView

+ (id)showAlertViewWithTitle:(NSString *)aTitle
                     message:(NSString *)aMessage
           cancelButtonTitle:(NSString *)cancel
            otherButtonTitle:(NSString *)other
              cancleCallBack:(CancleCallBack)cancleBlock
             confirmCallBack:(ConfirmCallBack)confirmBlock
              textFieldCount:(NSInteger)count;

+ (id)showActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   cancleTitle:(NSString *)cancle
                cancleCallBack:(ActionCancleCallBack)cancleCallBack
                   actionTitle:(NSArray<NSString *> *)titlesArr
                   actionBlock:(NSArray<ActionCallBack> *)blockArr;
@end
