#import "FB_WKWebViewController.h"
#import <WebKit/WebKit.h>
@interface FB_WKWebViewController ()<WKUIDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate,FB_D_BottomViewDelegate>
{
    WKWebView *FB_P_kWKWebView;
}
@end
@implementation FB_WKWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.FB_P_contentBottomView.delegate = self;
    WKUserContentController *FB_SP_userContentController = [[WKUserContentController alloc] init];
    NSString *FB_SP_source = @"";
    WKUserScriptInjectionTime FB_SP_injectionTime = WKUserScriptInjectionTimeAtDocumentStart;
    BOOL forMainFrameOnly = NO;
    WKUserScript *FB_SP_script = [[WKUserScript alloc] initWithSource:FB_SP_source injectionTime:FB_SP_injectionTime forMainFrameOnly:forMainFrameOnly];
    [FB_SP_userContentController addUserScript:FB_SP_script];
    WKProcessPool *FB_SP_processPool = [[WKProcessPool alloc] init];
    WKWebViewConfiguration *FB_SP_webViewController = [[WKWebViewConfiguration alloc] init];
    FB_SP_webViewController.processPool = FB_SP_processPool;
    FB_SP_webViewController.userContentController = FB_SP_userContentController;
    FB_P_kWKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, self.view.frame.size.width, MainScreenHeight - StatusBarHeight - self.FB_P_contentBottomView.frame.size.height) configuration:FB_SP_webViewController];
    FB_P_kWKWebView.UIDelegate = self;
    FB_P_kWKWebView.scrollView.bounces = NO;
    FB_P_kWKWebView.navigationDelegate = self;
    FB_P_kWKWebView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:FB_P_kWKWebView];
    [self.view addSubview:self.FB_P_contentBottomView];
    if (@available(iOS 11,*)) {
        FB_P_kWKWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [FB_P_kWKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    UILongPressGestureRecognizer *FB_SP_longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(FB_M_longPressAction:)];
//    FB_SP_longPressGes.delegate = self;
//    FB_SP_longPressGes.minimumPressDuration = 0.35;
//    [FB_P_kWKWebView addGestureRecognizer:FB_SP_longPressGes];
    self.FB_P_networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)FB_M_longPressAction:(UIGestureRecognizer*)ges{
    if (self.FB_P_isShowAlert == YES) {
        return;
    }
    CGPoint FB_SP_point = [ges locationInView:FB_P_kWKWebView];
    NSString *FB_SP_jsStr = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src",FB_SP_point.x,FB_SP_point.y];
    [FB_P_kWKWebView evaluateJavaScript:FB_SP_jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSString *FB_SP_imageUrlStr = (NSString*)obj;
        if ([FB_SP_imageUrlStr rangeOfString:@"http://"].location != NSNotFound) {
            FB_SP_imageUrlStr = [FB_SP_imageUrlStr stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
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
        });
    }];
}
- (void)FB_M_performOperationWithStyle:(FB_E_OperationStyle)style{
    switch (style) {
        case FB_E_OperationStyleGoBack:
        {
            if ([FB_P_kWKWebView canGoBack]) {
                [FB_P_kWKWebView goBack];
            }
        }
            break;
        case FB_E_OperationStyleGoForward:
        {
            if ([FB_P_kWKWebView canGoForward]) {
                [FB_P_kWKWebView goForward];
            }
        }
            break;
        case FB_E_OperationStyleRefresh:
        {
            [FB_P_kWKWebView reload];
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
            if (FB_P_kWKWebView.backForwardList != nil && FB_P_kWKWebView.backForwardList.backList.count > 0) {
                [FB_P_kWKWebView goToBackForwardListItem:[FB_P_kWKWebView.backForwardList.backList firstObject]];
            }
        }
            break;
        default:
            break;
    }
}
- (void)FB_M_openContentUseB{
    NSURL *FB_SP_url = FB_P_kWKWebView.URL;
    if (FB_SP_url == nil || [FB_SP_url.absoluteString FB_M_isBlankString]) {
        FB_SP_url = [NSURL URLWithString:self.FB_P_urlString];
    }
    if ([[UIApplication sharedApplication] canOpenURL:FB_SP_url]) {
        [self FB_M_openSuitUrl:FB_SP_url];
    }else{
        [SVProgressHUD showInfoWithStatus:@"加载失败"];
    }
}
#pragma mark ------------------------  监听网页内容加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == FB_P_kWKWebView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat FB_SP_newValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
            if (FB_SP_newValue == 1) {
                self.FB_P_progressView.hidden = YES;
                self.FB_P_progressView.frame  = CGRectMake(0, self.FB_P_progressView.frame.origin.y, 0, PROGRESS_HEIGHT);
            }else{
                self.FB_P_progressView.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    self.FB_P_progressView.frame = CGRectMake(0, self.FB_P_progressView.frame.origin.y, MainScreenWidth*FB_SP_newValue, PROGRESS_HEIGHT);
                }];
            }
        }
    }
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self FB_M_refreshBottomUI];
}
#pragma mark 设置web的frame
- (void)FB_M_resetContentWebFrame{
    CGFloat FB_SP_originY = IsPortrait?(iPhoneX?(StatusBarHeight-10):StatusBarHeight):0;
    CGFloat FB_SP_height  = self.FB_P_contentBottomView.frame.origin.y - FB_SP_originY;
    if (self.FB_P_progressView) {
        self.FB_P_progressView.frame = CGRectMake(0, FB_SP_originY, self.FB_P_progressView.frame.size.width, PROGRESS_HEIGHT);
    }
    FB_P_kWKWebView.frame = CGRectMake(0, FB_SP_originY, MainScreenWidth, FB_SP_height);
    CGFloat FB_SP_y = 0;
    FB_P_kWKWebView.scrollView.contentInset = UIEdgeInsetsMake(FB_SP_y, 0, 0, 0);
    FB_P_kWKWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark 刷新url
-(void)FB_M_refreshUrl{
    NSURL *FB_SP_url = FB_P_kWKWebView.URL;
//    if (FB_SP_url == nil || [FB_SP_url.absoluteString FB_M_isBlankString]) {
        [self FB_M_loadMainPageContent];
//    }
}
#pragma mark 加载主页面
- (void)FB_M_loadMainPageContent{
    NSURL *FB_SP_url = [NSURL URLWithString:self.FB_P_urlString];
    NSURLRequest *FB_SP_request = [NSURLRequest requestWithURL:FB_SP_url];
    [FB_P_kWKWebView loadRequest:FB_SP_request];
}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#pragma mark ----------------------------------------------------------- 是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *FB_SP_urlStr = [NSString stringWithFormat:@"%@",navigationAction.request.URL.absoluteString];
    if ([self FB_M_jumpsToThirdAPP:FB_SP_urlStr]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if ([FB_SP_urlStr hasPrefix:@"itms"] || [FB_SP_urlStr hasPrefix:@"itunes.apple.com"] ) {
        NSURL *FB_SP_url = [NSURL URLWithString:FB_SP_urlStr];
        if ([[UIApplication sharedApplication] canOpenURL:FB_SP_url]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"在App Store中打开?" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self FB_M_openSuitUrl:FB_SP_url];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
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
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else{
            NSURL *url = [NSURL URLWithString:FB_SP_mutableStr];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [self FB_M_openSuitUrl:url];
                    decisionHandler(WKNavigationActionPolicyCancel);
                    return;
            }
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark -----------------------------------------------------------  开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}
#pragma mark -----------------------------------------------------------  web view页面开始接收数据
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
#pragma mark -----------------------------------------------------------  web view加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
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
        [FB_P_kWKWebView evaluateJavaScript:FB_SP_str completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        }];
    }
}
- (BOOL)prefersStatusBarHidden{

//    return !IsPortrait;
    [UIApplication sharedApplication].statusBarHidden = !self.FB_P_showStatus;
    return !self.FB_P_showStatus;
}
- (BOOL)FB_M_isAppDomain{
    NSString *FB_SP_current = [FB_P_kWKWebView.URL absoluteString];
    if ((FB_SP_current == nil || [FB_SP_current FB_M_isBlankString]) ||
        (self.FB_P_urlString == nil || [self.FB_P_urlString FB_M_isBlankString])) {
        return YES;
    }
    NSString *FB_SP_host = [FB_P_kWKWebView.URL host];
    if (FB_SP_host) {
        if ([self.FB_P_urlString rangeOfString:FB_SP_host].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}
#pragma mark -----------------------------------------------------------  加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self FB_M_networkWatingViewDismissFromView:webView];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self FB_M_networkWatingViewDismissFromView:webView];
}
#pragma mark ----------------------------------------------------------- 网页弹框 --- 确认弹框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *FB_SP_alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    [self presentViewController:FB_SP_alertController animated:YES completion:^{}];
}
#pragma mark ----------------------------------------------------------- 网页弹框 --- 错误提示弹框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *FB_SP_alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [FB_SP_alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:FB_SP_alertController animated:YES completion:nil];
}
#pragma mark -----------------------------------------------------------  接收到服务器跳转请求  收到服务器重定向
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}
#pragma mark -----------------------------------------------------------  在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *FB_SP_name = [FB_P_kWKWebView.URL absoluteString];
    if (FB_SP_name == nil || [FB_SP_name FB_M_isBlankString]) {
        [self FB_M_loadMainPageContent];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
