//
//  CTDayViewCell.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-12.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTDayViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseNum;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseAddress;
@property (weak, nonatomic) IBOutlet UILabel *coursePeriod;

@end
