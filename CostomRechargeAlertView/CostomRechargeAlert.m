//
//  CostomRechargeAlert.m
//  CostomRechargeAlertView
//
//  Created by 谢浩 on 15/8/5.
//  Copyright (c) 2015年 xiehao. All rights reserved.
//
#define Public_Orange_Color [UIColor colorWithRed:249.0/255.0 green:182.0/255.0 blue:133.0/255.0 alpha:1.0]
#define Public_LineGray_Color [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0]

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

#import "CostomRechargeAlert.h"

@implementation CostomRechargeAlert

- (id)initWithCurrentChooseMin:(NSInteger)min addMin:(NSInteger)addMin withPrice:(NSInteger)price andDelegate:(id)delegate
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
        [self addGestureRecognizer:tap];
        [tap release];
        self.alpha = 0;
        self.min = min;
        self.addMin = addMin;
        self.price = price;
        self.delegate = delegate;
        self.rechargeArr = [NSMutableArray arrayWithObjects:@"支付宝",@"微信",@"财付通",@"手机充值卡",@"银联",@"关闭充值", nil];
        [self initAlertUI];
    }
    return self;
}
- (void)dealloc
{
    self.rechargeArr = nil;
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
    label.text = @"支付方式";
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [_bgView addSubview:label];
    
    CONSTRAINT(_bgView, label, CenterX, Equal, _bgView, CenterX, 1.0, 0);
    CONSTRAINT(_bgView, label, Top, Equal, _bgView, Top, 1.0, 15.0);
    
    UIButton *shutBtn = [[[UIButton alloc]init]autorelease];
    shutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    shutBtn.tag = 5;
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
    
    
    NSArray *array = [NSArray arrayWithObjects:@"当前选择:",@"赠送:",@"价格:", nil];
    for (int i = 0; i<3; i++) {
        UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.text = array[i];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_bgView addSubview:titleLabel];
        
        CONSTRAINT(_bgView, titleLabel, Left, Equal, _bgView, Left, 1.0, 15.0);
        CONSTRAINT(_bgView, titleLabel, Top, Equal, label, Bottom, 1.0, 0.03*self.frame.size.height+(0.06*self.frame.size.height)*i);
        
        UILabel *dataLabel = [[[UILabel alloc]init]autorelease];
        dataLabel.translatesAutoresizingMaskIntoConstraints = NO;
        if (0 == i)
        {
            dataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min];
        }
        if (1 == i)
        {
            dataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.addMin];
        }
        if (2 == i) {
            dataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.price];
            dataLabel.textColor = [UIColor orangeColor];
        }
        
        dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
        dataLabel.font = [UIFont systemFontOfSize:20.0];
        [_bgView addSubview:dataLabel];
        
        CONSTRAINT(_bgView, dataLabel, Left, Equal, titleLabel, Right, 1.0, 10.0);
        CONSTRAINT(_bgView, dataLabel, CenterY, Equal, titleLabel, CenterY, 1.0, 0);
       
        UILabel *rightLabel = [[[UILabel alloc]init]autorelease];
        rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        rightLabel.text = @"分钟";
        if (2 == i) {
            rightLabel.text = @"元";
        }
        rightLabel.font = [UIFont systemFontOfSize:14.0];
        [_bgView addSubview:rightLabel];
        
        CONSTRAINT(_bgView, rightLabel, Left, Equal, dataLabel, Right, 1.0, 5.0);
        CONSTRAINT(_bgView, rightLabel, CenterY, Equal, titleLabel, CenterY, 1.0, 0);
        
    }
    
    UIView *seqView = [[[UIView alloc] init] autorelease];
    seqView.translatesAutoresizingMaskIntoConstraints = NO;
    seqView.backgroundColor = Public_LineGray_Color;
    [_bgView addSubview:seqView];
    
    NSString *H_seqView = @"H:|-25-[seqView]-25-|";
    NSString *V_seqView = @"V:[seqView(0.5)]";
    
    CONSTRAINT_VF(_bgView, H_seqView, NSDictionaryOfVariableBindings(seqView));
    CONSTRAINT_VF(_bgView, V_seqView, NSDictionaryOfVariableBindings(seqView));
    CONSTRAINT(_bgView, seqView, CenterX, Equal, _bgView, CenterX, 1.0, 0.0);
    CONSTRAINT(_bgView, seqView, CenterY, Equal, _bgView, CenterY, 1.0, -0.0225*self.frame.size.height);
    
    for (int i = 0 ; i<5; i++) {
        
        UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rechargeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [rechargeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [rechargeBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_recharge_n_%d",i+1]] forState:UIControlStateNormal];
        [rechargeBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_recharge_h_%d",i+1]] forState:UIControlStateHighlighted];
        rechargeBtn.tag = i;
        [_bgView addSubview:rechargeBtn];
        
        NSString *H_rechargeBtn =[NSString stringWithFormat:@"H:[rechargeBtn(%f)]",0.13*self.frame.size.width];
        NSString *V_rechargeBtn =[NSString stringWithFormat:@"V:[rechargeBtn(%f)]",0.13*self.frame.size.width];
        
        CONSTRAINT_VF(_bgView, H_rechargeBtn, NSDictionaryOfVariableBindings(rechargeBtn));
        CONSTRAINT_VF(_bgView, V_rechargeBtn, NSDictionaryOfVariableBindings(rechargeBtn));
        CONSTRAINT(_bgView, rechargeBtn, Top, Equal, seqView, Bottom, 1.0, 20.0+(i/3)*(0.14*self.frame.size.height));
        CONSTRAINT(_bgView, rechargeBtn, Left, Equal, _bgView, Left, 1.0, 20.0+(i%3)*(0.21*self.frame.size.width));
        
        UILabel *kindLabel = [[[UILabel alloc]init]autorelease];
        kindLabel.translatesAutoresizingMaskIntoConstraints = NO;
        kindLabel.text = [self.rechargeArr objectAtIndex:i];
        kindLabel.textAlignment = NSTextAlignmentCenter;
        kindLabel.font = [UIFont systemFontOfSize:12.0];
        [_bgView addSubview:kindLabel];
        
        CONSTRAINT(_bgView, kindLabel, CenterX, Equal, rechargeBtn, CenterX, 1.0, 0);
        CONSTRAINT(_bgView, kindLabel, Top, Equal, rechargeBtn, Bottom, 1.0, 5);
       
    }
}

- (void)buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(rechargeButtonClick:andTheKindOfRecharge:)])
    {
        [self.delegate rechargeButtonClick:sender.tag andTheKindOfRecharge:[self.rechargeArr objectAtIndex:sender.tag]];
    }
    if (5 == sender.tag) {
        [UIView animateWithDuration:0.3 animations:^{
            _bgView.transform = CGAffineTransformMakeScale(0.6,0.6);
            _bgView.alpha = 0.5;
            self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else
    {
        [self hide];
    }
}

- (void)show
{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        
        UIViewController  *viewController = (UIViewController*)self.delegate;
        
        [viewController.view addSubview:self];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.alpha = 1;
    }];
}

- (void)hide
{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)handleTapGesture
{
    [self hide];
}





@end
