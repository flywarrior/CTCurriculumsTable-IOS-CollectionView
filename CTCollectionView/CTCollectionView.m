//
//  CTCollectionView.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTCollectionView.h"
#import "CTDefinition.h"

@implementation CTCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
-(void) drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.6f);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextMoveToPoint(context,  LEFT_EDGE_CELL_WIDTH, 0 );
    
    CGContextAddLineToPoint(context, LEFT_EDGE_CELL_WIDTH, COURSE_COUNT * LEFT_EDGE_CELL_HIGHT);
    
    CGContextStrokePath(context);
    for(int i = 1; i < COURSE_COUNT; ++i){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, LEFT_EDGE_CELL_WIDTH , i * LEFT_EDGE_CELL_HIGHT + 1);
        CGContextAddLineToPoint(context, 0, i * LEFT_EDGE_CELL_HIGHT + 1);
        CGContextStrokePath(context);
    }
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
