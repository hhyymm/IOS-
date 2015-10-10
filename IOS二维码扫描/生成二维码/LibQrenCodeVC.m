//
//  LibQrenCodeVC.m
//  IOS二维码扫描
//
//  Created by HYM on 15/1/30.
//  Copyright (c) 2015年 HYM. All rights reserved.
//

#import "LibQrenCodeVC.h"

#import "QRCodeGenerator.h"

@interface LibQrenCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@end

@implementation LibQrenCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.QRImageView.image = [QRCodeGenerator qrImageForString:@"http://www.baidu.com" imageSize:CGRectGetWidth(self.QRImageView.frame) withPointType:QRPointRound withPositionType:QRPositionRound withColor:[UIColor blueColor]];

    // Do any additional setup after loading the view from its nib.
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
