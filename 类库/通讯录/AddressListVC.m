//
//  AddressListVC.m
//  类库
//
//  Created by yingdongzhuoyue on 15/8/18.
//  Copyright (c) 2015年 ydzy. All rights reserved.
//

#import "AddressListVC.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ChineseString.h"
#import "kInterface.h"
#import "Model.h"
#import "Pinyin.h"

/**
 *  1.头文件
 *  2.协议
 */
//短信
#import <MessageUI/MessageUI.h>

@interface AddressListVC()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong) NSMutableDictionary *personDic;
@property (nonatomic,strong) NSArray *indexArr;
@property (nonatomic,strong) UITableView *ALTableView;

@end

@implementation AddressListVC

#pragma mark
#pragma mark -- life style
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"手机通讯录";
    self.view.backgroundColor  = [UIColor whiteColor];
    [self pareAlTableView];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _personDic = [self groupSort:[self address]];
    [_ALTableView reloadData];
}


#pragma mark
#pragma mark --init views
- (void)pareAlTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height}];
    _ALTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50.0f;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_ALTableView];
}


#pragma mark
#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_indexArr count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_indexArr objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_personDic objectForKey:[_indexArr objectAtIndex:section]] count];
}

#pragma mark - 索引
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArr;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *alTag =  NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:alTag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:alTag];
    }
    
    Model *mol = (Model *)[[_personDic objectForKey:[_indexArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = mol.name;
    cell.detailTextLabel.text = mol.tel;
    
    return cell;
    

}


#pragma mark
#pragma mark ---delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10010"]];

    [self showMessageView];
}


- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10010"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:NO completion:^{
        
    }];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}



#pragma mark
#pragma mark - 排序
- (NSMutableDictionary *)groupSort:(NSMutableArray *)sourceArr
{
    NSMutableArray *chineseStringsArray = [[NSMutableArray alloc] initWithCapacity:sourceArr.count];

    [sourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ChineseString *chineseString = [[ChineseString alloc] init];
        Model *personM = (Model *)sourceArr[idx];
        Pinyin *pinyin = [[Pinyin alloc] init];

        chineseString.string = IFISSTR(personM.name);
        chineseString.tel = IFISSTR(personM.tel);
        
        if (![chineseString.string isEqualToString:@""]) //判断名字是否为空
        {
            NSString *pinYinResult=[NSString string];  //存每个名字中每个字的开头大写字母
            chineseString.xing=[[NSString stringWithFormat:@"%c",[pinyin pinyinFirstLetter:[chineseString.string characterAtIndex:0]]] uppercaseString];//每个名字的姓
            for(int j=0;j<chineseString.string.length;j++)//遍历名字中的每个字
            {
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",[pinyin pinyinFirstLetter:[chineseString.string characterAtIndex:j]]] uppercaseString];//取出字中的开头字母并转为大写字母
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];//取出名字的所有字的开头字母
            }
            
            chineseString.pinYin=pinYinResult;//将名字中所有字的开头大写字母chinesestring对象的pinYin中

        }
        else
        {
            //名字为空的时侯
            chineseString.pinYin=@"";
        }
        
        [chineseStringsArray addObject:chineseString];//将包含名字的大写字母和名字的chinesestring对象存在数组中

    }];
    
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];//对pinyin 进行排序  就像sql中的order by后指定的根据谁排序   生成一个数组
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
#pragma mark
#pragma mark - 分组
    NSMutableSet *sexSet = [[NSMutableSet alloc] init]; //存储所有同学的姓（去重）
    NSMutableArray *sexArray = [NSMutableArray arrayWithCapacity:0];//将不重复的姓从集合转为数组（便于操作）

    for(int i = 0 ; i < [chineseStringsArray count] ; i++)
    {
        [sexSet addObject:((ChineseString *)[chineseStringsArray objectAtIndex:i]).xing];

    }
    sexArray = (NSMutableArray *)[sexSet allObjects];
    
    _indexArr = [sexArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];//将不重复的姓按照字符表进行排序
    
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableDictionary *personDic = [[NSMutableDictionary alloc]init]; //人物字典

    for (int i=0; i<[_indexArr count]; i++)//遍历所有不重复的姓
    {
        for (int j=0; j<[chineseStringsArray count]; j++)//遍历所有人物
        {
            ChineseString *chineseM = chineseStringsArray[j];
            if ([chineseM.xing isEqualToString:[_indexArr objectAtIndex:i]]) //将每个学生的姓跟每个姓比较
            {
                Model *model = [[Model alloc] init];
                model.name = chineseM.string;
                model.tel = chineseM.tel;
                [modelArray addObject:model];
            }
        }
        [personDic setObject:modelArray forKey:[_indexArr objectAtIndex:i]];
        modelArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    

//    NSLog(@"presonDic == %@",personDic);
   

    return personDic;
}


#pragma mark - 获取通讯录里联系人姓名和手机号
- (NSMutableArray *)address
{
   NSMutableArray *addressArr = [[NSMutableArray alloc] init];
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    //判断是否在ios6.0版本以上
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        //获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        CFErrorRef* error=nil;
        addressBooks = ABAddressBookCreateWithOptions(NULL, error);
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        Model *addressBook = [[Model alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        }else {
            if ((__bridge id)abLastName != nil){
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        //        addressBook.recordID = (int)ABRecordGetRecordID(person);
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
//                        NSLog(@"%@",addressBook.tel);
                        break;
                    }
                        //                    case 1: {// Email
                        //                        addressBook.email = (__bridge NSString*)value;
                        //                        break;
                        //                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressArr addObject:addressBook];
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
    }

    return addressArr;

}


@end
