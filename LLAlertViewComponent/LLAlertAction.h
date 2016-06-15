//
//  LLAlertAction.h
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LLAlertActionStyle){
    LLAlertActionStyleDefault = 0,
    LLAlertActionStyleCancle,
    LLAlertActionStyleDestructive
};

@class LLAlertAction;

typedef void(^LLAlertBlock)(LLAlertAction *alertAction);

@interface LLAlertAction :NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) LLAlertActionStyle style;
@property (nonatomic, copy) LLAlertBlock handler;
@end
