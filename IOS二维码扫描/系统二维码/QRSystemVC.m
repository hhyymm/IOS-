//
//  QRSystemVC.m
//  IOS二维码扫描
//
//  Created by HYM on 15/1/28.
//  Copyright (c) 2015年 HYM. All rights reserved.
//

#import "QRSystemVC.h"

@interface QRSystemVC ()
{
    NSTimer *_timer;
    UIImageView *_imageView;

    UIImageView *_lineImageView;
}
@end

@implementation QRSystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizingMask = YES;
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self initUiConfig];
}


- (void)initUI:(CGRect)previewFrame
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (error) {
        
        if ([self.delegate respondsToSelector:@selector(qrCodeError:)]) {
            [self.delegate qrCodeError:error];
        }
        
        NSLog(@"你手机不支持二维码扫描!");
        return;
    }
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    self.session = [[AVCaptureSession alloc]init];
    
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    // 设置支持编码详见链接 条形码／二维码 http://baike.baidu.com/link?url=OlRd2WD3pT_nD_crHl_FvfiKEKtSm9iSqnqCLQFE5Z2I_9m1rXO-4pVwoLnAwiJcZF--ghRVaUjAhWOEznQ8VK#9
    
    
    /**
     *   AVCaptureVideoPreviewLayer  A CoreAnimation layer subclass for previewing
     *   the visual output of an AVCaptureSession
     *   将捕获器访入Layer中
     */
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    //.

    
    /**
     *  相当于 视图的contentMode 
     *  AVLayerVideoGravityResizeAspect 适应 （调整宽高比例，即放大缩小，显示全部）
     *  AVLayerVideoGravityResizeAspectFill 填充 （原比例填满，显示部分）
     *  AVLayerVideoGravityResize 拉伸 （，显示全部）
     */
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = previewFrame;
    
    [self.view.layer addSublayer:self.preview];//
    
    /**
     *  详见<AVCaptureSession.h>
     *  //调整 视频 图像质量
     */
    if ([UIScreen mainScreen].bounds.size.height == 480)
    {
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    else
    {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        //调整分辨率
    }
    
    [self.session startRunning];//捕捉起开始运行
}

//捕捉器 捕捉到 制定类型的图案
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    
//    [self.session stopRunning];//捕捉器停止运行
    
//    [self.preview removeFromSuperlayer];//移除layer
    
    NSString *val = nil;
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        //        AVMetadataMachineReadableCodeObject is a concrete subclass of AVMetadataObject defining the features of a detected one-dimensional or two-dimensional barcode.
        //        AVMetadataMachineReadableCodeObject AVMetadataObject的具体子类定义的特性检测一维或二维条形码。
        // 检测一维或二维条形码 的类
        val = obj.stringValue;// 图案内容
        NSArray *arr = obj.corners;//边界点 （范围：0-1）
        
        /**
         *  显示在导航标题上
         */
        self.title = val;
        
        /**
         *
         */
        if ([self.delegate respondsToSelector:@selector(qrCodeComplete:)]) {
            [self.delegate qrCodeComplete:val];
        }
    }
}



- (void)initUiConfig
{
    //初始化 扫描控件
    [self initUI:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    
    
    /**  加载界面想要添加的元素与扫描二维码无关
     */
    

    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    _imageView.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 140, self.view.bounds.size.height * 0.5 - 140, 280, 280);
    [self.view addSubview:_imageView];
    
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"line.png"];
    [_imageView addSubview:_lineImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnClick:)];
    
    
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}



- (void)animation
{
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(30, 10, 220, 2);
    }];
}

- (void)cancelBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
////    UIInterfaceOrientationUnknown
////    UIInterfaceOrientationPortrait
////    UIInterfaceOrientationPortraitUpsideDown
////    ,
////    UIInterfaceOrientationLandscapeLeft
////    UIInterfaceOrientationLandscapeRight
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        self.preview.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
////        self.preview.affineTransform = CGAffineTransformMakeRotation(M_PI_2);
//    }else
//    {
//        self.preview.affineTransform = CGAffineTransformIdentity;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
