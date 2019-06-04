#import <Foundation/Foundation.h>
#define kRequestURL(X)  [NSString stringWithFormat:@"%@%@%@", kApiPrefix, kIneterfacedTypeMobile, X]

@interface FB_InterfacedConst : NSObject
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#define LocalSever   0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器 **/
extern NSString *const kApiPrefix;
//接口类型
extern NSString *const kIneterfacedTypeMobile;
//****************************************************
//
extern NSString *const kDecryptKey;
//上传路径
extern NSString *const kUploadFile;
//首页底部按钮
extern NSString *const kGetbaritembyappid;
//项目配置
extern NSString *const kGetConfigguration;
//保存推送token
extern NSString *const kUploadToken;


@end
