//
//  CTCollectionViewDataSource.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCollectionViewDataSource : NSObject

@property (strong,nonatomic) NSMutableArray *courseInfoArray;

- (NSArray *)indexPathsOfEventsBetweenMinDay:(int)minDay andMaxDay:(int)maxDay betweenCourseNum:(int)startCourseNum andCourseNum:(int)endCourseNum;
- (NSArray *)sortByDayAndCourseNumber;

@end
