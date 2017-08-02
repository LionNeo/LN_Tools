//
//  NSString+LNStaticString.m
//  LNne_Rebuild
//
//  Created by  on 2016/11/19.
//  Copyright © 2016年 com.xgx.gworld. All rights reserved.
//

#import "NSString+LNStaticString.h"
#import "CommonCrypto/CommonDigest.h"
#import<CommonCrypto/CommonCryptor.h>
#import <CoreText/CoreText.h>

@implementation NSString (LNStaticString)
/**
 *  字符串为空
 *
 *  @param string 字符串
 *
 *  @return yes or no
 */
BOOL LNIsNullString(NSString *string) {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

#pragma mark - 验证合法性
/**
 验证邮箱
 
 @param email 邮箱地址
 @return 是否是邮箱
 */
BOOL LNValidateEmail(NSString *email){
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 验证身份证是否合法
 
 @param identification 身份证号
 @return 身份证号是否合法
 */
BOOL LNValidatePIN(NSString *identification){
    
    //判断位数
    
    
    if ([identification length] != 15 && [identification length] != 18) {
        return NO;
    }
    NSString *carid = identification;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:identification];
    
    if ([identification length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    
    NSString * sProvince = [carid substringToIndex:2];
    
    if (!areaCode(sProvince)) {
        
        return NO;
        
    }
    
    //判断年月日是否有效
    
    
    
    //年份
    int strYear = LNGetSubStringWithRange(carid, NSMakeRange(6, 4)).intValue;
    
    //月份
    
    int strMonth = LNGetSubStringWithRange(carid, NSMakeRange(10, 2)).intValue;
    
    //日
    
    int strDay = LNGetSubStringWithRange(carid, NSMakeRange(12, 2)).intValue;
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId)) return -1;
    
    
    
    //校验数字
    
    for (int i=0; i<18; i++)
        
    {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
            
        {
            
            return NO;
            
        }
        
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++)
        
    {
        
        lSumQT += (PaperId[i]-48) * R[i];
        
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
        
    {
        
        return NO;
        
    }
    
    return YES;
}

/**
 判断是否在地区码内

 @param code 地区码
 @return 是否在地区码内
 */
BOOL areaCode(NSString *code)

{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
        
    }
    
    return YES;
    
}

/**
 获取指定范围内的字符串

 @param str 原字符串
 @param range 截取范围
 @return 截取后的字符串
 */
NSString * LNGetSubStringWithRange(NSString *str, NSRange range){
    
    return [str substringWithRange:range];
}


/**
 验证手机号码是否合法
 
 @param mobileNum 手机号码
 @return 手机号码是否合法
 */
BOOL LNValidateMobileNumber(NSString *mobileNum){
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark - 加密
/**
 MD5加密数据
 
 @param original 原始数据
 @return 加密过后的数据
 */
NSString * LNMD5(NSString *original){
    
    const char *cStr = [original UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/**
 DES加密:用CCCrypt函数加密，然后用base64编码
 
 @param originalTxt 初始文本
 @param key 加权值
 @return 加密后的数据
 */
NSString * LNEncryptTextWithKey(NSString *originalTxt, NSString *key){
    
    NSData* encryptData = [originalTxt dataUsingEncoding:NSUTF8StringEncoding];
    const void *dataIn = (const void *)[encryptData bytes];
    size_t dataInLength = [encryptData length];
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码
     */
    
    size_t dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    uint8_t *dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    size_t dataOutMoved = 0;
    
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    NSString *initIv = @"12345678";
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密
    CCCrypt(kCCEncrypt,//  加密
            kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
            kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
            vkey,  //密钥
            kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
            iv, //  可选的初始矢量
            dataIn, // 数据的存储单元
            dataInLength,// 数据的大小
            (void *)dataOut,// 用于返回数据
            dataOutAvailable,
            &dataOutMoved);
    
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];//[GTMBase64 stringByEncodingData:data];
    
    return result;
}

/**
 获取控件中每行的文字的范围
 
 @param label 显示文本的控件
 @return 含有每行文本的range的数组
 */
NSArray * LNGetTextRangesOfEveryLine(UILabel *label){
    
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

/**
 计算文本的高度
 
 @param str 字符串
 @param size 显示的区域
 @param font 字体大小
 @return 文本的高度
 */
CGFloat LNHeightForText(NSString *str, CGSize size, UIFont *font){
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGFloat height = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
    return height;
}

/**
 计算文本高度，包含行高
 
 @param str 带计算的文本
 @param size 显示文本的区域大小
 @param font 字体大小
 @param spacing 行间距
 @return 计算过后的文本高度
 */
CGFloat LNCalculateTextHeightWithLineSpacing(NSString * str, CGFloat width, UIFont *font, CGFloat spacing, UILabel *label){
    
    //设置Label最大的宽度
    label.frame = (CGRect){label.frame.origin.x,label.frame.origin.y,width,label.frame.size.width};
    label.font = font;
    label.numberOfLines = 0;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [label setAttributedText:attributedString];
    [label sizeToFit];
    return label.frame.size.height;
}

@end
