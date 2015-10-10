//
//  ReaderSampleViewController.m
//  ReaderSample
//
//  Created by spadix on 4/14/11.
//

#import "ReaderSampleViewController.h"

@implementation ReaderSampleViewController

@synthesize resultImage, resultText;

- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    /**
     *  @author HYM, 15-01-29 19:01:16
     *
     *  支持方向
     */
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;

    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here

    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

    // present and release the controller
    [self presentViewController:reader animated:YES completion:^{
        
    }];

}

/**
 *  @author HYM, 15-01-29 19:01:48
 *  UIImagePickerController 代理方法
 *
 *  @param reader 自身self
 *  @param info   信息
 */
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    /**
     *  @author HYM, 15-01-29 19:01:43
     *
     *  获取信息对象
     */
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)//取出对象
        // EXAMPLE: just grab the first barcode
        break;

    
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;// 信息对象 中 字符串

    // EXAMPLE: do something useful with the barcode image
    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];

    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    
    [reader dismissViewControllerAnimated:YES completion:^{
        
    }];
    //    [reader dismissModalViewControllerAnimated: YES];
}








- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) dealloc {
    self.resultImage = nil;
    self.resultText = nil;
}

@end
