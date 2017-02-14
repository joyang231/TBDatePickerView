//
//  TBDatePickerView.h
//  Car
//
//  Created by Joyang on 16/9/12.
//  Copyright © 2016年 杨童彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBDatePickerView : UIView


@property (nonatomic,copy)void(^callBack)(NSInteger year,NSInteger month,NSInteger day);


/**
 *  显示视图
 *  日期格式@“2000-01-01”
 *  默认起始日期@“2000-01-01”
 *  默认截止日期@“2050-12-31”
 */
- (void)showWithFromDateString:(NSString *)fromDateString EndDateString:(NSString *)endDateString;

/**
 *  销毁视图
 */
- (void)dismiss;

@end
