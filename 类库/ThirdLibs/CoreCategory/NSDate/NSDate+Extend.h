//
//  NSDate+Extend.h
//  CoreCategory
//
//  Created by ly on 15/3/7.
//  Copyright (c) 2015年 ly. All rights reserved.
//



/*
         (搜索关键字 ： 格式化日期和时间)
 */

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;

/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;

/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;
/*
 *  是否是今天
 */
@property (nonatomic,assign,readonly) BOOL isToday;

/*
 *  是否是昨天
 */
@property (nonatomic,assign,readonly) BOOL isYesToday;

/*
 * 时候是明天
 */
@property (nonatomic,assign,readonly) BOOL isTomorrow;


/*
 * 转化为yyyy-MM-dd HH:mm:ss 格式
 */
@property (nonatomic,copy,readonly) NSString *y_m_d_h_m_s_str;

/*
 * 转化为yyyy-MM-dd格式
 */
@property (nonatomic,copy,readonly) NSString *y_m_d_str;

/*
 *   字符 c 代表星期  但是返回的是 数字
 */
@property (nonatomic,copy,readonly) NSString *week_str;



/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;






@end
