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

//弹出
- (void)pop;

//关闭
- (void)dissmiss;

@end

@interface LrdTextField : WTReTextField



@end