//
//  CAICreateThumbImage.c
//  Black & White Master
//
//  Created by 蔡宇 on 12-11-18.
//  Copyright (c) 2012年 蔡宇. All rights reserved.
//

#import "CAICreateThumbImage.h"

@implementation CAICreateThumbImage

+ (UIImage *)createThumbImage:(UIImage *)sourceImage size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [sourceImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)drawImage:(UIImage *)image withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    //CGContextRef context=UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.0f alpha:0.7].CGColor);
    //CGContextFillRect(context, CGRectMake(0.0f, 0.0f, size.width, size.height));
    //UIImage *backgroundImg=[UIImage imageNamed:@"CAIimage-background"];
    //[backgroundImg drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    CGRect rect;
    if (image.size.width>=image.size.height) {
        CGFloat newHeight=(size.width/image.size.width)*image.size.height;
        CGFloat newY=(size.height-newHeight)/2.0;
        rect=CGRectMake(0.0f, newY, size.width, newHeight);
    } else {
        CGFloat newWidth=(size.height/image.size.height)*image.size.width;
        CGFloat newX=(size.width-newWidth)/2.0;
        rect=CGRectMake(newX, 0.0f, newWidth, size.height);
    }
    
    [image drawInRect:rect];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)cutImage:(UIImage *)sourceImage
{
    CGSize imgSize=sourceImage.size;
    CGRect drawRect;
    if (imgSize.width>imgSize.height) {
        drawRect=CGRectMake(((imgSize.width-imgSize.height)/2.0), 0.0f, imgSize.height, imgSize.height);
    } else {
        drawRect=CGRectMake(0.0f, ((imgSize.height-imgSize.width)/2.0), imgSize.width, imgSize.width);
    }
    CGImageRef newImageRef=CGImageCreateWithImageInRect(sourceImage.CGImage, drawRect);
    UIImage *newImage=[[UIImage alloc]initWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

+ (UIImage*)fetchImage:(UIImage *)sourceImage InRect:(CGRect)frame
{
    CGImageRef newImageRef=CGImageCreateWithImageInRect(sourceImage.CGImage, frame);
    UIImage *newImage=[[UIImage alloc]initWithCGImage:newImageRef scale:1.0f orientation:sourceImage.imageOrientation];
    CGImageRelease(newImageRef);
    return newImage;
}

+ (UIImage*)shrinkImage:(UIImage*)original size:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale,
                                                 size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width * scale, size.height * scale),
                       original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    CGColorSpaceRelease(colorSpace);
    
    return final;
}

+ (UIImage*)createImage:(UIImage *)image withMask:(UIImage *)mask
{
    CGImageRef newCGImage=CGImageCreateWithMask(image.CGImage, mask.CGImage);
    UIImage *newImage=[UIImage imageWithCGImage:newCGImage];
    CGImageRelease(newCGImage);
    return newImage;
}

+ (UIImage*)changeImage:(UIImage *)image brightness:(CGFloat)brightness
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height));
    [image drawInRect:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height) blendMode:kCGBlendModeNormal alpha:brightness];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
