//
//  UIImage+ImageRadius.h
//  SummaryPro
//
//  Created by huweidong on 20/1/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageRadius)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
