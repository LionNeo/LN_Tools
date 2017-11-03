//
//  NSDate+LNDate.m
//  LionNeo
//
//  Created by Lion_Neo  on 17/6/27 第178天.
//  Copyright © 2017年 com.LionNeo.www. All rights reserved.
//

#import "NSDate+LNDate.h"

@implementation NSDate (LNDate)

/**
 给定时间距离现在的时间有多长
 
 @param date 给定的时间点
 @return 特定的时间点距离现在的描述
 */
NSString * LNCompareCurrrentTime(NSDate *date){
    
    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

/**
 今天是周几
 
 @return 今天是周几
 */
NSString * LNWeekOfToday(){
    
    NSDate *date = [NSDate date];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekDay;
    switch ([componets weekday]) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
            
        default:
            break;
    }
    return weekDay;
}


/**
 根据时间戳转化成相应的字符串，基准是1970
 
 @param interval 时间戳
 @param format 日期格式
 @return 转换过后的字符串
 */
NSString * LNDateStringWithFormatSince1970(NSTimeInterval interval, NSString *format){
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
    [dateFormatte setDateFormat:format];
    return [dateFormatte stringFromDate:date];
}

/**
 把日期转换为制定格式的字符串
 
 @param date 要进行转换的日期
 @param format 要转换成的日期格式
 @return 按照制定格式转换过后的字符串
 */
NSString * LNConvertDateToStringWithFormat(NSDate *date, NSString *format){
    
    NSString *strRet = nil;
    if (date && format)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        
        [dateFormatter setDateFormat:format];
        strRet = [dateFormatter stringFromDate:date];
    }
    
    return strRet;
}

/**
 按照制定的格式转换成日期
 
 @param dateStr 需要进行转换的字符串
 @param format 需要转换的日期格式
 @return 按照制定格式转换过后的日期
 */
NSDate * LNConvertStringToDateWithFormat(NSString *dateStr, NSString *format){
    
    NSDate *dateRet = nil;
    if (dateStr && format && (dateStr.length == format.length))
    {
        NSDateFormatter *objDateFmt = [[NSDateFormatter alloc] init];
        [objDateFmt setTimeZone:[NSTimeZone defaultTimeZone]];
        [objDateFmt setDateFormat:format];
        dateRet = [objDateFmt dateFromString:dateStr];
    }
    
    return dateRet;
}

/**
 根据日期转换年龄
 
 @param date 出生日期
 @return 年龄
 */
NSString * LNAgeFromDate(NSDate *date){
    
    NSDate *myDate = date;
    
    
    NSDate *nowDate = [NSDate date];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    unsigned int unitFlags = NSCalendarUnitYear;
    
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:myDate toDate:nowDate options:0];
    
    
    NSInteger year = [comps year];
    
    
    return [NSString stringWithFormat:@"%ld",(long)year];
}
/**
 *  根据时间戳转化为日期
 *
 *  @param interval 精确到毫秒的时间戳
 *
 *  @return 日期
 */
NSString * LNDateFromTimeInterval(NSTimeInterval interval){
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

@end
