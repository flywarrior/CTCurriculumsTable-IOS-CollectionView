//
//  CLWeekViewController.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCollectionViewDataSource.h"
#import "CTCollectionView.h"
#import "CTDayViewController.h"

@interface CTWeekViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) CTCollectionView *myCollectionView;

@property (strong,nonatomic) CTCollectionViewDataSource *dataSource;

@property (strong,nonatomic) NSMutableArray *titleArray;

@property (strong,nonatomic) NSArray *colorArray;

@property (strong,nonatomic) CTDayViewController *myDayViewController;

@end
