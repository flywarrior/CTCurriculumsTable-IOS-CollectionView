//
//  CTCollectionViewLayout.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTCollectionViewLayout.h"
#import "CTDefinition.h"
#import "CTCourseInfo.h"


@implementation CTCollectionViewLayout

-(CGSize)collectionViewContentSize{
    //self.collectionView.bounds.size.width;
    CGFloat width = LEFT_EDGE_CELL_WIDTH + DAY_COUNT * COURSE_CELL_WIDTH;
    CGFloat hight = COURSE_COUNT * COURSE_CELL_HIGHT;
    CGSize size = CGSizeMake(width, hight);
    return size;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    
    NSArray *hourHeaderViewIndexPaths = [self indexPathsOfCourseViewsInRect:rect];
    for (NSIndexPath *indexPath in hourHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"CTHeadViewCell" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    return layoutAttributes;
}


//设置4.有时，collection view会为某个特殊的cell，supplementary或者decoration view向布局对象请求布局属性，而非所有可见的对象。这就是当其他三个方法开始起作用时，你实现的layoutAttributesForItemAtIndexPath：需要创建并返回一个单独的布局属性对象，这样才能正确的格式化传给你的index path所对应的cell。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForEvent:indexPath.row];
    //NSLog(@"row:%ld x:%f y:%f w:%f h:%f\n",(long)indexPath.row,attributes.frame.origin.x,attributes.frame.origin.y,attributes.frame.size.width,attributes.frame.size.height);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    //    CGFloat totalWidth = [self collectionViewContentSize].width;
    if ([kind isEqualToString:@"CTHeadViewCell"]) {
        attributes.frame = CGRectMake(0, LEFT_EDGE_CELL_HIGHT * indexPath.row,LEFT_EDGE_CELL_WIDTH, LEFT_EDGE_CELL_HIGHT);
        attributes.zIndex = -10;
        NSLog(@"row:%ld x:%f y:%f w:%f h:%f\n",(long)indexPath.row,attributes.frame.origin.x,attributes.frame.origin.y,attributes.frame.size.width,attributes.frame.size.height);
    }
    return attributes;
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    int minDay = [self dayIndexFromXCoordinate:CGRectGetMinX(rect)];
    int maxDay = [self dayIndexFromXCoordinate:CGRectGetMaxX(rect)];
    int startCourseNum = [self courseNumberFromYCoordinate:CGRectGetMinY(rect)];
    int endCourseNum = [self courseNumberFromYCoordinate:CGRectGetMaxY(rect)];

    NSArray *indexPaths = [self.dataSource indexPathsOfEventsBetweenMinDay:minDay andMaxDay:maxDay betweenCourseNum:startCourseNum andCourseNum:endCourseNum];
    return indexPaths;
}

- (NSArray *)indexPathsOfCourseViewsInRect:(CGRect)rect
{
    if (CGRectGetMinX(rect) > LEFT_EDGE_CELL_WIDTH) {
        return [NSArray array];
    }
    
    NSInteger startCourseNum = [self courseNumberFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger endCourseNum = [self courseNumberFromYCoordinate:CGRectGetMaxY(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = startCourseNum; idx <= endCourseNum; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

//根据X的位置返回所在的索引位置
- (int)dayIndexFromXCoordinate:(CGFloat)xPosition
{
    CGFloat contentWidth = xPosition - LEFT_EDGE_CELL_WIDTH;
    CGFloat widthPerDay = COURSE_CELL_WIDTH;
    int day = MAX(0, contentWidth/widthPerDay);
    return day;
}
//根据Y的位置返回所在的索引位置
- (int)courseNumberFromYCoordinate:(CGFloat)yPosition
{
    int courseNum = MAX(0, yPosition/COURSE_CELL_HIGHT);
    return courseNum;
}

//返回一节课程的cell的frame
- (CGRect)frameForEvent:(NSInteger)row
{
    CTCourseInfo *courseInfo = [self.dataSource.courseInfoArray objectAtIndex:row];
    CGRect frame = CGRectZero;
    frame.origin.x = LEFT_EDGE_CELL_WIDTH + courseInfo.day * COURSE_CELL_WIDTH + 2;
    frame.origin.y = courseInfo.startCourseNum * COURSE_CELL_HIGHT + 2;
    frame.size.width = COURSE_CELL_WIDTH - 4;
    frame.size.height = courseInfo.courseLen * COURSE_CELL_HIGHT - 4;
    return frame;
}

@end
