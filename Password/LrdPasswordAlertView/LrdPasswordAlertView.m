//
//  LrdPasswordAlertView.m
//  PasswordAlert
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "LrdPasswordAlertView.h"
#import "Masonry.h"

#define kPasswordLength 6
//textField中的竖线
#define kLineTag 1000
//textFiled中的星号显示
#define kDotTag 3000

#define textFieldWidth [UIScreen mainScreen].bounds.size.width - 50 * 2 - 10 * 2
#define textFieldHeight 35

@interface LrdPasswordAlertView () <UITextFieldDelegate>

//背景
@property (nonatomic, strong) UIView *backgroundView;
//线条
@property (nonatomic, strong) UILabel *lineLabel;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//密码框
@property (nonatomic, strong) LrdTextField *inputTextFiled;
//中间的View
@property (nonatomic, strong) UIView *centerView;
//关闭按钮
@property (nonatomic, strong) UIButton *closeBuuton;

@end


@implementation LrdPasswordAlertView

//重写 init 方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //后面黑色背景
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:self.backgroundView];
        
        //中间的view
        self.centerView = [[UIView alloc] init];
        self.centerView.backgroundColor = [UIColor whiteColor];
        self.centerView.layer.masksToBounds = YES;
        self.centerView.layer.cornerRadius = 5;
        [self addSubview:self.centerView];
        
        //初始化各种子控件
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"请输入交易密码";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.centerView addSubview:self.titleLabel];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = [UIColor grayColor];
        [self.centerView addSubview:self.lineLabel];
        
        self.inputTextFiled = [[LrdTextField alloc] init];
        self.inputTextFiled.backgroundColor = [UIColor whiteColor];
        self.inputTextFiled.layer.masksToBounds = YES;
        self.inputTextFiled.layer.borderColor = [UIColor grayColor].CGColor;
        self.inputTextFiled.layer.borderWidth = 1;
        self.inputTextFiled.layer.cornerRadius = 5;
        self.inputTextFiled.secureTextEntry = YES;
        self.inputTextFiled.delegate = self;
        self.inputTextFiled.tintColor = [UIColor clearColor];//看不到光标
        self.inputTextFiled.textColor = [UIColor clearColor];//看不到输入内容
        self.inputTextFiled.font = [UIFont systemFontOfSize:30];
        self.inputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        self.inputTextFiled.pattern = [NSString stringWithFormat:@"^\\d{%li}$",(long)kPasswordLength - 1];
        [self.inputTextFiled addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
        [self.centerView addSubview:self.inputTextFiled];
        
        //关闭按钮
        self.closeBuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBuuton setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        [self.closeBuuton addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:self.closeBuuton];
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI {
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(150);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.equalTo(@160);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_top).offset(30);
        make.left.equalTo(self.centerView.mas_left);
        make.right.equalTo(self.centerView.mas_right);
    }];

    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.centerView.mas_left).offset(15);
        make.right.equalTo(self.centerView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel.mas_bottom).offset(20);
        make.left.equalTo(self.centerView.mas_left).offset(10);
        make.right.equalTo(self.centerView.mas_right).offset(-10);
        make.height.mas_equalTo(@35);
    }];
    [self textFieldAddSubview];
    
    [self.closeBuuton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_top).offset(5);
        make.left.equalTo(self.centerView.mas_left).offset(5);
    }];
}

#pragma mark 监听textField的值改变事件
- (void)textFiledEdingChanged {
    NSInteger length = self.inputTextFiled.text.length;
    NSLog(@"%ld", length);
    if (length == kPasswordLength) {
        [self dissmiss];
    }
    for(NSInteger i=0;i<kPasswordLength;i++){
        UILabel *dotLabel = (UILabel *)[self.inputTextFiled viewWithTag:kDotTag + i];
        if(dotLabel){
            dotLabel.hidden = length <= i;
        }
    }
}

- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    //动画效果
    self.centerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.centerView.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.centerView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.inputTextFiled becomeFirstResponder];
    }];
}

- (void)dissmiss {
    //取消掉键盘
    [self endEditing:YES];
    [UIView animateWithDuration:.35 animations:^{
        self.centerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.centerView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
    if (_block) {
        _block(self.inputTextFiled.text);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.centerView]) {
        [self dissmiss];
    }
}

- (void) closeWindow {
    [self dissmiss];
}

//添加竖线和星号
- (void)textFieldAddSubview {
    CGFloat perWidth = (textFieldWidth - kPasswordLength + 1)*1.0/kPasswordLength;
    for(NSInteger i=0;i<kPasswordLength;i++){
        //画出分割线
        if(i < kPasswordLength - 1){
            UILabel *vLine = (UILabel *)[self.inputTextFiled viewWithTag:kLineTag + i];
            if(!vLine){
                vLine = [[UILabel alloc]init];
                vLine.tag = kLineTag + i;
                [self.inputTextFiled addSubview:vLine];
            }
            vLine.frame = CGRectMake(perWidth + (perWidth + 1)*i, 0, 1, textFieldHeight);
            vLine.backgroundColor = [UIColor grayColor];
        }
        //星号输入
        UILabel *dotLabel = (UILabel *)[self.inputTextFiled viewWithTag:kDotTag + i];
        if(!dotLabel){
            dotLabel = [[UILabel alloc]init];
            dotLabel.tag = kDotTag + i;
            [self.inputTextFiled addSubview:dotLabel];
        }
        dotLabel.frame = CGRectMake((perWidth + 1)*i + (perWidth - 10)*0.5, (textFieldHeight - 10)*0.5, 10, 10);
        dotLabel.layer.masksToBounds = YES;
        dotLabel.layer.cornerRadius = 5;
        dotLabel.backgroundColor = [UIColor blackColor];
        dotLabel.hidden = YES;
    }
}

- (void)dealloc {
    [self.inputTextFiled removeTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
}

@end


#pragma mark LrdTextField的实现
@implementation LrdTextField

//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController){
        menuController.menuVisible = NO;
    }
    return NO;
}

@end
