//
//  CAICreateThumbImage.h
//  Black & White Master
//
//  Created by 蔡宇 on 12-11-18.
//  Copyright (c) 2012年 蔡宇. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CAICreateThumbImage : NSObject

+ (UIImage *)createThumbImage:(UIImage *)sourceImage size:(CGSize)size;

+ (UIImage *)cutImage:(UIImage*)sourceImage;

+ (UIImage *)fetchImage:(UIImage*)sourceImage InRect:(CGRect)frame;

+ (UIImage*)shrinkImage:(UIImage*)original size:(CGSize)size;

+ (UIImage*)drawImage:(UIImage*)image withSize:(CGSize)size;

+ (UIImage*)createImage:(UIImage*)image withMask:(UIImage*)mask;

+ (UIImage*)changeImage:(UIImage*)image brightness:(CGFloat)brightness;

@end
