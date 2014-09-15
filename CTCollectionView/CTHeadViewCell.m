//
//  CTHeadViewCell.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTHeadViewCell.h"
#import "CTDefinition.h"

@implementation CTHeadViewCell

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
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextSetStrokeColorWithColor(context, [CTDefinition UIColorFromRGB:BLUE_COLOR].CGColor);
    
    CGContextMoveToPoint(context, 0,  0);
    
    CGContextAddLineToPoint(context, LEFT_EDGE_CELL_WIDTH,  0);
    CGContextAddLineToPoint(context, LEFT_EDGE_CELL_WIDTH,  LEFT_EDGE_CELL_HIGHT);
    CGContextAddLineToPoint(context, 0,  LEFT_EDGE_CELL_HIGHT);

    CGContextStrokePath(context);
    
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
