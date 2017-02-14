//
//  TBDatePickerView.m
//  Car
//
//  Created by Joyang on 16/9/12.
//  Copyright © 2016年 杨童彪. All rights reserved.
//

#import "TBDatePickerView.h"
#import "TBDatePickerDetailsView.h"


@interface TBDatePickerView ()<TBDatePickerDetailsViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong)  TBDatePickerDetailsView*detailsView;

@end
@implementation TBDatePickerView

/**
 *  显示视图
 */
- (void)showWithFromDateString:(NSString *)fromDateString EndDateString:(NSString *)endDateString
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.frame = [[UIScreen mainScreen] bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake((kUI_SCREEN_WIDTH-295)/2, (kUI_SCREEN_HEIGHT-282)/2+kUI_SCREEN_HEIGHT, 295, 282 )];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    // details
    self.detailsView = [[[NSBundle mainBundle] loadNibNamed:@"TBDatePickerDetailsView" owner:nil options:nil] lastObject];
    [self.detailsView viewWithFromeString:fromDateString EndString:endDateString];
    self.detailsView.delegate = self;
    
    self.detailsView.frame = CGRectMake(0, 0, 295, 282 );
    [self.bgView addSubview:self.detailsView];
    
    
    // 动画弹出详情视图
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, 0, -kUI_SCREEN_HEIGHT);
        NSLog(@"---%f---",self.bgView.frame.size.height);
    }];
}

/**
 *  销毁视图
 */
- (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, 0, kUI_SCREEN_HEIGHT );
        } completion:^(BOOL finished) {
            [self.bgView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    });
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
#pragma mark -- TBDatePickerDetailsViewDelegate
-(void)queDingWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day{
    if ([self respondsToSelector:@selector(callBack)]) {
        self.callBack(year,month,day);
    }
}
-(void)cancelChoooseDate{
    [self dismiss];
}

@end
