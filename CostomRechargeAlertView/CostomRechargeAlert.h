//
//  CostomRechargeAlert.h
//  CostomRechargeAlertView
//
//  Created by 谢浩 on 15/8/5.
//  Copyright (c) 2015年 xiehao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomRechargeAlert : UIView
{
    UIView *_bgView;
}
@property (nonatomic,assign) NSInteger min;
@property (nonatomic,assign) NSInteger addMin;
@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSMutableArray *rechargeArr;
- (id)initWithCurrentChooseMin:(NSInteger)min addMin:(NSInteger)addMin withPrice:(NSInteger)price andDelegate:(id)delegate;
- (void)show;
- (void)hide;
@end

@protocol CostomRechargeAlertDelegate<NSObject>
@optional

- (void)rechargeButtonClick:(NSInteger)index andTheKindOfRecharge:(NSString *)rechargeKind;

@end