//
//  NSDate+LNDate.h
//  LionNeo
//
//  Created by Lion_Neo  on 17/6/27 第178天.
//  Copyright © 2017年 com.LionNeo.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LNDate)
/**
 给定时间距离现在的时间有多长
 
 @param date 给定的时间点
 @return 特定的时间点距离现在的描述
 */
NSString * LNCompareCurrrentTime(NSDate *date);

/**
 今天是周几
 
 @return 今天是周几
 */
NSString * LNWeekOfToday();

/**
 根据时间戳转化成相应的字符串，基准是1970
 
 @param interval 时间戳
 @param format 日期格式
 @return 转换过后的字符串
 */
NSString * LNDateStringWithFormatSince1970(NSTimeInterval interval, NSString *format);

/**
 把日期转换为制定格式的字符串
 
 @param date 要进行转换的日期
 @param format 要转换成的日期格式
 @return 按照制定格式转换过后的字符串
 */
NSString * LNConvertDateToStringWithFormat(NSDate *date, NSString *format);

/**
 按照制定的格式转换成日期
 
 @param dateStr 需要进行转换的字符串
 @param format 需要转换的日期格式
 @return 按照制定格式转换过后的日期
 */
NSDate * LNConvertStringToDateWithFormat(NSString *dateStr, NSString *format);

/**
 根据日期转换年龄
 
 @param date 出生日期
 @return 年龄
 */
NSString * LNAgeFromDate(NSDate *date);
/**
 *  根据时间戳转化为日期
 *
 *  @param interval 精确到毫秒的时间戳
 *
 *  @return 日期
 */
NSString * LNDateFromTimeInterval(NSTimeInterval interval);
@end
