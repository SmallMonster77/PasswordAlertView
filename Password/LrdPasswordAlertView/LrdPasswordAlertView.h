//
//  LrdPasswordAlertView.h
//  PasswordAlert
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTReTextField.h"

typedef void (^successBlock)(NSString *text);

@interface LrdPasswordAlertView : UIView

//关闭或者密码输入完成时候调用的block
@property (nonatomic, strong) successBlock block;

//自定义标题,默认标题为:"请输入交易密码"
@property (nonatomic, strong) NSString *titleName;
//自定义标题字体,默认为加粗，字号为17号
@property (nonatomic, assign) CGFloat fontSize;

//弹出
- (void)pop;

//关闭
- (void)dissmiss;

@end

@interface LrdTextField : WTReTextField



@end