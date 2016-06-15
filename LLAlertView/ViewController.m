//
//  ViewController.m
//  LLAlertView
//
//  Created by 啸峰 on 16/6/15.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "ViewController.h"
#import "LLAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //添加alert测试按钮
    UIButton *alertButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 120)];
    [alertButton setTitle:@"弹出alert" forState:UIControlStateNormal];
    [alertButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [alertButton setBackgroundColor:[UIColor blueColor]];
    alertButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [alertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:alertButton];
    [alertButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *consArr = [[NSMutableArray alloc] init];
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(self.view,alertButton);
    [consArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-30-[alertButton(%f)]",80.0] options:0 metrics:nil views:viewDic]];
    [consArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-120-[alertButton(%f)]",40.0] options:0 metrics:nil views:viewDic]];
    [self.view addConstraints:consArr];
    
    //添加actionSheet测试按钮
    UIButton *sheetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 120)];
    [sheetButton setTitle:@"弹出sheet" forState:UIControlStateNormal];
    [sheetButton addTarget:self action:@selector(showSheet) forControlEvents:UIControlEventTouchUpInside];
    [sheetButton setBackgroundColor:[UIColor blueColor]];
    [sheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sheetButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:sheetButton];
    [sheetButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *consArr2 = [[NSMutableArray alloc] init];
    NSDictionary *viewDic2 = NSDictionaryOfVariableBindings(self.view,sheetButton);
    [consArr2 addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-30-[sheetButton(%f)]",80.0] options:0 metrics:nil views:viewDic2]];
    [consArr2 addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-180-[sheetButton(%f)]",40.0] options:0 metrics:nil views:viewDic2]];
    [self.view addConstraints:consArr2];
    
    //添加说明label
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"LLAlertView - 简单的API接口，支持iOS7，8，9所有版本的alert，sheet调用！"];
    label.numberOfLines = 3;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *consArr3 = [[NSMutableArray alloc] init];
    NSDictionary *viewDict3 = NSDictionaryOfVariableBindings(self.view,label);
    [consArr3 addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[label]-0-|"] options:0 metrics:nil views:viewDict3]];
    [consArr3 addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[label(%f)]",66.0] options:0 metrics:nil views:viewDict3]];
    [consArr3 addObject:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraints:consArr3];
    
}

- (void)showAlert {
    [LLAlertView showAlertViewWithTitle:@"测试用的title"
                                message:@"测试用的message"
                      cancelButtonTitle:@"取消"
                       otherButtonTitle:@"确认"
                         cancleCallBack:^(NSArray<UITextField *> *textFieldArr) {
                             NSLog(@"点了取消");
                         } confirmCallBack:^(NSArray<UITextField *> *textFieldArr) {
                             NSLog(@"点了确认");
                         } textFieldCount:0];
}

- (void)showSheet {
    void(^firstBlock)() = ^{
        NSLog(@"点了第一个action");
    };
    void(^secondBlock)() = ^{
        NSLog(@"点了第二个action");
    };
    [LLAlertView showActionSheetWithTitle:@"测试用的title"
                                  message:@"测试用的message"
                              cancleTitle:@"取消"
                           cancleCallBack:^(NSString *txt) {
        
                           } actionTitle:@[@"第一个title",@"第二个title"]
                             actionBlock:@[firstBlock,secondBlock]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
