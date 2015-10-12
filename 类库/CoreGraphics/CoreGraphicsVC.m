//
//  CoreGraphicsVC.m
//  类库
//
//  Created by yingdongzhuoyue on 15/7/20.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "CoreGraphicsVC.h"
#import <CoreGraphics/CoreGraphics.h>

#import "DSToast.h"


@interface CoreGraphicsVC ()

@property (nonatomic,strong) UIImageView *firstV;

@end

@implementation CoreGraphicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"核心物理库";
    self.view.backgroundColor = [UIColor whiteColor];
    [self perparView];
}

- (void)perparView{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){0,    64,self.view.frame.size.width,200}];
    _firstV = imgView;
    imgView.image = [UIImage imageNamed:@"nuo_big"];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    

    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
    [_firstV addGestureRecognizer:longPress];
    

    
    
    
    
    
    
    
    
    
}


#pragma mark 长按按钮
- (void)longClick:(UILongPressGestureRecognizer *)longPress{
    
    //目的绘制一个新的UIImageView 并且有放大悬浮的效果
    if (longPress.state == UIGestureRecognizerStateBegan) //长按开始
    {
        UIGraphicsBeginImageContextWithOptions(_firstV.frame.size, NO, 0.0f);
        //渲染自身
        [_firstV.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImageView *newImageView = [[UIImageView alloc] initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
        newImageView.center = _firstV.center;
        
        
        [self.view addSubview:newImageView];
        
        [UIView animateWithDuration:1 animations:^{
            newImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
        
    }
    
    if(longPress.state == UIGestureRecognizerStateChanged)//长按改变
    {
    
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded) //长按介绍
    {
        DSToast *toast = [[DSToast alloc] initWithText:@"仿照安卓的提示框"];
        [toast showInView:self.view showType:DSToastShowTypeCenter];
    }
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
