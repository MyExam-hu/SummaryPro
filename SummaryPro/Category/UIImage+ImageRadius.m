//
//  UIImage+ImageRadius.m
//  SummaryPro
//
//  Created by huweidong on 20/1/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import "UIImage+ImageRadius.h"

@implementation UIImage (ImageRadius)

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r
{
    //放大后偏移回正确位置
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = size.width / image.size.width;
    CGFloat aspectHeight = size.height / image.size.height;
    CGFloat aspectRatio = MAX( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = image.size.width * aspectRatio;
    scaledImageRect.size.height = image.size.height * aspectRatio;
    scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0f;
    
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:r];
    CGContextAddPath(UIGraphicsGetCurrentContext(),bezierPath.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    //    [image drawInRect:rect];
    [image drawInRect:scaledImageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
