//
//  DragVC.m
//  类库
//
//  Created by yingdongzhuoyue on 15/7/15.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "DragVC.h"
#import "TLDragButton.h"

static NSUInteger kCount = 4;
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface DragVC ()<TLDragButtonDelegate>


@end

@implementation DragVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"拖拽";
    
    NSMutableArray *array = [NSMutableArray array];
    CGFloat kMargin = 1;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - kMargin*(kCount + 1))/kCount;
    CGFloat height = 120;
    
    for (NSInteger index = 0; index < 12; index ++) {
        NSUInteger X = index % kCount;
        NSUInteger Y = index / kCount;
        
        TLDragButton *btn = [TLDragButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(X * (width + kMargin) + kMargin, Y * (height + kMargin) + 64, width, height);
        btn.backgroundColor = [self getColor];
        btn.dragColor = [UIColor blueColor];
        btn.delegate = self;
        [btn setTitle:[NSString stringWithFormat:@"%zi", index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [array addObject:btn];
        btn.btnArray = array;

    }

}



- (void)clickAction:(UIButton *)sender {
    NSString *currentTitle = sender.currentTitle;
    NSLog(@"你点中了：%@", currentTitle);
}

- (void)dragButton:(TLDragButton *)dragButton dragButtons:(NSArray *)dragButtons {
    NSString *currentTitle = dragButton.currentTitle;
    NSLog(@"%@位置发生了改变", currentTitle);
}

- (UIColor *)getColor {
    return RGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
