//
//  CostomRechResultAlert.m
//  CostomRechargeAlertView
//
//  Created by 谢浩 on 15/8/5.
//  Copyright (c) 2015年 xiehao. All rights reserved.
//
#define CenterX NSLayoutAttributeCenterX
#define CenterY NSLayoutAttributeCenterY
#define Left    NSLayoutAttributeLeft
#define Right   NSLayoutAttributeRight
#define Top     NSLayoutAttributeTop
#define Bottom  NSLayoutAttributeBottom
#define Height  NSLayoutAttributeHeight
#define Width   NSLayoutAttributeWidth

#define Equal   NSLayoutRelationEqual

#define CONSTRAINT(superview,subview,subAttribute,relation,toView,toViewAttribute,multi,constrant) [superview addConstraint:\
[NSLayoutConstraint constraintWithItem:subview attribute:subAttribute relatedBy:relation \
toItem:toView attribute:toViewAttribute multiplier:multi constant:constrant]]

#define CONSTRAINT_VF(superview,VFString,DicBindings) [superview addConstraints:\
[NSLayoutConstraint constraintsWithVisualFormat:VFString options:0 metrics:nil views:DicBindings]]
#import "CostomRechResultAlert.h"

@implementation CostomRechResultAlert

- (id)initWithRemainTime:(NSInteger)remainTime andTheDelegate:(id)delegate isSuccess:(BOOL)success
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = delegate;
        self.remainTime = remainTime;
        self.success = success;
        [self initAlertUI];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

- (void)initAlertUI
{
    _bgView = [[[UIView alloc]init]autorelease];
    _bgView.center = self.center;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.bounds = CGRectMake(0, 0, self.frame.size.width*0.7, self.frame.size.height *0.6);
    _bgView.layer.cornerRadius = 10;
    [self addSubview:_bgView];
    
    UILabel *label = [[[UILabel alloc]init]autorelease];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"提示";
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [_bgView addSubview:label];
    
    CONSTRAINT(_bgView, label, CenterX, Equal, _bgView, CenterX, 1.0, 0);
    CONSTRAINT(_bgView, label, Top, Equal, _bgView, Top, 1.0, 15.0);
    
    UIButton *shutBtn = [[[UIButton alloc]init]autorelease];
    shutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    shutBtn.tag = 0;
    [shutBtn setBackgroundImage:[UIImage imageNamed:@"btn_recharge_shut_n"] forState:UIControlStateNormal];
    [shutBtn setBackgroundImage:[UIImage imageNamed:@"btn_recharge_shut_h"] forState:UIControlStateHighlighted];
    [shutBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:shutBtn];
    
    NSString *H_shutBtn = @"H:[shutBtn(25)]";
    NSString *V_shutBtn = @"V:[shutBtn(25)]";
    
    CONSTRAINT_VF(_bgView, H_shutBtn, NSDictionaryOfVariableBindings(shutBtn));
    CONSTRAINT_VF(_bgView, V_shutBtn, NSDictionaryOfVariableBindings(shutBtn));
    CONSTRAINT(_bgView, shutBtn, CenterY, Equal, label, CenterY, 1.0, 0);
    CONSTRAINT(_bgView, shutBtn, Right, Equal, _bgView, Right, 1.0, -15.0);
    
    UIImageView *image = [[[UIImageView alloc]init]autorelease];
    image.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.success == YES)
    {
        image.image = [UIImage imageNamed:@"img_face002"];
    }else
    {
        image.image = [UIImage imageNamed:@"img_face003"];
    }
    [_bgView addSubview:image];
    
    NSString *H_image = [NSString stringWithFormat:@"H:[image(%f)]",0.176*self.frame.size.height];
    NSString *V_image = [NSString stringWithFormat:@"V:[image(%f)]",0.176*self.frame.size.height];

    
    CONSTRAINT_VF(_bgView, H_image, NSDictionaryOfVariableBindings(image));
    CONSTRAINT_VF(_bgView, V_image, NSDictionaryOfVariableBindings(image));
    CONSTRAINT(_bgView, image, Bottom, Equal, _bgView, CenterY, 1.0, -10.0);
    CONSTRAINT(_bgView, image, CenterX, Equal, _bgView, CenterX, 1.0, 0);
    
    UILabel *resultLabel = [[[UILabel alloc]init]autorelease];
    resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.success == YES)
    {
        resultLabel.text = @"充值成功!";
        resultLabel.textColor = [UIColor colorWithRed:171.0/255.0 green:213.0/255.0 blue:34.0/255.0 alpha:1.0];
    }
    else
    {
        resultLabel.text = @"充值失败!";
        resultLabel.textColor = [UIColor redColor];
    }
    resultLabel.font = [UIFont systemFontOfSize:30];
    resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:resultLabel];
    
    CONSTRAINT(_bgView, resultLabel, CenterX, Equal, _bgView, CenterX, 1.0, 0);
    CONSTRAINT(_bgView, resultLabel, Top, Equal, _bgView, CenterY, 1.0, 5.0);
    
    UILabel *tipLabel = [[[UILabel alloc]init]autorelease];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.font = [UIFont systemFontOfSize:15.0];
    if (self.success == YES)
    {
        tipLabel.text = [NSString stringWithFormat:@"当前余额%ld分钟",(long)self.remainTime];
    }
    else
    {
        tipLabel.text = @"未能完成支付";
    }
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:tipLabel];
    
    CONSTRAINT(_bgView, tipLabel, CenterX, Equal, _bgView, CenterX, 1.0, 0);
    CONSTRAINT(_bgView, tipLabel, Top, Equal, resultLabel, Bottom, 1.0, 5.0);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorWithRed:171.0/255.0 green:213.0/255.0 blue:34.0/255.0 alpha:1.0];
    button.layer.cornerRadius = 25;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (self.success == YES)
    {
        [button setTitle:@"马上畅聊" forState:UIControlStateNormal];
        button.tag = 1;
    }
    else
    {
        [button setTitle:@"返回重试" forState:UIControlStateNormal];
        button.tag = 2;
    }
    [_bgView addSubview:button];
    
    NSString *H_button = @"H:[button(120)]";
    NSString *V_button = [NSString stringWithFormat:@"V:[button(50)]-%f-|",0.053*self.frame.size.height];
    CONSTRAINT_VF(_bgView, H_button, NSDictionaryOfVariableBindings(button));
    CONSTRAINT_VF(_bgView, V_button, NSDictionaryOfVariableBindings(button));
    CONSTRAINT(_bgView, button, CenterX, Equal, _bgView, CenterX, 1.0, 0);
}
- (void)buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(rechargeResultButtonClick:)]) {
        [self.delegate rechargeResultButtonClick:sender.tag];
    }
    if (0 == sender.tag) {
        [UIView animateWithDuration:0.3 animations:^{
            _bgView.transform = CGAffineTransformMakeScale(0.6,0.6);
            _bgView.alpha = 0.5;
            self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self hide];
    }
}
- (void)show
{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        //将接受的delegate强制类型转化成vc的对象
        UIViewController  *viewController = (UIViewController*)self.delegate;
        // 将自身view 添加到父视图上
        [viewController.view addSubview:self];
    }
    _bgView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        _bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (void)hide
{
    
    [self removeFromSuperview];
}
@end
