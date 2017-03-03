//
//  CustomPageControl.m
//  Eateraction
//
//  Created by huweidong on 3/3/2017.
//  Copyright © 2017年 com.zxd.eateraction. All rights reserved.
//

#import "CustomPageControl.h"

@interface CustomPageControl(private)  // 声明一个私有方法, 该方法不允许对象直接使用

- (void)updateDots;

@end

@implementation CustomPageControl

@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;

- (id)initWithFrame:(CGRect)frame { // 初始化
    self = [super initWithFrame:frame];
    return self;
}

- (void)setImagePageStateNormal:(UIImage *)image {  // 设置正常状态点按钮的图片
    imagePageStateNormal = image;
    [self updateDots];
}

- (void)setImagePageStateHighlighted:(UIImage *)image { // 设置高亮状态点按钮图片
    imagePageStateHighlighted = image;
    [self updateDots];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}

- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    [self updateDots];
}

- (void)updateDots { // 更新显示所有的点按钮
    if (imagePageStateNormal || imagePageStateHighlighted) {
        for (int i=0; i<[self.subviews count]; i++) {
            //圆点
            UIView* dot = [self.subviews objectAtIndex:i];
            //添加imageView
            if ([dot.subviews count] == 0) {
                UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
                [dot addSubview:view];
            };
            
            //配置imageView
            UIImageView * view = dot.subviews[0];
            
            if (i==self.currentPage) {
                view.image=imagePageStateHighlighted;
                dot.backgroundColor = [UIColor clearColor];
            }else {
                view.image=imagePageStateNormal;
                dot.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

- (void)dealloc {
    imagePageStateNormal=nil;
    imagePageStateHighlighted=nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
