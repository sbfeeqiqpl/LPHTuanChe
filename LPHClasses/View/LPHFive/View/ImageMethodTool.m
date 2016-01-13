//
//  ImageMethodTool.m
//  LPHTuanChe
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 李鹏辉. All rights reserved.
//

#import "ImageMethodTool.h"

@implementation ImageMethodTool

+(UIImage *)imageWithSimpleImage:(UIImage *)image scaleToSize:(CGSize)newSize
{
    //获取当前图片的行文上下文
    UIGraphicsBeginImageContext(newSize);
    
    //OpenGL
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return newImage;
    
}
@end
