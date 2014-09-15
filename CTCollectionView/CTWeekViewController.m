//
//  CLWeekViewController.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTWeekViewController.h"
#import "CTDefinition.h"
#import "CTCollectionViewLayout.h"
#import "CTHeadViewCell.h"
#import "CTCollectionViewCell.h"
#import "CTCourseInfo.h"


@interface CTWeekViewController ()

@end

@implementation CTWeekViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"日" style:UIBarButtonItemStylePlain target:self action:@selector(changeStyle)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initTitle];
    [self initColor];
    
    _dataSource = [[CTCollectionViewDataSource alloc]init];
    CTCollectionViewLayout *layout = [[CTCollectionViewLayout alloc] init];
    layout.dataSource = _dataSource;
    CGRect rect = self.view.bounds;
    rect.origin.y = rect.origin.y + 65 + HEAD_CELL_HIGHT;
    CGFloat width = LEFT_EDGE_CELL_WIDTH + DAY_COUNT * COURSE_CELL_WIDTH;
    CGFloat hight =  COURSE_COUNT * COURSE_CELL_HIGHT;
    rect.size = CGSizeMake(width, hight);
    
    _myCollectionView = [[CTCollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    _myCollectionView.alwaysBounceVertical = YES;
    //_myCollectionView.showsVerticalScrollIndicator  = NO;
    //_myCollectionView.showsHorizontalScrollIndicator = NO;
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    _myCollectionView.contentSize = rect.size;
    
    UINib *nib = [UINib nibWithNibName:@"CTCollectionViewCell" bundle:nil];
    [_myCollectionView registerNib:nib forCellWithReuseIdentifier:@"CTCollectionViewCell"];
    
    nib = [UINib nibWithNibName:@"CTHeadViewCell" bundle:nil];
    [_myCollectionView registerNib:nib forSupplementaryViewOfKind:@"CTHeadViewCell" withReuseIdentifier:@"CTHeadViewCell"];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _myCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview: _myCollectionView];
}

-(void)changeStyle{
    if(_myDayViewController == nil){
        _myDayViewController = [[CTDayViewController alloc]init];
    }
    _myDayViewController.data = _dataSource;
    [self.navigationController pushViewController:_myDayViewController animated:YES];
}

-(void) initTitle{
    _titleArray = [NSMutableArray array];
    NSArray *weekdayText = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    for (NSInteger i = 0; i < 7 ; ++i) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake( LEFT_EDGE_CELL_WIDTH + i  * COURSE_CELL_WIDTH + 1, 65 ,COURSE_CELL_WIDTH - 1, HEAD_CELL_HIGHT - 1)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [CTDefinition UIColorFromRGB:BLUE_COLOR];
        lab.alpha =1.0;
        lab.text = [weekdayText objectAtIndex:i];
        lab.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:lab];
    }
}

-(void) initColor{
    _colorArray = [NSArray arrayWithObjects:[UIColor orangeColor],[UIColor greenColor],[UIColor grayColor],[UIColor brownColor],[UIColor redColor],[UIColor yellowColor], nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSource.courseInfoArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CTCollectionViewCell";
    CTCourseInfo *courseInfo = [_dataSource.courseInfoArray objectAtIndex:indexPath.row];
    CTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell.courseName == nil){
        cell.layer.cornerRadius = 8;
        cell.courseName = [[UILabel alloc]initWithFrame:cell.bounds];
        cell.courseName.textAlignment = NSTextAlignmentCenter;
        cell.courseName.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:11];
        cell.courseName.textColor = [UIColor blackColor];
        cell.courseName.numberOfLines = 0;
        cell.alpha = 0.8;
        cell.courseName.text = courseInfo.courseName;
        [cell addSubview: cell.courseName];
    }
    else{
        cell.courseName = [[UILabel alloc]initWithFrame:cell.bounds];
        cell.courseName.text = courseInfo.courseName;
    }
    cell.backgroundColor = [_colorArray objectAtIndex:courseInfo.courseId%_colorArray.count];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CTHeadViewCell";
    
    CTHeadViewCell *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    if(headView == nil){
        headView = [[CTHeadViewCell alloc]init];
    }
    headView.courseNum.text = [[NSString alloc]initWithFormat:@"%ld",(long)indexPath.row + 1];
    return headView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
