//
//  CostomRechResultAlert.h
//  CostomRechargeAlertView
//
//  Created by 谢浩 on 15/8/5.
//  Copyright (c) 2015年 xiehao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomRechResultAlert : UIView
{
    UIView *_bgView;
}
@property (nonatomic,assign) NSInteger remainTime;
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) BOOL success;
- (id)initWithRemainTime:(NSInteger)remainTime andTheDelegate:(id)delegate isSuccess:(BOOL)success;
- (void)show;
@end

@protocol CostomRechResultAlertDelegate<NSObject>
@optional

- (void)rechargeResultButtonClick:(NSInteger)index;
@end