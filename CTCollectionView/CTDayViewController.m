//
//  CTDayViewController.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTDayViewController.h"
#import "CTDayViewCell.h"

@interface CTDayViewController ()

@property (nonatomic, strong) NSMutableArray *mondayCourseArray;
@property (nonatomic, strong) NSMutableArray *tuesdayCourseArray;
@property (nonatomic, strong) NSMutableArray *wednesdayCourseArray;
@property (nonatomic, strong) NSMutableArray *thursedayCourseArray;
@property (nonatomic, strong) NSMutableArray *fridayCourseArray;
@property (nonatomic, strong) NSMutableArray *saturdayCourseArray;
@property (nonatomic, strong) NSMutableArray *sundayCourseArray;
@property (nonatomic, assign) NSInteger monCourseArrayPosition;
@property (nonatomic, assign) NSInteger tuesCourseArrayPosition;
@property (nonatomic, assign) NSInteger wednesCourseArrayPosition;
@property (nonatomic, assign) NSInteger thurseCourseArrayPosition;
@property (nonatomic, assign) NSInteger friCourseArrayPosition;
@property (nonatomic, assign) NSInteger saturCourseArrayPosition;
@property (nonatomic, assign) NSInteger sunCourseArrayPosition;
@property (nonatomic, assign) NSInteger monCourseCount;
@property (nonatomic, assign) NSInteger tuesCourseCount;
@property (nonatomic, assign) NSInteger wednesCourseCount;
@property (nonatomic, assign) NSInteger thurseCourseCount;
@property (nonatomic, assign) NSInteger friCourseCount;
@property (nonatomic, assign) NSInteger saturCourseCount;
@property (nonatomic, assign) NSInteger sunCourseCount;
@property (nonatomic, strong) NSString * indicator;
@end



@implementation CTDayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _myView = [[UIView alloc]initWithFrame:self.view.frame];
    _myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
    self.mondayCourseArray = [[NSMutableArray alloc] init];
    self.tuesdayCourseArray = [[NSMutableArray alloc] init];
    self.wednesdayCourseArray = [[NSMutableArray alloc]init];
    self.thursedayCourseArray = [[NSMutableArray alloc] init];
    self.fridayCourseArray = [[NSMutableArray alloc] init];
    self.saturdayCourseArray = [[NSMutableArray alloc] init];
    self.sundayCourseArray = [[NSMutableArray alloc] init];
    [self _init];
}

- (void)_init{
    
    //初始化
    self.monCourseArrayPosition = 0;
    self.tuesCourseArrayPosition = 0;
    self.wednesCourseArrayPosition = 0;
    self.tuesCourseArrayPosition = 0;
    self.thurseCourseArrayPosition = 0;
    self.friCourseArrayPosition = 0;
    self.saturCourseArrayPosition = 0;
    self.sunCourseArrayPosition = 0;
    self.monCourseCount = 0;
    self.tuesCourseCount = 0;
    self.wednesCourseCount = 0;
    self.friCourseCount = 0;
    self.thurseCourseCount = 0;
    self.saturCourseCount = 0;
    self.sunCourseCount = 0;
    [self initCourseArray];
    [self initCourseArray2];
    //设置backgroundScrollView在window中的大小
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEADER_DAY_HEIGHT + 60, self.view.frame.size.width, self.view.frame.size.height - HEADER_DAY_HEIGHT)];
    
    //设置backgroundScrollView滑动范围大小
    self.backgroundScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 7, self.backgroundScrollView.frame.size.height);
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    [self.view addSubview:self.backgroundScrollView];
    
    //添加Indicator(它相对day的起点,X为5,Y为27,宽为day宽-2倍X,高为day高-27)
    self.dayIndicator = [[UIView alloc] initWithFrame:CGRectMake(INDICATOR_INDEX, HEADER_DAY_HEIGHT - 3 + 60,  HEADER_DAY_WIDTH - 2*INDICATOR_INDEX , 3)];
    self.dayIndicator.backgroundColor = [CTDefinition UIColorFromRGB:BLUE_COLOR];
    [self.view addSubview:self.dayIndicator];
    
    //在backgroundScrollView的top添加dayLabel(用于显示每天)
    NSArray *weekdayText = @[@"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", @"SUN"];
    for (NSInteger i = 0; i < 7; ++i) {
        
        //添加Label显示
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * HEADER_DAY_WIDTH, 60, HEADER_DAY_WIDTH, HEADER_DAY_HEIGHT)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [CTDefinition UIColorFromRGB:BLUE_COLOR];
        lab.alpha = 0.8;
        lab.text = weekdayText[i];
        lab.font = [UIFont systemFontOfSize:14];
        lab.tag = DAY_LABEL_TAG_BASE + i;
        [_myView addSubview:lab];
        
        //添加Button用于点击跳转
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * HEADER_DAY_WIDTH, 56, HEADER_DAY_WIDTH, HEADER_DAY_HEIGHT + 4);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = DAY_BUTTON_TAG_BASE + i;
        [btn addTarget:self action:@selector(selectWeekday:) forControlEvents:UIControlEventTouchUpInside];
        [_myView addSubview:btn];
        
        //添加TableView用于显示每天的课程信息
        UITableView *classTable = [[UITableView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.backgroundScrollView.frame.size.height + 5)];
        classTable.delegate = self;
        classTable.dataSource = self;
        classTable.showsHorizontalScrollIndicator = NO;
        classTable.showsVerticalScrollIndicator = NO;
        classTable.backgroundColor = [UIColor clearColor];
        classTable.tag = TABLE_VIEW_TAG_BASE + i;
        classTable.allowsSelectionDuringEditing = YES;
        //classTable.separatorStyle = UITableViewCellSelectionStyleNone;
        UINib *dayCourseInfoCellNib = [UINib nibWithNibName:@"CTDayViewCell" bundle:nil];
        [classTable registerNib:dayCourseInfoCellNib forCellReuseIdentifier:@"CTDayViewCell"];
        [self.backgroundScrollView addSubview:classTable];
    }
    
}

-(void) initCourseArray{
    self.mondayCourseArray = [[NSMutableArray alloc] init];
    self.tuesdayCourseArray = [[NSMutableArray alloc] init];
    self.wednesdayCourseArray = [[NSMutableArray alloc] init];
    self.thursedayCourseArray = [[NSMutableArray alloc] init];
    self.fridayCourseArray = [[NSMutableArray alloc] init];
    self.saturdayCourseArray = [[NSMutableArray alloc] init];
    self.sundayCourseArray = [[NSMutableArray alloc] init];
    NSArray *courseArray = [self.data sortByDayAndCourseNumber];
    for(CTCourseInfo *courseinfo in courseArray){
        BOOL flag = TRUE;
        while (flag) {
        switch (courseinfo.day + 1) {
            case 1:{
                if(_monCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_monCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_monCourseArrayPosition;
                    ++_monCourseArrayPosition;
                    [self.mondayCourseArray addObject:newCourse];
                }
                else{
                    [self.mondayCourseArray addObject:courseinfo];
                    _monCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 2:{
                if(_tuesCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_tuesCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_tuesCourseArrayPosition;
                    ++_tuesCourseArrayPosition;
                    [self.tuesdayCourseArray addObject:newCourse];
                }
                else{
                    [self.tuesdayCourseArray addObject:courseinfo];
                    _tuesCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 3:{
                if(_wednesCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_wednesCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_wednesCourseArrayPosition;
                    ++_wednesCourseArrayPosition;
                    [self.wednesdayCourseArray addObject:newCourse];
                }
                else{
                    [self.wednesdayCourseArray addObject:courseinfo];
                    _wednesCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 4:{
                if(_thurseCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_thurseCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_thurseCourseArrayPosition;
                    ++_thurseCourseArrayPosition;
                    [self.thursedayCourseArray addObject:newCourse];
                }
                else{
                    [self.thursedayCourseArray addObject:courseinfo];
                    _thurseCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 5:{
                if(_friCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_friCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_friCourseArrayPosition;
                    ++_friCourseArrayPosition;
                    [self.fridayCourseArray addObject:newCourse];
                }
                else{
                    [self.fridayCourseArray addObject:courseinfo];
                    _friCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 6:{
                if(_saturCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_saturCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_saturCourseArrayPosition;
                    ++_saturCourseArrayPosition;
                    [self.saturdayCourseArray addObject:newCourse];
                }
                else{
                    [self.saturdayCourseArray addObject:courseinfo];
                    _saturCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
            case 7:{
                if(_sunCourseArrayPosition < courseinfo.startCourseNum){
                    CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
                    newCourse.startCourseNum = (int)_sunCourseArrayPosition;
                    newCourse.courseLen = 2;
                    ++_sunCourseArrayPosition;
                    ++_sunCourseArrayPosition;
                    [self.sundayCourseArray addObject:newCourse];
                }
                else{
                    [self.sundayCourseArray addObject:courseinfo];
                    _sunCourseArrayPosition = courseinfo.startCourseNum + courseinfo.courseLen;
                    flag = FALSE;
                }
                break;
            }
        }
        }
    }
}

-(void) initCourseArray2{
    NSInteger len = COURSE_COUNT/2;
    if([self dayCourseArray:(_sundayCourseArray)]<len){
        for(NSInteger i = _sundayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_sunCourseArrayPosition;
            ++_sunCourseArrayPosition;
            ++_sunCourseArrayPosition;
            newCourse.courseLen = 2;
            [self.sundayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_saturdayCourseArray)]<len){
        for(NSInteger i = _saturdayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_saturCourseArrayPosition;
            ++_saturCourseArrayPosition;
            ++_saturCourseArrayPosition;
            newCourse.courseLen = 2;
            [_saturdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_fridayCourseArray)]<len){
        for(NSInteger i = _fridayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_friCourseArrayPosition;
            ++_friCourseArrayPosition;
            ++_friCourseArrayPosition;
            newCourse.courseLen = 2;
            [_fridayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_thursedayCourseArray)]<len){
        for(NSInteger i = _thursedayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_thurseCourseArrayPosition;
            ++_thurseCourseArrayPosition;
            ++_thurseCourseArrayPosition;
            newCourse.courseLen = 2;
            [_thursedayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_wednesdayCourseArray)]<len){
        for(NSInteger i = _wednesdayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_wednesCourseArrayPosition;
            ++_wednesCourseArrayPosition;
            ++_wednesCourseArrayPosition;
            newCourse.courseLen = 2;
            [_wednesdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_tuesdayCourseArray)]<len){
        for(NSInteger i = _tuesdayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_tuesCourseArrayPosition;
            ++_tuesCourseArrayPosition;
            ++_tuesCourseArrayPosition;
            newCourse.courseLen = 2;
            [_tuesdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_mondayCourseArray)]<len){
        for(NSInteger i = _mondayCourseArray.count ; i<len ;++i){
            CTCourseInfo *newCourse = [[CTCourseInfo alloc]init];
            newCourse.startCourseNum = (int)_monCourseArrayPosition;
            ++_monCourseArrayPosition;
            ++_monCourseArrayPosition;
            newCourse.courseLen = 2;
            [_mondayCourseArray addObject:newCourse];
        }
    }
}

- (void)selectWeekday:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag - DAY_BUTTON_TAG_BASE;
    [self changeDayIndicater:tag];
    
    CGRect frame = self.backgroundScrollView.frame;
    frame.origin.x = tag * self.view.frame.size.width;
    [self.backgroundScrollView scrollRectToVisible:frame animated:YES];
}

- (void)changeDayIndicater:(NSInteger)index
{
    //index表示当前选中Day所在的位置，currentIndex表示前一次选中Day所在位置
    if (index == self.currentIndex) return;
    
    //动画效果，Duration为动画持续时间，delay为动画开始前延迟调用的时间，animations为动画效果的代码块
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         UILabel *currentLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + self.currentIndex];
                         currentLab.alpha = 0.5;
                         
                         UILabel *newLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + index];
                         newLab.alpha = 1;
                         
                         self.currentIndex = (int)index;
                         
                         CGRect frame = self.dayIndicator.frame;
                         frame.origin.x = index * HEADER_DAY_WIDTH + INDICATOR_INDEX;
                         self.dayIndicator.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tableTag = tableView.tag;
    NSInteger rowNumber = COURSE_COUNT;
    switch (tableTag) {
        case TABLE_VIEW_TAG_BASE:
            rowNumber = _mondayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +1:
            rowNumber = _tuesdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +2:
            rowNumber = _wednesdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +3:
            rowNumber = _thursedayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +4:
            rowNumber = _fridayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +5:
            rowNumber = _saturdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +6:
            rowNumber = _sundayCourseArray.count;
            break;
        default:
            return 0;
            break;
    }
    return rowNumber;
}

- (NSInteger )dayCourseArray:(NSMutableArray *)dayCourseArray {
    NSInteger dayCourseLength = 0;
    for (int i = 0; i <dayCourseArray.count; ++i) {
        CTCourseInfo *courseInfo = [dayCourseArray objectAtIndex:i];
        if(courseInfo.courseName != nil)
            dayCourseLength += courseInfo.courseLen;
    }
    return dayCourseLength;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger tableTag = tableView.tag;
    CTCourseInfo *courseInfo = nil;
    int row = (int)indexPath.row;
    switch (tableTag) {
        case TABLE_VIEW_TAG_BASE:{
                courseInfo = [_mondayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+1:{
                courseInfo = [_tuesdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+2:{
                courseInfo = [_wednesdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+3:{
                courseInfo = [_thursedayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+4:{
                courseInfo = [_fridayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+5:{
                courseInfo = [_saturdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+6:{
                courseInfo = [_sundayCourseArray objectAtIndex:row];
                break;
        }
        default:
            break;
    }
    static NSString *indentifier = @"CTDayViewCell";
    CTDayViewCell *courseCell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (courseCell == nil) {
        courseCell = [[CTDayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    courseCell.courseName.text = courseInfo.courseName;
    courseCell.courseAddress.text = courseInfo.courseAddress;
        courseCell.courseNum.text = [NSString stringWithFormat:@"%d-%d",courseInfo.startCourseNum+1,(courseInfo.startCourseNum + courseInfo.courseLen - 1) + 1];
    courseCell.coursePeriod.text = courseInfo.coursePeriod;
    return courseCell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}


#pragma mark - scrollview delegate

//触摸屏幕来滚动画面还是其他的方法使得画面滚动，皆触发该函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 0) {
        self.isScrollingWeekday = YES;
    }
    if (!self.isScrollingWeekday && scrollView.contentOffset.x <= 0) {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
        return;
    }
}

//触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
    self.isScrollingWeekday = NO;
}

//滚动停止时，触发该函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.backgroundScrollView) {
        NSInteger page = floor((scrollView.contentOffset.x - self.view.frame.size.width / 2) / self.view.frame.size.width) + 1;
        [self changeDayIndicater:page];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
