//
//  clsOtherFun.m
//  SummaryPro
//
//  Created by huweidong on 27/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsOtherFun.h"

@implementation clsOtherFun

+(CGSize)dealImageWith :(CGSize)imageSize{
    CGFloat objImgWidth=imageSize.width/2.0;
    CGFloat objImgHeight=imageSize.height/2.0;
    CGFloat imageHeight=objImgHeight;
    CGFloat imageWidth=objImgWidth;
    if (objImgWidth>=objImgHeight) {
        if (objImgWidth>(SCREEN_WIDTH-50)) {
            imageWidth=SCREEN_WIDTH-50;
            imageHeight=objImgHeight/objImgWidth*imageWidth;
        }else if(objImgWidth<100){
            imageWidth=100;
            imageHeight=objImgHeight/objImgWidth*imageWidth;
        }
        if(imageHeight>SCREEN_HEIGHT/5*4){
            imageHeight=SCREEN_HEIGHT/5*4;
            imageWidth=objImgWidth/objImgWidth*imageHeight;
        }
    }else{
        if(objImgHeight>SCREEN_HEIGHT/5*4){
            imageHeight=SCREEN_HEIGHT/5*4;
            imageWidth=objImgWidth/objImgHeight*imageHeight;
        }else if(objImgHeight<113){
            imageHeight=113;
            imageWidth=objImgWidth/objImgHeight*imageHeight;
        }
        if (imageWidth>(SCREEN_WIDTH-50)) {
            imageWidth=SCREEN_WIDTH-50;
            imageHeight=objImgHeight/objImgWidth*imageWidth;
        }
    }
    return CGSizeMake(imageWidth, imageHeight);
}

@end
