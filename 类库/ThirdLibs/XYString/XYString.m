

#import "XYString.h"

@implementation XYString


#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
+(NSString *)toAbsolutelyString:(id)string
{
    NSString * str = (NSString*)string;
    if ([self isBlankString:str]){
        string = @"";
    }
    return string;
    
}

//..判断字符串是否为空字符的方法
+(BOOL) isBlankString:(id)string {
    NSString * str = (NSString*)string;
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#pragma mark -  手机号码验证
+(BOOL) isValidateMobile:(NSString *)mobile
{
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[34578]([0-9]){9}"];
    
    return [phoneTest evaluateWithObject:mobile];

}


#pragma mark -  邮箱验证验证
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}







#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = CGSizeMake(contentWidth, CGFLOAT_MAX);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = [text sizeWithAttributes:dict];
    return size.width;
}










@end
