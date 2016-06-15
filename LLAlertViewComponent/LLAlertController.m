//
//  LLAlertController.m
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LLAlertController.h"
#import <objc/runtime.h>

static LLAlertController *defalultController;

@interface LLAlertController()<UIAlertViewDelegate,UIActionSheetDelegate>
@end

@implementation LLAlertController {
    UIAlertView *_llAlertView;
    UIActionSheet *_llActionSheet;
    NSMutableArray *_alertActionArr;
    NSMutableArray *_alertTextFieldArr;
    LLAlertControllerStyle _style;
}

+ (void)setUpDefaultController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defalultController = [[LLAlertController alloc] init];
        defalultController -> _alertActionArr = [NSMutableArray new];
    });
    if (defalultController -> _alertActionArr.count > 0) {
        [defalultController -> _alertActionArr removeAllObjects];
    }
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(LLAlertControllerStyle)preferredStyle {
    [self setUpDefaultController];
    defalultController -> _style = preferredStyle;
    if (LLAlertControllerStyleActionSheet == preferredStyle) {
        defalultController -> _llActionSheet = [UIActionSheet new];
        defalultController -> _llActionSheet.delegate = defalultController;
        
    } else if (LLAlertControllerStyleAlert == preferredStyle) {
        defalultController -> _llAlertView = [UIAlertView new];
        defalultController -> _llAlertView.message = message;
    }
    defalultController -> _llAlertView.delegate = defalultController;
    defalultController -> _llAlertView.title = title;
    return defalultController;
}

- (void)addAction:(LLAlertAction *)action {
    if (LLAlertControllerStyleAlert == defalultController -> _style) {
        [defalultController -> _llAlertView addButtonWithTitle:action.title];
    } else if (LLAlertControllerStyleActionSheet == defalultController -> _style) {
        [defalultController -> _llActionSheet addButtonWithTitle:action.title];
    }
    [defalultController -> _alertActionArr addObject:action];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler {
    if (LLAlertControllerStyleActionSheet == defalultController -> _style) {
        return;//textField只对alert做处理，不对actionsheet做处理
    }
    if (UIAlertViewStyleLoginAndPasswordInput == defalultController -> _llAlertView.alertViewStyle) {
        return;//由于uialertView的api限制，最多只能有两个TextField,已经有两个了，不做处理，直接返回.
    } else if (UIAlertViewStyleDefault == defalultController -> _llAlertView.alertViewStyle) {
        if (!defalultController -> _alertTextFieldArr) {
            defalultController -> _alertTextFieldArr = [[NSMutableArray alloc] initWithCapacity:2];
        }
        UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        configurationHandler(tempTextField);
        [defalultController -> _alertTextFieldArr addObject:tempTextField];
        if (tempTextField.secureTextEntry) {
            defalultController -> _llAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        } else {
            defalultController -> _llAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        }
        UITextField *alertTextField = [defalultController -> _llAlertView textFieldAtIndex:0];
        [self setValueFrom:tempTextField to:alertTextField];
    } else if (UIAlertViewStylePlainTextInput == defalultController -> _llAlertView.alertViewStyle ||
               UIAlertViewStyleSecureTextInput == defalultController -> _llAlertView.alertViewStyle) {
        UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        configurationHandler(tempTextField);
        [defalultController -> _alertTextFieldArr addObject:tempTextField];
        defalultController -> _llAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        UITextField *alertTextField = [defalultController -> _llAlertView textFieldAtIndex:1];
        [self setValueFrom:tempTextField to:alertTextField];
        [self setValueFrom:defalultController -> _alertTextFieldArr[0] to:[defalultController -> _llAlertView textFieldAtIndex:0]];
    }
}

- (void)ll_showInView:(UIView *)aView {
    if (LLAlertControllerStyleAlert == defalultController -> _style) {
        [defalultController -> _llAlertView show];
    } else if (LLAlertControllerStyleActionSheet == defalultController -> _style) {
        if (aView) {
            [defalultController -> _llActionSheet showInView:aView];
        }
    }
}

#pragma mark - property methods
- (NSArray<LLAlertAction *> *)actions {
    return defalultController -> _alertActionArr;
}

- (void)setPreferredAction:(LLAlertAction *)preferredAction {
    //UIAlertView并不能实现这个属性的功能，这里什么都不做
}

- (LLAlertAction *)preferredAction {
    return nil;
}

- (NSArray<UITextField *> *)textFields {
    if (LLAlertControllerStyleActionSheet == defalultController -> _style) {
        return nil;
    }
    if (UIAlertViewStylePlainTextInput == defalultController -> _llAlertView.alertViewStyle || UIAlertViewStyleSecureTextInput == defalultController -> _llAlertView.alertViewStyle)  {
        return @[[defalultController -> _llAlertView textFieldAtIndex:0]];
    } else if (UIAlertViewStyleLoginAndPasswordInput == defalultController -> _llAlertView.alertViewStyle) {
        return @[[defalultController -> _llAlertView textFieldAtIndex:0],[defalultController -> _llAlertView textFieldAtIndex:1]];
    } else return nil;
}

- (void)setTitle:(NSString *)title {
    if (LLAlertControllerStyleAlert == defalultController->_style) {
        defalultController->_llAlertView.title = title;
    } else if (LLAlertControllerStyleActionSheet == defalultController->_style) {
        defalultController->_llAlertView.title = title;
    }
}

- (NSString *)title {
    if (LLAlertControllerStyleAlert == defalultController->_style) {
        return defalultController->_llAlertView.title;
    } else if (LLAlertControllerStyleActionSheet == defalultController->_style) {
        return defalultController->_llAlertView.title;
    } else return nil;
}

- (void)setMessage:(NSString *)message {
    if (LLAlertControllerStyleAlert == defalultController->_style) {
        defalultController->_llAlertView.message = message;
    } else if (LLAlertControllerStyleActionSheet == defalultController->_style) {
        //actionSheet没有message属性
    }
}

- (NSString *)message {
    if (LLAlertControllerStyleAlert == defalultController->_style) {
        return defalultController->_llAlertView.message;
    } else if (LLAlertControllerStyleAlert == defalultController->_style) {
        //actionSheet没有message属性
        return nil;
    } else return nil;
}

- (LLAlertControllerStyle)preferredStyle {
    return defalultController -> _style;
}

#pragma mark - alert view delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    LLAlertAction *tempAlertAction = (defalultController -> _alertActionArr)[buttonIndex];
    LLAlertBlock tempBlock = tempAlertAction.handler;
    if (tempBlock) {
        tempBlock(tempAlertAction);
    }
}

#pragma mark - actionSheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    LLAlertAction *tempAlertAction = (defalultController -> _alertActionArr)[buttonIndex];
    LLAlertBlock tempBlock = tempAlertAction.handler;
    if (tempBlock) {
        tempBlock(tempAlertAction);
    }
}

#pragma mark - private methods
- (void)setValueFrom:(UITextField *)tempTextField to:(UITextField *)alertTextField {
    //给一些常用属性赋值
    alertTextField.text = tempTextField.text;
    alertTextField.attributedText = tempTextField.attributedText;
    alertTextField.textColor = tempTextField.textColor;
    alertTextField.font = tempTextField.font;
    alertTextField.textAlignment = tempTextField.textAlignment;
    alertTextField.placeholder = tempTextField.placeholder;
    alertTextField.attributedPlaceholder = tempTextField.attributedPlaceholder;
    alertTextField.clearsOnBeginEditing = tempTextField.clearsOnBeginEditing;
    alertTextField.delegate = tempTextField.delegate;
    alertTextField.background = tempTextField.background;
    alertTextField.disabledBackground = tempTextField.disabledBackground;
    alertTextField.clearButtonMode = tempTextField.clearButtonMode;
    alertTextField.leftView = tempTextField.leftView;
    alertTextField.leftViewMode = tempTextField.leftViewMode;
    alertTextField.rightView = tempTextField.rightView;
    alertTextField.rightViewMode = tempTextField.rightViewMode;
    alertTextField.inputView = tempTextField.inputView;
    alertTextField.inputAccessoryView = tempTextField.inputAccessoryView;
    alertTextField.tag = tempTextField.tag;
}
@end

#pragma mark - Runtime Injection

__asm(
      ".section        __DATA,__objc_classrefs,regular,no_dead_strip\n"
#if	TARGET_RT_64_BIT
      ".align          3\n"
      "L_OBJC_CLASS_UIAlertController:\n"
      ".quad           _OBJC_CLASS_$_UIAlertController\n"
#else
      ".align          2\n"
      "_OBJC_CLASS_UIAlertController:\n"
      ".long           _OBJC_CLASS_$_UIAlertController\n"
#endif
      ".weak_reference _OBJC_CLASS_$_UIAlertController\n"
      );

// Constructors are called after all classes have been loaded.
__attribute__((constructor)) static void GJAlertActionPatchEntry(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            // >= iOS8.
            if (objc_getClass("UIAlertController")) {
                return;
            }
            Class *alertController = NULL;
            
#if TARGET_CPU_ARM
            __asm("movw %0, :lower16:(_OBJC_CLASS_UIAlertController-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_UIAlertController-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(alertController));
#elif TARGET_CPU_ARM64
            __asm("adrp %0, L_OBJC_CLASS_UIAlertController@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_UIAlertController@PAGEOFF" : "=r"(alertController));
#elif TARGET_CPU_X86_64
            __asm("leaq L_OBJC_CLASS_UIAlertController(%%rip), %0" : "=r"(alertController));
#elif TARGET_CPU_X86
            void *pc = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_UIAlertController-L0(%0), %1" : "=r"(pc), "=r"(alertController));
#else
#error Unsupported CPU
#endif
            if (alertController && !*alertController) {
                Class class = objc_allocateClassPair([LLAlertController class], "UIAlertController", 0);
                if (class) {
                    objc_registerClassPair(class);
                    *alertController = class;
                }
            }
        }
    });
}