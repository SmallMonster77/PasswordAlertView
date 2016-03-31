# PasswordAlertView

仿微信支付时的弹窗效果

效果如图:<br>
![](http://lrdup888.qiniudn.com/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98%E5%BC%B9%E7%AA%97%E6%95%88%E6%9E%9C.gif)

## 使用方法
将LrdPasswordAlertView这个文件夹拖入到你的项目中去，并且还需要Masonry这个第三方框架。<br>
block是当密码输入完成后调用的，text则为你输入的密码。<br>
你可以如下面代码类似去调用它：
```Objective-C
- (IBAction)pop:(id)sender {
    LrdPasswordAlertView *testView = [[LrdPasswordAlertView alloc] initWithFrame:self.view.bounds];
    testView.block = ^(NSString *text){
        NSLog(@"调用了block");
    };
    [testView pop];
}
```

###2016/3/31日更新
可以自定义标题，字号，label会随着标题的长度而动态增长

效果:<br>
![](http://lrdup888.qiniudn.com/%E6%A0%87%E9%A2%98%E5%8A%A8%E6%80%81%E5%A2%9E%E9%95%BF.gif)

喜欢就给颗星呗~ 

我的博客地址:[我的博客](http://www.lrdup.net "键盘上的舞者")
