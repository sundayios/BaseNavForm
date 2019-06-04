#import "FB_InterfacedConst.h"

@implementation FB_InterfacedConst

//====================================================================
#if LocalSever
/** 接口前缀-本地服务器*/
NSString *const kApiPrefix = @"http://192.168.5.31:8080";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://120.79.24.68:8080";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"http://www.xxxxx.com";
#endif

// 接口类型
NSString *const kIneterfacedTypeMobile = @"/game";
//====================================================================

NSString *const kDecryptKey = @"lianpukeji220200";

//上传路径
NSString *const kUploadFile = @"/file/upload.do";
//首页底部按钮
NSString *const kGetbaritembyappid = @"/baritem/getbaritembyappid";
//项目配置
NSString *const kGetConfigguration = @"/app/getappbyid";
//保存推送token
NSString *const kUploadToken = @"/user/saveusertoken";

@end
