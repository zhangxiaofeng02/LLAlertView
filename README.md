# LLAlertView
支持所有iOS版本的alertview，简单的调用接口
没有代码侵染，使用runtime动态替换类，使得iOS各个版本都可以使用.
只需要引入<pre><code>LLAlertView.h</pre></code>即可

# Use
<b1>Display AlertView</b1>
<pre><code>[LLAlertView showAlertViewWithTitle:@"测试用的title"
                               message:@"测试用的message"
                     cancelButtonTitle:@"取消"
                      otherButtonTitle:@"确认"
                        cancleCallBack:^(NSArray<UITextField *> *textFieldArr) {
                             NSLog(@"点了取消");
                     } confirmCallBack:^(NSArray<UITextField *> *textFieldArr) {
                             NSLog(@"点了确认");
                      } textFieldCount:0];</pre></code>

<b1>Display AlertView</b1>
<pre><code>void(^firstBlock)() = ^{
        NSLog(@"点了第一个action");
    };
    void(^secondBlock)() = ^{
        NSLog(@"点了第二个action");
    };
    [LLAlertView showActionSheetWithTitle:@"测试用的title"
                                  message:@"测试用的message"
                              cancleTitle:@"取消"
                           cancleCallBack:^(NSString *txt) {
                                NSLog(@"点了取消");
                           } actionTitle:@[@"第一个title",@"第二个title"]
                             actionBlock:@[firstBlock,secondBlock]];</pre></code>
