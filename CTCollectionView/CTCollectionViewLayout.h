//
//  CTCollectionViewLayout.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCollectionViewDataSource.h"

@interface CTCollectionViewLayout : UICollectionViewLayout

@property (strong,nonatomic) CTCollectionViewDataSource* dataSource;

@end
