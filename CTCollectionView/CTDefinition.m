//
//  CTDefinition.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTDefinition.h"

@implementation CTDefinition

+(UIColor*)Rgb2UIColor:(NSInteger)r g:(NSInteger)g b:(NSInteger)b{
    return [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0];
}

+(UIColor*)UIColorFromRGB:(NSInteger)rgbValue{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

@end