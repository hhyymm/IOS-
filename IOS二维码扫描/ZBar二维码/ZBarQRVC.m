//
//  ZBarQRVC.m
//  IOS二维码扫描
//
//  Created by HYM on 15/1/29.
//  Copyright (c) 2015年 HYM. All rights reserved.
//

#import "ZBarQRVC.h"
// 用zbar 的 VC 读取
#import "ReaderSampleViewController.h"
// 用zbar 的 View 读取
#import "EmbedReaderViewController.h"

@interface ZBarQRVC ()

@end

@implementation ZBarQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  @author HYM, 15-01-29 19:01:45
 *
 *  用 ZBarReaderViewController 扫描
 *
 *  @param sender
 */
- (IBAction)VCScan:(id)sender {
    
    ReaderSampleViewController *readVC = [[ReaderSampleViewController alloc]initWithNibName:@"ReaderSampleViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:readVC animated:YES];
}



/**
 *  @author HYM, 15-01-29 19:01:06
 *
 *  用 ZBarReaderView 读取
 *
 *  @param sender
 */
- (IBAction)ViewScan:(id)sender {
    
    EmbedReaderViewController *readVC = [[EmbedReaderViewController alloc]initWithNibName:@"EmbedReaderViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:readVC animated:YES];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
