//
//  ViewController.m
//  类库
//
//  Created by ios on 15/7/3.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPathVC.h"

typedef enum{
    UIBezierPathStatus = 0
}cellStatus;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Main Lists";
    [self dataPapre];
    [self viewsPapre];

    
}

- (void)dataPapre{
    NSMutableArray *array = [NSMutableArray array];
    _dataArray = array;
    [array addObject:@"UIBezierPath 曲线"];
}

- (void)viewsPapre{
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height}];
    _mainTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40.0f;
    [self.view addSubview:_mainTableView];
}

#pragma tableView datasource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const cellTag = @"cellTag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTag];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == UIBezierPathStatus) {
        UIBezierPathVC *vc = [[UIBezierPathVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
