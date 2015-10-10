//
//  EmbedReaderViewController.h
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface EmbedReaderViewController
    : UIViewController
    < ZBarReaderViewDelegate >
{
    /**
     *  @author HYM, 15-01-29 19:01:23
     *
     *  二维码扫描View图
     */
    ZBarReaderView *readerView;
    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;

@end
