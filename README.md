#### 一，学习分享
今天加班很晚了，直接说重点，核心的东西只有两个地方:
#####1.CADisplayLink：利用刷帧和屏幕频率一样来重绘渲染页面，也就是说每次屏幕刷新的时候就会调用它的响应方法（屏幕一般一秒刷新60次），在绘图中需要重绘时常用它来代替NSTimer，因为NSTimer调度优先级比较低，并不会准时调用，做动画的话会有卡顿的感觉。创建方法：
```
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    // 添加主运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
```
#####2.CAShapeLayer：CALayer的子类,通常结合CGPath来绘制不规则矩形图形. 其创建方式:
```
CAShapeLayer *Layer = [CAShapeLayer layer];
Layer.frame =  self.bounds;
Layer.fillColor = self.realWaveColor.CGColor;//填充颜色
[self.view.layer addSublayer:Layer];
```
其优点：
###### 1.渲染效率高渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
###### 2.高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
###### 3.不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
###### 4.不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。
#### 二，思路以及代码实现
##### 1.开始动画
```
- (void)startWaveAnimation{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
```
##### 2.描述路径，并用CAShapeLayer绘制出来
```
- (void)wave{
    self.offset += self.waveSpeed;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveHeight;
    
    //真实波浪
    CGMutablePathRef realpath = CGPathCreateMutable();
    CGPathMoveToPoint(realpath, NULL, 0, height);
    CGFloat realY = 0.f;
    //背影波浪
    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    
    for (CGFloat x = 0.f; x <= width ; x++) {
        realY = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(realpath, NULL, x, realY);
        maskY = -realY;
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    
    //变化的中间Y值
    CGFloat centX = self.bounds.size.width/2;
    CGFloat CentY = height * sinf(0.01 * self.waveCurvature *centX  + self.offset * 0.045);
    if (self.waveBlock) {
        self.waveBlock(CentY);
    }
    
    CGPathAddLineToPoint(realpath, NULL, width, height);
    CGPathAddLineToPoint(realpath, NULL, 0, height);
    CGPathCloseSubpath(realpath);
    
    //描述路径后利用CAShapeLayer类绘制不规则图形
    self.realWaveLayer.path = realpath;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(realpath);
    
    CGPathAddLineToPoint(maskpath, NULL, width, height);
    CGPathAddLineToPoint(maskpath, NULL, 0, height);
    CGPathCloseSubpath(maskpath);
    
    //描述路径后利用CAShapeLayer类绘制不规则图形
    self.maskWaveLayer.path = maskpath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskpath);
}
```
##### 3.效果图：
![这里写图片描述](http://img.blog.csdn.net/20160925001825048)
