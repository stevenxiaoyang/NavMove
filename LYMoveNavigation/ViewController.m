//
//  ViewController.m
//  LYMoveNavigation
//
//  Created by LuYang on 15/12/16.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "ViewController.h"
#import "SwitchTitleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titleArray = @[@"View1",@"View2",@"View3"];
    SwitchTitleView *navView = [[SwitchTitleView alloc]initWithFrame:CGRectMake(20, 24,self.view.frame.size.width - 40, 40) byTitltArray:titleArray];
    navView.switchBlock = ^(NSInteger index){
        NSLog(@"%ld",index);
    };
    self.navigationItem.titleView = navView;
}
@end
