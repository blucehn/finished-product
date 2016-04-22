
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface XYString : NSObject



#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
+(NSString *)toAbsolutelyString:(id)string;
+(BOOL) isBlankString:(id)string;


#pragma mark -  手机号码验证
+(BOOL) isValidateMobile:(NSString *)mobile;
#pragma mark -  邮箱验证验证
-(BOOL)isValidateEmail:(NSString *)email;


#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth;

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font;



@end
