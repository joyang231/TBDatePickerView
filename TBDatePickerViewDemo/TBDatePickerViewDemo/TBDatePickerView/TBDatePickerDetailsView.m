//
//  TBDatePickerDetailsView.m
//  Car
//
//  Created by Joyang on 16/9/12.
//  Copyright © 2016年 杨童彪. All rights reserved.
//

#import "TBDatePickerDetailsView.h"


@interface TBDatePickerDetailsView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (nonatomic, assign) NSInteger daysOfCurrentMonth;
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *toDate;


@end
@implementation TBDatePickerDetailsView



- (void)viewWithFromeString:(NSString *)fromString EndString:(NSString *)endString
{
    
    self.fromDateString = fromString;
    self.fromDate = [self dateFromString:self.fromDateString];
    if (!self.fromDate) {
        self.fromDateString = @"2000-01-01";
        self.fromDate = [self dateFromString:self.fromDateString];
    }
    self.toDateString = endString;
    self.toDate = [self dateFromString:self.toDateString];
    if (!self.toDate) {
        
        NSCalendar * cal=[NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents * conponent= [cal components:unitFlags fromDate:[NSDate date]];
        NSInteger year=[conponent year];
        NSInteger month=[conponent month];
        NSInteger day=[conponent day];
        
        if (!self.toDateString.length) {
            self.toDateString = [NSString stringWithFormat:@"%04ld-%02ld-%02ld",(long)year,(long)month,(long)day];
        }
        self.toDate = [self dateFromString:self.toDateString];
    }
    [self.pickerView reloadAllComponents];
    [self chooseCurrentDate];

}

-(void)awakeFromNib{
    [super awakeFromNib];
//    [self chooseCurrentDate];
}

#pragma mark -- 选择当前日期函数
- (void)chooseCurrentDate{
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
    NSString * nsDateString= [NSString stringWithFormat:@"%ld 年 %02ld 月 %02ld 日",(long)year,(long)month,(long)day];
    self.tipsLab.text = nsDateString;
    
    NSDateComponents * comCenter= [cal components:unitFlags fromDate:self.fromDate toDate:[NSDate date] options:0];
    
    [self.pickerView selectRow:comCenter.year inComponent:0 animated:YES];
    [self.pickerView selectRow:month-1 inComponent:1 animated:YES];
    [self.pickerView selectRow:day-1 inComponent:2 animated:YES];
}


- (IBAction)queDingBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(queDingWithYear:Month:Day:)]) {
        [self.delegate queDingWithYear:[[self.fromDateString substringToIndex:4] integerValue]+[self.pickerView selectedRowInComponent:0] Month:[self.pickerView selectedRowInComponent:1]+1 Day:[self.pickerView selectedRowInComponent:2]+1];
    }
    if ([self.delegate respondsToSelector:@selector(cancelChoooseDate)]) {
        [self.delegate cancelChoooseDate];
    }
}
- (IBAction)cancelBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelChoooseDate)]) {
        [self.delegate cancelChoooseDate];
    }
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //    返回多少列
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear ;
    if (self.toDateString.length) {
        self.toDate = [self dateFromString:self.toDateString];
    }else{
        self.toDate = [NSDate date];
    }
    NSDateComponents * conponent= [cal components:unitFlags fromDate:self.fromDate toDate:self.toDate options:0];
    switch (component) {
        case 0:
            return ([conponent year]+1);
            break;
        case 1:
            return 12;
            break;
        case 2:
            return 31;
            break;
        default:
            break;
    }
    return 12;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 295/3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //隐藏框
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    
    if (component == 0) {
        NSCalendar * cal=[NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents * conponent= [cal components:unitFlags fromDate:self.fromDate];
        return [NSString stringWithFormat:@"%02ld",(long)[conponent year]+row];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%02ld月",(long)1+row];
    }else if (component == 2){
        return [NSString stringWithFormat:@"%02ld日",(long)1+row];
    }
    
    return @"";
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self pickerViewLoaded:component];
   
        NSCalendar * cal=[NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
        NSDateComponents * comFrom= [cal components:unitFlags fromDate:self.fromDate];
        NSDateComponents * comEnd= [cal components:unitFlags fromDate:self.toDate];
    
    if ([self.pickerView selectedRowInComponent:0] == 0
        &&[self.pickerView selectedRowInComponent:1]<comFrom.month-1) {
        [self.pickerView selectRow:comFrom.month-1 inComponent:1 animated:YES];
    }
    if ([self.pickerView selectedRowInComponent:0] == 0
        &&[self.pickerView selectedRowInComponent:1]<=comFrom.month-1
        &&[self.pickerView selectedRowInComponent:2]<comFrom.day-1) {
        [self.pickerView selectRow:comFrom.day-1 inComponent:2 animated:YES];
    }
    
    if (comFrom.year+[self.pickerView selectedRowInComponent:0] >comEnd.year) {
        [self.pickerView selectRow:comEnd.year inComponent:0 animated:YES];
    }
    if (comFrom.year+[self.pickerView selectedRowInComponent:0] >=comEnd.year
        &&[self.pickerView selectedRowInComponent:1]>comEnd.month-1) {
        [self.pickerView selectRow:comEnd.month-1 inComponent:1 animated:YES];
    }
    if (comFrom.year+[self.pickerView selectedRowInComponent:0] >=comEnd.year
            &&[self.pickerView selectedRowInComponent:1]>=comEnd.month-1
            &&[self.pickerView selectedRowInComponent:2]>comEnd.day-1) {//当前年当前月
        [self.pickerView selectRow:comEnd.day-1 inComponent:2 animated:YES];
    }
    
    //1,3,5,7,8,10,12 有31天
    // 4,6,9,11 有30天
    if ([self.pickerView selectedRowInComponent:1] ==4-1
        ||[self.pickerView selectedRowInComponent:1] ==6-1
        ||[self.pickerView selectedRowInComponent:1] ==9-1
        ||[self.pickerView selectedRowInComponent:1] ==11-1) {
        if ([self.pickerView selectedRowInComponent:2]>=31-1) {
            [self.pickerView selectRow:30-1 inComponent:2 animated:YES];
        }
    }
    NSInteger seletedYear = comFrom.year+[self.pickerView selectedRowInComponent:0];
//    NSLog(@"%ld",seletedYear);
    //四年一闰 百年不闰 四百年一闰
    if ([self.pickerView selectedRowInComponent:1] == 2-1) {

        if (!(seletedYear%400)||(seletedYear%100&&!(seletedYear%4))) {
            if ([self.pickerView selectedRowInComponent:2]>29-1) {
                
                [self.pickerView selectRow:29-1 inComponent:2 animated:YES];
            }
        }else{
            if ([self.pickerView selectedRowInComponent:2]>28-1) {
                
                [self.pickerView selectRow:28-1 inComponent:2 animated:YES];
            }
        }
    }
    
//    NSLog(@"%ld年%ld月%ld日",comFrom.year+[self.pickerView selectedRowInComponent:0],[self.pickerView selectedRowInComponent:1]+1,[self.pickerView selectedRowInComponent:2]+1);
     NSString * nsDateString= [NSString stringWithFormat:@"%ld 年 %02ld 月 %02ld 日",(long)comFrom.year+(long)[self.pickerView selectedRowInComponent:0],(long)[self.pickerView selectedRowInComponent:1]+1,(long)[self.pickerView selectedRowInComponent:2]+1];
    self.tipsLab.text = nsDateString;
}
-(void)pickerViewLoaded: (NSInteger)component {
    NSUInteger max = 16384;
    NSUInteger base10 = (max / 2) - (max / 2) % (component ? 4 : 24);
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % (component ? 4 : 24) + base10 inComponent:component animated:NO];
}

#pragma mark -- 时间相关函数
//获取当前时间若干年、月、日之后的时间
- (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days{
    NSDate  * latterDate;
    if (date) {
        latterDate = date;
    }else{
        latterDate = [NSDate date];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:latterDate];
    
    [comps setYear:years];
    [comps setMonth:months];
    [comps setDay:days];
    
    return [calendar dateByAddingComponents:comps toDate:latterDate options:0];
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
- (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
}
//字符串转日期
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

@end
