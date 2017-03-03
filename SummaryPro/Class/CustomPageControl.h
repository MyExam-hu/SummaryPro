//
//  CustomPageControl.h
//  Eateraction
//
//  Created by huweidong on 3/3/2017.
//  Copyright © 2017年 com.zxd.eateraction. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageControl : UIPageControl{
    UIImage *imagePageStateNormal;
    UIImage *imagePageStateHighlighted;
}

- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;

@end
