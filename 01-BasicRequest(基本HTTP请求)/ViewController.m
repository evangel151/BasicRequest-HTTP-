//
//  ViewController.m
//  01-BasicRequest(基本HTTP请求)
//
//  Created by  a on 16/3/30.
//  Copyright © 2016年 eva. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

- (IBAction)login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 点击屏幕其他地方的时候退出编辑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)login {
    // 1. 用户名
    NSString *userNameText = self.userName.text;
    if (userNameText.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    
    // 2. 密码
    NSString *pwdText = self.pwd.text;
    if (pwdText.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
    /**
     接口文档: 定义描述服务器端的请求接口
     1> 请求路径URL: 客户端应该请求哪个路径
     http://localhost:8080/MJServer/login 
     
     2> 请求参数: 客户端要发给服务器的数据
     username - 用户名
     pwd - 密码
     3> 请求结果: 服务器会返回什么东西给客户端
     */
    
    // 如果用户名和密码都不为0 -> 发送用户名和密码到服务器 (使用HTTP协议)
    // 创建一个URL
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login?username=%@&pwd=%@", userNameText, pwdText];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送一个同步请求 (在主线程发送请求)  NSURLConnection 在iOS9中已经不推荐使用
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"%@", data); // 服务器正在工作的话，返回本地服务器数据  (因为转码问题，无法显示汉字)
}
@end
