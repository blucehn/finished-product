//
//  ViewController.m
//  类库
//
//  Created by ios on 15/7/3.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "ViewController.h"
#import "BaseTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BaseTextView *textView = [[BaseTextView alloc] init];
    textView.frame = (CGRect){10,100,300,300};
    textView.placeholder = @"默认文字";
    [self.view addSubview:textView];
    
    NSLog(@"%ud",textView.text.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
