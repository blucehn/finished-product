//
//  UIBezierPathVC.m
//  类库
//
//  Created by ios on 15/7/8.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "UIBezierPathVC.h"
#import <MJExtension.h>

@interface User : NSObject

@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,copy  ) NSString *name;
@property (nonatomic,copy  ) NSString *age;
@property (nonatomic,copy  ) NSString *sex;

@end

@implementation User


@end


@interface UIBezierPathVC ()

@end

@implementation UIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIBezierPath";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    //画线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:(CGPoint){10,70}];
    [self addPoint:(CGPoint){10,70}];
    [path addLineToPoint:(CGPoint){10,300}];
    [self addPoint:(CGPoint){10,300}];
    [path addLineToPoint:(CGPoint){300,300}];
    [self addPoint:(CGPoint){300,300}];
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1.0f;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.5;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    [shapeLayer addAnimation:animation forKey:nil];
    
    _md.name = @"liyan";
    
    
    //json 转化为modle
    NSDictionary *dic = @{@"id":@"1",
                          @"name":@"liyan",
                          @"age":@"25",
                          @"sex":@"男"
    };
    
    User *user = [User objectWithKeyValues:dic];
    NSLog(@"%@\n%@\n%@\n%@\n",user.id,user.name,user.age,user.sex);
    
    
}


//添加圆点
- (void)addPoint:(CGPoint)point
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 8, 8)];
    view.userInteractionEnabled = YES;
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor brownColor].CGColor;
    
    //    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
