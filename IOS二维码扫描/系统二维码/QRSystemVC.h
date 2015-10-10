//
//  QRSystemVC.h
//  IOS二维码扫描
//
//  Created by HYM on 15/1/28.
//  Copyright (c) 2015年 HYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol QRSystemDelegate <NSObject>

- (void)qrCodeComplete:(NSString *)codeString;

- (void)qrCodeError:(NSError *)error;

@end

@interface QRSystemVC : UIViewController<AVCaptureMetadataOutputObjectsDelegate>


@property(assign,nonatomic)id<QRSystemDelegate> delegate;

@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong, nonatomic)AVCaptureSession *session;

@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;

@end
