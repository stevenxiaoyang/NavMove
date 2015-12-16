//
//  SwitchTitleView.m
//  LYMoveNavigation
//
//  Created by LuYang on 15/12/16.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "SwitchTitleView.h"
static const CGFloat Button_Space = 10.f;
static const CGFloat Yellow_Line_Width = 70.f;
static const CGFloat Yellow_Line_Height = 2.f;
static const CGFloat Button_Height = 28.f;     //16+12
static const CGFloat Button_Width = 60.f;
static const CGFloat Bottom_Spacing = 4.f;
static const CGFloat Title_UnSelected_Font = 15.f;
static const CGFloat Title_Selected_Font = 18.f;
static const NSInteger ButtonTag = 1000;
#define Yellow_Collor [UIColor colorWithRed:255.f/255 green:192.f/255 blue:40.f/255 alpha:1]
#define Gray_Collor [UIColor colorWithRed:153.f/255 green:153.f/255 blue:153.f/255 alpha:1]

typedef enum:NSInteger
{
    LabelTitleCommonStyle,
    LabelTitleSelectedStyle
}LabelTitleStyle;

@interface SwitchTitleView()
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic, strong) UIView * heightLightView;
@property (nonatomic, strong) UIView * heightTopView;
@end

@implementation SwitchTitleView
{
    UIView    *yellowLineView;
    NSInteger arrayCount;
    CGFloat Button_Begin_X;
    CGFloat Space_X;
}
-(instancetype)initWithFrame:(CGRect)frame byTitltArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        arrayCount = titleArray.count;
        Button_Begin_X = frame.size.width/2 - 0.5*arrayCount*Yellow_Line_Width - 0.5*(arrayCount - 1)*Button_Space;
        Space_X = Yellow_Line_Width + Button_Space;

        [self addBottomLabel];
        [self addTopLabel];
        [self addButton];
    }
    return self;
}
#pragma mark -- Init
-(void)addBottomLabel
{
    for (NSInteger i = 0; i < arrayCount; i++) {
        UILabel *bottomLabel = [self createLabelWithIndex:i andTitleStyle:LabelTitleCommonStyle];
        [self addSubview:bottomLabel];
    }
}

-(void)addTopLabel
{
    _heightLightView = [[UIView alloc]initWithFrame:[self getButtonFrame:0]];
    /*
     这个要和nav的背景色一样的颜色
     */
    _heightLightView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1];
    _heightLightView.clipsToBounds = YES;
    yellowLineView = [[UIView alloc] initWithFrame:[self getYellowLineFrame:0]];
    [yellowLineView setBackgroundColor:Yellow_Collor];
    [_heightLightView addSubview:yellowLineView];
    
    _heightTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Button_Width, self.frame.size.height)];
    for (NSInteger i = 0; i < arrayCount; i++) {
        UILabel *highLightLabel = [self createLabelWithIndex:i andTitleStyle:LabelTitleSelectedStyle];
        [_heightTopView addSubview:highLightLabel];
    }
    [_heightLightView addSubview:_heightTopView];
    [self addSubview:_heightLightView];
}

-(void)addButton
{
    for (int i=0; i<arrayCount; i++) {
        UIButton *btn =[self createTitleButton:CGRectZero title:[_titleArray objectAtIndex:i] tag:i+ButtonTag];
        btn.frame = [self getButtonFrame:i];
        [self addSubview:btn];
    }
    
}


#pragma mark -- Create
-(UILabel *)createLabelWithIndex:(NSInteger) index andTitleStyle:(LabelTitleStyle) titleStyle
{
    UILabel *label = [[UILabel alloc]initWithFrame:[self getLabelFrame:index]];
    if (titleStyle == LabelTitleSelectedStyle) {
        label.frame = [self getTopViewFrame:index];
    }
    label.textAlignment = NSTextAlignmentCenter;
    [label setText:_titleArray[index]];
    UIColor *textColor = (titleStyle == LabelTitleCommonStyle)?Gray_Collor:Yellow_Collor;
    UIFont *textFont = (titleStyle == LabelTitleCommonStyle)?[UIFont systemFontOfSize:Title_UnSelected_Font]:[UIFont systemFontOfSize:Title_Selected_Font];
    
    [label setTextColor:textColor];
    [label setFont:textFont];
    return label;
}

- (UIButton *)createTitleButton:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn addTarget:self action:@selector(switchButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    btn.userInteractionEnabled = YES;
    return btn;
}


#pragma mark -- GetFrame
-(CGRect)getLabelFrame:(NSInteger) index
{
    CGRect frame = CGRectMake(Button_Begin_X + Space_X*index, self.frame.size.height - Button_Height - Yellow_Line_Height - Bottom_Spacing, Button_Width, Button_Height);
    return frame;
}

-(CGRect)getButtonFrame:(NSInteger) index
{
    CGRect frame = CGRectMake(Button_Begin_X + Space_X*index,0, Button_Width,self.frame.size.height);
    return frame;
}

-(CGRect)getTopViewFrame:(NSInteger) index
{
    CGRect frame = CGRectMake(Space_X*index,0, Button_Width,self.frame.size.height);
    return frame;
}


-(CGRect)getYellowLineFrame:(NSInteger) index
{
    CGRect lineFrame = CGRectMake(0, self.frame.size.height - Bottom_Spacing - Yellow_Line_Height, Yellow_Line_Width, Yellow_Line_Height);
    return lineFrame;
}

#pragma mark -- 动画
-(void)startAnimation:(NSInteger) index
{
    CGRect newLightViewFrame = [self getButtonFrame:index];
    CGRect newTopViewFrame = [self getTopViewFrame:-index];
    //newTopViewFrame
    [UIView animateWithDuration:0.6f animations:^{
        _heightLightView.frame = newLightViewFrame;
        _heightTopView.frame = newTopViewFrame;
    }];
}

#pragma mark -- Button Response
- (void)switchButtonPress:(UIButton *)btn{
    NSInteger newIndex = btn.tag - ButtonTag;    
    [self startAnimation:newIndex];
    self.switchBlock(newIndex);
}
@end
