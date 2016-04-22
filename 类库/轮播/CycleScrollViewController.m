//
//  CycleScrollViewController.m
//  类库
//
//  Created by yingdongzhuoyue on 16/4/22.
//  Copyright © 2016年 ydzy. All rights reserved.
//

#import "CycleScrollViewController.h"

//导入头文件
#import "SDCycleScrollView.h"
#import "UIView+SDAutoLayout.h"



@interface CycleScrollViewController ()

@end

@implementation CycleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *picImageNamesArray = @[@"nuo_big.png",@"nuo_big.png"];

    SDCycleScrollView *scrollView = [SDCycleScrollView new];
    scrollView.localizationImageNamesGroup = picImageNamesArray;
    [self.view addSubview:scrollView];
    scrollView.autoScroll = YES;
    
    
    scrollView.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(250);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
