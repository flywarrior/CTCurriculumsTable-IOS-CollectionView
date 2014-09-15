//
//  CTWeekView.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTWeekView.h"
#import "CTDefinition.h"

@implementation CTWeekView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.6f);
    
    CGContextSetStrokeColorWithColor(context, [CTDefinition UIColorFromRGB:BLUE_COLOR].CGColor);
    
    CGContextMoveToPoint(context, 0, 65 + HEAD_CELL_HIGHT);
    
    CGContextAddLineToPoint(context, LEFT_EDGE_CELL_WIDTH + DAY_COUNT * COURSE_CELL_WIDTH, 65 + HEAD_CELL_HIGHT);
    
    CGContextStrokePath(context);
    for(int i = 0; i < 8; ++i){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, LEFT_EDGE_CELL_WIDTH + i * COURSE_CELL_WIDTH -0.5, 65 + HEAD_CELL_HIGHT );
        CGContextAddLineToPoint(context, LEFT_EDGE_CELL_WIDTH + i * COURSE_CELL_WIDTH - 0.5, 65);
        CGContextStrokePath(context);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
