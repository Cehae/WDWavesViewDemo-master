//
//  WDWavesView.h
//  WDWavesView-master
//
//  Created by WD on 16/9/25.
//  Copyright © 2016年 WD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WDWaveBlock)(CGFloat curY);

@interface WDWavesView : UIView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) WDWaveBlock waveBlock;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
