//
//  TBDatePickerDetailsView.h
//  Car
//
//  Created by Joyang on 16/9/12.
//  Copyright © 2016年 杨童彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBDatePickerDetailsViewDelegate <NSObject>

- (void)queDingWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
- (void)cancelChoooseDate;

@end
@interface TBDatePickerDetailsView : UIView

@property (nonatomic, weak)id <TBDatePickerDetailsViewDelegate>delegate;

@property (nonatomic, strong) NSString *fromDateString;
@property (nonatomic, strong) NSString *toDateString;
@property (nonatomic, strong) NSString *currentDateString;


/**
 *TBDatePickerDetailsView 的数据初始化方法
 *日期格式@“2000-01-01”
 *默认起始日期@“2000-01-01”
 *默认截止日期@“2050-12-31”
 */
- (void)viewWithFromeString:(NSString *)fromString EndString:(NSString *)endString;

@end
