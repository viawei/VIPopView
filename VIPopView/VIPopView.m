//
//  VIPopView.m
//  VIPopView
//
//  Created by JM on 16/1/28.
//  Copyright © 2016年 xvv. All rights reserved.
//

#import "VIPopView.h"
#import "AppDelegate.h"

#define kDuration 0.5
#define ScreenWidth           [UIScreen mainScreen].bounds.size.width
#define ScreenHeight          [UIScreen mainScreen].bounds.size.height

@interface VIPopView ()<UITableViewDelegate, UITableViewDataSource>
/** 选中block */
@property (copy,nonatomic) void(^didSelectedAction)(NSInteger index);
/** 主视图 */
@property (strong, nonatomic) UIView *mainView;
/** popFrame */
@property (assign, nonatomic) CGRect popFrame;

@property (nonatomic, strong) UITableView *tableView;

/** 文字标题 */
@property (strong, nonatomic) NSArray *titleArr;
/** 图片 */
@property (strong, nonatomic) NSArray *imgArr;
/** 锚点位置 */
@property (assign, nonatomic) CGPoint anchorPoint;

@end

@implementation VIPopView

+ (instancetype)initPopViewWithFrame:(CGRect)frame titleArr:(NSArray *)titleArray imageArr:(NSArray *)imageArr anchorPoint:(CGPoint)anchorPoint didSelectedAction:(void (^)(NSInteger))action {
    return [[self alloc ]initPopViewWithFrame:frame titleArr:titleArray imageArr:imageArr anchorPoint:anchorPoint didSelectedAction:action];
}

- (instancetype)initPopViewWithFrame:(CGRect)frame titleArr:(NSArray *)titleArray imageArr:(NSArray *)imageArr anchorPoint:(CGPoint)anchorPoint didSelectedAction:(void (^)(NSInteger))action {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.titleArr = titleArray;
        self.imgArr = imageArr;
        self.popFrame = frame;
        self.anchorPoint = anchorPoint;
        self.didSelectedAction = action;
        [self setupUserInterface];
    }
    return self;
}

- (void)setupUserInterface {
    [self addSubview:self.mainView];
    
    CGRect frame = self.mainView.frame;
    
    self.mainView.layer.anchorPoint = self.anchorPoint;
    CGFloat anchorX = self.anchorPoint.x;
    CGFloat anchorY = self.anchorPoint.y;
    self.mainView.layer.position = CGPointMake(frame.origin.x + frame.size.width * anchorX * 0.5, frame.origin.y + frame.size.height * anchorY * 0.5);
    
    self.mainView.frame = self.popFrame;
    [self.mainView addSubview:self.tableView];
    [self show];
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:self.popFrame];
        _mainView.backgroundColor = [UIColor blackColor];
        [self addSubview:_mainView];
    }
    return _mainView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)show {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self];
    
    self.mainView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    
    //有弹簧效果
    [UIView animateWithDuration:kDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
    
    //没有弹簧效果
//    [UIView animateWithDuration:kDuration animations:^{
//        self.mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    }];
}

- (void)dismiss {
    [UIView animateWithDuration:kDuration animations:^{
        self.mainView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        [self.mainView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (self.imgArr.count == self.titleArr.count) {
        cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_didSelectedAction) {
        _didSelectedAction(indexPath.row);
    }
    [self dismiss];
}

@end
