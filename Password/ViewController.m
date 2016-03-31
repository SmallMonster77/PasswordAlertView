//
//  ViewController.m
//  Password
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "ViewController.h"
#import "LrdPasswordAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pop:(id)sender {
    LrdPasswordAlertView *testView = [[LrdPasswordAlertView alloc] initWithFrame:self.view.bounds];
    testView.titleName = @"标题就是要长，就是要这么长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长\n长长长长长长长长长长长\n长长长长长长长长长长长长长";
    testView.fontSize = 17.f;
    testView.block = ^(NSString *text){
        NSLog(@"调用了block");
    };
    [testView pop];
}

@end
