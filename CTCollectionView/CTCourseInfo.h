//
//  CTCourseInfo.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCourseInfo : NSObject

@property int day;
@property int startCourseNum;
@property int courseLen;
@property int courseId;
@property (strong,nonatomic) NSString *courseAddress;
@property (strong,nonatomic) NSString *coursePeriod;
@property (strong,nonatomic) NSString *courseName;

@end
