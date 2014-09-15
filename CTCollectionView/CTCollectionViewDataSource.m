//
//  CTCollectionViewDataSource.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTCollectionViewDataSource.h"
#import "CTCourseInfo.h"
#import "CTCollectionViewCell.h"
#import "CTHeadViewCell.h"

@implementation CTCollectionViewDataSource

- (id)init{
    
    self = [super init];
    if (self!=nil)
    {
        [self initTestData];
    }
    return self;
}

-(void) initTestData{
    CTCourseInfo *courseInfo = [[CTCourseInfo alloc]init];
    courseInfo.courseId = 0;
    courseInfo.day = 0;
    courseInfo.startCourseNum = 0;
    courseInfo.courseLen = 2;
    courseInfo.courseName = @"Object-C@王老师";
    courseInfo.courseAddress = @"第二教学楼203";
    courseInfo.coursePeriod = @"第3周到第17周";
    
    CTCourseInfo *courseInfo2 = [[CTCourseInfo alloc]init];
    courseInfo2.courseId = 1,
    courseInfo2.day = 0;
    courseInfo2.startCourseNum = 2;
    courseInfo2.courseLen = 2;
    courseInfo2.courseName = @"数据库@张老师";
    courseInfo2.courseAddress = @"第二教学楼205";
    courseInfo2.coursePeriod = @"第1周到第16周";
    
    CTCourseInfo *courseInfo3 = [[CTCourseInfo alloc]init];
    courseInfo3.courseId = 2;
    courseInfo3.day = 1;
    courseInfo3.startCourseNum = 4;
    courseInfo3.courseLen = 4;
    courseInfo3.courseName = @"航天航空概论@毛老师";
    courseInfo3.courseAddress = @"第三教学楼503";
    courseInfo3.coursePeriod = @"第3周到第17周";
    
    CTCourseInfo *courseInfo4 = [[CTCourseInfo alloc]init];
    courseInfo4.courseId = 3;
    courseInfo4.day = 3;
    courseInfo4.startCourseNum = 8;
    courseInfo4.courseLen = 3;
    courseInfo4.courseName = @"航天航空概论@高老师";
    courseInfo4.courseAddress = @"第二教学楼203";
    courseInfo4.coursePeriod = @"第3周到第17周";
    
    CTCourseInfo *courseInfo5 = [[CTCourseInfo alloc]init];
    courseInfo5.courseId = 4;
    courseInfo5.day = 4;
    courseInfo5.startCourseNum = 2;
    courseInfo5.courseLen = 2;
    courseInfo5.courseName = @"大学体育羽毛球@李老师";
    courseInfo5.courseAddress = @"第二教学楼203";
    courseInfo5.coursePeriod = @"第3周到第17周";
    
    CTCourseInfo *courseInfo6 = [[CTCourseInfo alloc]init];
    courseInfo6.courseId = 5;
    courseInfo6.day = 3;
    courseInfo6.startCourseNum =2;
    courseInfo6.courseLen = 2;
    courseInfo6.courseName = @"编不下去了@flywarrior";
    courseInfo6.courseAddress = @"第二教学楼203";
    courseInfo6.coursePeriod = @"第3周到第17周";
    
    CTCourseInfo *courseInfo7 = [[CTCourseInfo alloc]init];
    courseInfo7.courseId = 1;
    courseInfo7.day = 2;
    courseInfo7.startCourseNum =0;
    courseInfo7.courseLen = 2;
    courseInfo7.courseName = @"IOS开发教学@flywarrior";
    courseInfo7.courseAddress = @"第二教学楼403";
    courseInfo7.coursePeriod = @"第1周到第17周";
    
    _courseInfoArray = [NSMutableArray arrayWithObjects:courseInfo,courseInfo2,courseInfo3,courseInfo4,courseInfo5,courseInfo6,courseInfo7,nil];
}

- (NSArray *)indexPathsOfEventsBetweenMinDay:(int)minDay andMaxDay:(int)maxDay betweenCourseNum:(int)startCourseNum andCourseNum:(int)endCourseNum
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(int i = 0; i < _courseInfoArray.count ; ++i){
        CTCourseInfo *course = [_courseInfoArray objectAtIndex:i];
        if(course.day >= minDay && course.day <= maxDay && course.startCourseNum >= startCourseNum && course.startCourseNum + course.courseLen -1 <= endCourseNum){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}


- (NSComparisonResult) myCompare:(CTCourseInfo *)courseinfo {
    CTCourseInfo *now = (CTCourseInfo *)self;
    if(now.day > courseinfo.day)
        return NSOrderedAscending;
    else if(now.day < courseinfo.day)
        return NSOrderedDescending;
    else{
        if(now.startCourseNum >courseinfo.startCourseNum)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }
}

- (NSArray *)sortByDayAndCourseNumber{
    [_courseInfoArray sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
        CTCourseInfo *first = (CTCourseInfo *)obj1;
        CTCourseInfo *second = (CTCourseInfo *)obj2;
        if(first.day < second.day)
            return NSOrderedAscending;
        else if(first.day > second.day)
            return NSOrderedDescending;
        else{
            if(first.startCourseNum < second.startCourseNum)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }
    }];
    return _courseInfoArray;
}
@end
