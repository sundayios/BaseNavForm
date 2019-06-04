#import "FB_UIWebViewController.h"
#import "FB_BottomView.h"
#import "FB_NoNetworkAlertView.h"
#import "FB_ProgressView.h"

#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface FB_UIWebViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate,FB_D_BottomViewDelegate,NJKWebViewProgressDelegate>
{
    UIWebView *FB_P_kUIWebView;
    NJKWebViewProgressView *_FB_P_progressView;
    NJKWebViewProgress *_FB_P_progressProxy;
}
@end
@implementation FB_UIWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.FB_P_contentBottomView.delegate = self;
    FB_P_kUIWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, self.view.frame.size.width, MainScreenHeight - StatusBarHeight - self.FB_P_contentBottomView.frame.size.height)];
    FB_P_kUIWebView.delegate = self;
    FB_P_kUIWebView.scrollView.bounces = NO;
    FB_P_kUIWebView.scalesPageToFit = YES;
    [self.view addSubview:FB_P_kUIWebView];
    [self.view addSubview:self.FB_P_contentBottomView];
    if (@available(iOS 11,*)) {
        FB_P_kUIWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

//    UILongPressGestureRecognizer *FB_SP_longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(FB_M_longPressAction:)];
//    FB_SP_longPressGes.delegate = self;
//    FB_SP_longPressGes.minimumPressDuration = 0.35;
//    [FB_P_kUIWebView addGestureRecognizer:FB_SP_longPressGes];
    self.FB_P_networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
    
    _FB_P_progressProxy = [[NJKWebViewProgress alloc] init];
    FB_P_kUIWebView.delegate = _FB_P_progressProxy;
    _FB_P_progressProxy.webViewProxyDelegate = self;
    _FB_P_progressProxy.progressDelegate = self;
    
    CGRect FB_SP_barFrame = CGRectMake(0, StatusBarHeight,MainScreenWidth , PROGRESS_HEIGHT);
    _FB_P_progressView = [[NJKWebViewProgressView alloc] initWithFrame:FB_SP_barFrame];
    _FB_P_progressView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_FB_P_progressView setProgress:0 animated:NO];
    [self.view addSubview:_FB_P_progressView];
    [self.view bringSubviewToFront:_FB_P_progressView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_FB_P_progressView removeFromSuperview];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_FB_P_progressView setProgress:progress animated:YES];
}
-(void)FB_M_showProgress:(BOOL)show{
    _FB_P_progressView.hidden = !show;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)FB_M_longPressAction:(UIGestureRecognizer*)ges{
    if (self.FB_P_isShowAlert == YES) {
        return;
    }
    CGPoint FB_SP_point = [ges locationInView:FB_P_kUIWebView];
    NSString *FB_SP_jsStr = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src",FB_SP_point.x,FB_SP_point.y];
    NSString *FB_SP_imageUrlStr = [FB_P_kUIWebView stringByEvaluatingJavaScriptFromString:FB_SP_jsStr];
    if ([FB_SP_imageUrlStr length] > 0) {
        self.FB_P_isShowAlert = YES;
        UIAlertController *FB_SP_alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:FB_SP_imageUrlStr]
                                                                  options:SDWebImageDownloaderHighPriority
                                                                 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {}
                                                                completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                                }];
            self.FB_P_isShowAlert = NO;
        }]];
        [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.FB_P_isShowAlert = NO;
        }]];
        [self presentViewController:FB_SP_alertController animated:YES completion:nil];
    }
}
- (void)FB_M_performOperationWithStyle:(FB_E_OperationStyle)style{
    switch (style) {
        case FB_E_OperationStyleGoBack:
        {
            if ([FB_P_kUIWebView canGoBack]) {
                [FB_P_kUIWebView goBack];
            }
        }
            break;
        case FB_E_OperationStyleGoForward:
        {
            if ([FB_P_kUIWebView canGoForward]) {
                [FB_P_kUIWebView goForward];
            }
        }
            break;
        case FB_E_OperationStyleRefresh:
        {
            [FB_P_kUIWebView reload];
        }
            break;
        case FB_E_OperationStyleMenu:
        {
            UIAlertController *FB_SP_controller = [UIAlertController alertControllerWithTitle:nil message:@"是否使用浏览器打开?" preferredStyle:UIAlertControllerStyleAlert];
            [FB_SP_controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [FB_SP_controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self FB_M_openContentUseB];
            }]];
            [self presentViewController:FB_SP_controller animated:YES completion:nil];
        }
            break;
        case FB_E_OperationStyleHomePage:
        {
            [self FB_M_loadMainPageContent];
        }
            break;
        default:
            break;
    }
}
- (void)FB_M_openContentUseB{
    NSURL *FB_SP_url = FB_P_kUIWebView.request.URL;
    if (FB_SP_url == nil || [FB_SP_url.absoluteString FB_M_isBlankString]) {
        FB_SP_url = [NSURL URLWithString:self.FB_P_urlString];
    }
    if ([[UIApplication sharedApplication] canOpenURL:FB_SP_url]) {
        [self FB_M_openSuitUrl:FB_SP_url];
    }else{
        [SVProgressHUD showInfoWithStatus:@"加载失败"];
    }
}
#pragma mark 刷新url
-(void)FB_M_refreshUrl{
    NSURL *FB_SP_url = FB_P_kUIWebView.request.URL;
//    if (FB_SP_url == nil || [FB_SP_url.absoluteString FB_M_isBlankString]) {
        [self FB_M_loadMainPageContent];
//    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self FB_M_showProgress:YES];
    [self FB_M_networkWatingViewDismissFromView:webView];
    NSString *FB_SP_urlStr = [NSString stringWithFormat:@"%@",request.URL.absoluteString];
    if ([self FB_M_jumpsToThirdAPP:FB_SP_urlStr]) {
        return NO;
    }
    if ([FB_SP_urlStr hasPrefix:@"itms"] || [FB_SP_urlStr hasPrefix:@"itunes.apple.com"] ) {
        NSURL *FB_SP_url = [NSURL URLWithString:FB_SP_urlStr];
        if ([[UIApplication sharedApplication] canOpenURL:FB_SP_url]) {
            UIAlertController *FB_SP_alertController = [UIAlertController alertControllerWithTitle:nil message:@"在App Store中打开?" preferredStyle:UIAlertControllerStyleAlert];
            [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self FB_M_openSuitUrl:FB_SP_url];
            }]];
            [self presentViewController:FB_SP_alertController animated:YES completion:nil];
            return NO;
        }else{
            [SVProgressHUD showInfoWithStatus:@"跳转失败"];
        }
    }
    NSString *FB_SP_openUseBrowser = @"UseBrowser";
    if ([FB_SP_urlStr hasPrefix:@"my"] || [FB_SP_urlStr rangeOfString:FB_SP_openUseBrowser].location != NSNotFound) {
        NSMutableString *FB_SP_mutableStr=[[NSMutableString alloc]initWithString:FB_SP_urlStr];
        while  ([FB_SP_mutableStr hasPrefix:@"my"]) {
            [FB_SP_mutableStr deleteCharactersInRange:NSMakeRange(0, 2)];
        }
        if ([FB_SP_mutableStr rangeOfString:FB_SP_openUseBrowser].location != NSNotFound) {
            FB_SP_mutableStr = [FB_SP_mutableStr stringByReplacingOccurrencesOfString:FB_SP_openUseBrowser withString:@""].mutableCopy;
        }
        if ([self FB_M_jumpsToThirdAPP:FB_SP_mutableStr]) {
            return NO;
        }else{
            NSURL *FB_SP_url = [NSURL URLWithString:FB_SP_mutableStr];
            if ([[UIApplication sharedApplication] canOpenURL:FB_SP_url]) {
                [self FB_M_openSuitUrl:FB_SP_url];
                    return NO;
            }
        }
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self FB_M_showProgress:NO];
    if ([self FB_M_isAppDomain]) {
        NSString *FB_SP_str=FB_SP_str = @"function getRefs() { \
        var oA = document.getElementsByTagName('a');\
        var length = oA.length;\
        for(var i= 0;i<length;i++){\
        var hreff = oA[i].getAttribute(\"href\");\
        var current = oA[i].getAttribute(\"class\");\
        if(current == 'appweb'){\
        oA[i].setAttribute(\"href\", \"my\" + hreff);}}}\
        getRefs();";
        [FB_P_kUIWebView stringByEvaluatingJavaScriptFromString:FB_SP_str];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self FB_M_showProgress:NO];
    [self FB_M_networkWatingViewDismissFromView:FB_P_kUIWebView];
}
- (BOOL)FB_M_isAppDomain{
    NSString *FB_SP_current = [FB_P_kUIWebView.request.URL absoluteString];
    if ((FB_SP_current == nil || [FB_SP_current FB_M_isBlankString]) ||
        (self.FB_P_urlString == nil || [self.FB_P_urlString FB_M_isBlankString])) {
        return YES;
    }
    NSString *FB_SP_host = [FB_P_kUIWebView.request.URL host];
    if ([self.FB_P_urlString rangeOfString:FB_SP_host].location != NSNotFound) {
        return YES;
    }
    return NO;
}
#pragma mark 加载主页面
- (void)FB_M_loadMainPageContent{
    NSLog(@"self.FB_P_urlString==%@",self.FB_P_urlString);
    NSURL *FB_SP_url = [NSURL URLWithString:self.FB_P_urlString];
    NSURLRequest *FB_SP_request = [NSURLRequest requestWithURL:FB_SP_url];
    [FB_P_kUIWebView loadRequest:FB_SP_request];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *FB_SP_name = [FB_P_kUIWebView.request.URL absoluteString];
    if (FB_SP_name == nil || [FB_SP_name FB_M_isBlankString]) {
        [self FB_M_loadMainPageContent];
    }
}
#pragma mark 设置web的frame
- (void)FB_M_resetContentWebFrame{
    CGFloat FB_SP_originY = IsPortrait?(iPhoneX?(StatusBarHeight-10):StatusBarHeight):0;
    CGFloat FB_SP_height  = self.FB_P_contentBottomView.frame.origin.y - FB_SP_originY;
    FB_P_kUIWebView.frame = CGRectMake(0, FB_SP_originY, MainScreenWidth, FB_SP_height);
    CGFloat FB_SP_y = 0;
    FB_P_kUIWebView.scrollView.contentInset = UIEdgeInsetsMake(FB_SP_y, 0, 0, 0);
    FB_P_kUIWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self FB_M_refreshBottomUI];
}
- (BOOL)prefersStatusBarHidden{
    //return !IsPortrait;
    return !self.FB_P_showStatus;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
