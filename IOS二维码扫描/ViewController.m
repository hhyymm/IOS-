//
//  ViewController.m
//  IOS二维码扫描
//
//  Created by HYM on 15/1/28.
//  Copyright (c) 2015年 HYM. All rights reserved.
//

#import "ViewController.h"

#pragma mark 扫码

#import "QRSystemVC.h"

#import "ZBarQRVC.h"


#pragma mark 生成

#import "LibQrenCodeVC.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark -
#pragma mark 扫码
- (IBAction)systemQRScan:(id)sender {
    [self.navigationController pushViewController:[[QRSystemVC alloc] init] animated:YES];
}
- (IBAction)ZBar:(id)sender {
    [self.navigationController pushViewController:[[ZBarQRVC alloc] initWithNibName:@"ZBarQRVC" bundle:[NSBundle mainBundle]] animated:YES];

}
- (IBAction)Zxing:(id)sender {
}

#pragma mark -
#pragma mark 生成二维码  
- (IBAction)系统生成:(id)sender {
    
    
}



// 利用 libqrencode 生成
- (IBAction)LibQrenCode:(id)sender {
    
    LibQrenCodeVC *vc = [[LibQrenCodeVC alloc]initWithNibName:@"LibQrenCodeVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
