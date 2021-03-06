//
//  SwitchTitleView.h
//  LYMoveNavigation
//
//  Created by LuYang on 15/12/16.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SwitchBlock)(NSInteger index);
@interface SwitchTitleView : UIView
-(instancetype)initWithFrame:(CGRect)frame byTitltArray:(NSArray *)titleArray;
@property (nonatomic,strong)SwitchBlock switchBlock;
@end
