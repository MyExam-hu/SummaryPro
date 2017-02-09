//
//  UIImageView+ImageViewRadius.h
//  SummaryPro
//
//  Created by huweidong on 20/1/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageViewRadius)

- (void)hwd_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;

@end
