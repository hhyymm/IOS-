//
//  EmbedReaderViewController.m
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

#import "EmbedReaderViewController.h"

@implementation EmbedReaderViewController

@synthesize readerView, resultText;

- (void) cleanup
{
//    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
//    [readerView release];
    readerView = nil;
//    [resultText release];
    resultText = nil;
}

- (void) dealloc
{
    [self cleanup];
//    [super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // the delegate receives decode results
    readerView = [[ZBarReaderView alloc]init];
    readerView.frame = CGRectMake(0, 64, 320, 200);
    readerView.readerDelegate = self;
    [self.view addSubview:readerView];

//    /**
//     *  @author HYM, 15-01-29 20:01:35
//     *
//     *  配置解码器
//     */
//    ZBarImageScanner *scanner = readerView.scanner;
//    /**
//     *  @author HYM, 15-01-29 20:01:31
//     *
//     *  信息码编码 类型  信息码支持信息 内容 类型
//     */
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    
//    /*
//        // decoder configuration
//        - (void) parseConfig: (NSString*) configStr;
//        - (void) setSymbology: (zbar_symbol_type_t) symbology
//    config: (zbar_config_t) config
//    to: (int) value;
//        
//        // image scanning interface
//        - (NSInteger) scanImage: (ZBarImage*) image;
//    */
    
    

    // you can use this to support the simulator
    //支持 模拟器 从相册中选择图片
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                        initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    
    /**
     *  @author HYM, 15-01-29 19:01:38
     *
     *  旋转方向 支持设备方向
     */
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    
    
    /**
     *  @author HYM, 15-01-29 19:01:26
     *
     *  开启扫描器
     */
    [readerView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    /**
     *  @author HYM, 15-01-29 19:01:41
     *
     *  关闭扫描器
     */
    [readerView stop];
}
/**
 *  @author HYM, 15-01-29 19:01:54
 *
 *  获取信息对象成功
 *
 *  @param view ZBarReaderView 自身
 *  @param syms ZBarSymbolSet  （信息码类的集合 如同NSSet）
                ZBarSymbol 具体类型参见 ZBarSymbolSet 的属性 （zbar_symbol_type_t）type;
 *  @param img
 */
- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    // ZBarSymbol 信息码 的 单个类
    //
    for(ZBarSymbol *sym in syms) {
        resultText.text = sym.data;
        
        break;
    }
}

@end
