//
//  ViewController.m
//  TBDatePickerViewDemo
//
//  Created by Joyang on 2017/2/14.
//  Copyright © 2017年 杨童彪. All rights reserved.
//

#import "ViewController.h"
#import "TBDatePickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateShowLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark -- 选择时间按钮点击相应事件
- (IBAction)chooseDateBtnClicked:(UIButton *)sender {
    
    __block typeof(self) weakSelf = self;
    TBDatePickerView *view = [[TBDatePickerView alloc] init];
    [view setCallBack:^(NSInteger year, NSInteger month, NSInteger day) {
        weakSelf.dateShowLab.text = [NSString stringWithFormat:@"%04ld年%02ld月%02ld日",year,month,day];
    }];
    
    [view showWithFromDateString:@"1900-01-01" EndDateString:@"2050-12-31"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
