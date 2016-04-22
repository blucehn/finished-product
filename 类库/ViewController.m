//
//  ViewController.m
//  类库
//
//  Created by ios on 15/7/3.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPathVC.h"
#import "DragVC.h"
#import "CorePullScaleVC.h"
#import "CoreGraphicsVC.h"
#import "AddressListVC.h"
#import "Modle.h"
#import "CycleScrollViewController.h"
#import "PaoMaViewController.h"

typedef enum{
    UIBezierPathStatus = 0,
    DragStatus,
    CorePullScaleStatus,
    CoreGraphicsStatus,
    AddressListStatus,
    CarouselStatus,
    PaoMaDengStatus
}cellStatus;


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView    *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) Modle          *md;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"类库";
    [self dataPapre];
    [self viewsPapre];


}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",_md.name);
}

- (void)dataPapre{
    NSMutableArray *array = [NSMutableArray array];
    _dataArray = array;
    [array addObject:@"UIBezierPath 曲线"];
    [array addObject:@"Drag-Views"];
    [array addObject:@"CorePullScale"];
    [array addObject:@"CoreGraphics（Toast）"];
    [array addObject:@"手机通讯录"];
    [array addObject:@"轮播"];
    [array addObject:@"跑马灯"];

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
    if (indexPath.row == UIBezierPathStatus)
    {
        _md = [[Modle alloc] init];
        _md.name = @"ly";
        UIBezierPathVC *vc = [[UIBezierPathVC alloc] init];
        
        Modle *md = [[Modle alloc] init];
        md.name = _md.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == DragStatus) {
        DragVC *vc = [[DragVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == CorePullScaleStatus) {
        CorePullScaleVC *vc = [[CorePullScaleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == CoreGraphicsStatus) {
        CoreGraphicsVC *vc = [[CoreGraphicsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == AddressListStatus) {
        AddressListVC *vc = [[AddressListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == CarouselStatus)
    {
        CycleScrollViewController *vc = [[CycleScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == PaoMaDengStatus)
    {
        PaoMaViewController *vc = [[PaoMaViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
}


//强制竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
