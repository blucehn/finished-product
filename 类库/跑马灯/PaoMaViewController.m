//
//  PaoMaViewController.m
//  类库
//
//  Created by yingdongzhuoyue on 16/4/22.
//  Copyright © 2016年 ydzy. All rights reserved.
//

#import "PaoMaViewController.h"
#import "LSPaoMaView.h"

@interface PaoMaViewController ()

@end

@implementation PaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    
    LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width-20, 44) title:text];
    [self.view addSubview:paomav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
