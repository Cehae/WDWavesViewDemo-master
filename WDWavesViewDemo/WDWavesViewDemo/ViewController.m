//
//  ViewController.m
//  WDWavesViewDemo
//
//  Created by WD on 16/9/25.
//  Copyright © 2016年 WD. All rights reserved.
//

#import "ViewController.h"
#import "WDWavesView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet WDWavesView *WavesView;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ViewController
- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.WavesView.frame.size.width/2-30, 0, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 30;
    }
    return _iconImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.WavesView.backgroundColor =[UIColor redColor];
    [_WavesView addSubview:self.iconImageView];
    
    __weak typeof(self)weakSelf = self;
    
    _WavesView.waveBlock = ^(CGFloat currentY){
        
        //修改头像view的高度
        CGRect iconFrame = weakSelf.iconImageView.frame;
        
        iconFrame.origin.y = CGRectGetHeight(weakSelf.WavesView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.WavesView.waveHeight;
        
        weakSelf.iconImageView.frame  =iconFrame;
    };
    [_WavesView startWaveAnimation];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
