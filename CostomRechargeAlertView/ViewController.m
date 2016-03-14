//
//  ViewController.m
//  CostomRechargeAlertView
//
//  Created by 谢浩 on 15/8/5.
//  Copyright (c) 2015年 xiehao. All rights reserved.
//

#import "ViewController.h"
#import "CostomRechargeAlert.h"
#import "CostomRechResultAlert.h"
@interface ViewController ()<CostomRechargeAlertDelegate,CostomRechResultAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.frame];
    [btn addTarget: self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)button
{
    CostomRechargeAlert *alert = [[CostomRechargeAlert alloc]initWithCurrentChooseMin:960 addMin:80 withPrice:30 andDelegate:self];
    [alert show];
}
- (void)rechargeButtonClick:(NSInteger)index andTheKindOfRecharge:(NSString *)rechargeKind
{
    NSLog(@"%ld----%@",(long)index,rechargeKind);
    CostomRechResultAlert *alert = [[CostomRechResultAlert alloc]initWithRemainTime:138 andTheDelegate:self isSuccess:YES];
    [alert show];
}

- (void)rechargeResultButtonClick:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
