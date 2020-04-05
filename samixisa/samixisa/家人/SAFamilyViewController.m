//
//  SAFamilyViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAFamilyViewController.h"
#import "SAFamilyHeadView.h"
#import "SAFamilyTableViewCell.h"
#import "SomeoneBookViewController.h"

@interface SAFamilyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_sa_tableView;
    NSMutableArray *_sa_familyArr;
}
@end

@implementation SAFamilyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadSAFamilyData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self pushSALoginViewController];
    
    [self loadSAFamilyData];
    
    [self addSASubViews];
}
- (void)loadSAFamilyData
{
    NSArray *tmpSAFamilyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_familyArr"];
    _sa_familyArr = [NSMutableArray arrayWithArray:tmpSAFamilyArr];
    if(!tmpSAFamilyArr){
        _sa_familyArr = [NSMutableArray arrayWithArray:@[
            @{
                @"sa_relation": @"我",
                @"sa_description": @"IT民工、二次元宅男",
                @"sa_writer": @"海明威、刘慈欣",
                @"sa_interest": @"推理、科幻、爱情、悲剧"
                
            }
        ]];
        [[NSUserDefaults standardUserDefaults] setObject:_sa_familyArr forKey:@"userDefault_sa_familyArr"];
        [[NSUserDefaults standardUserDefaults] setObject:@[
            @{
                @"sa_book": @"《三体》",
                @"sa_author": @"刘慈欣",
                @"sa_count": @"90万字",
                @"sa_remark": @"毁灭你，与你何干？",
                @"sa_date": @"2020-04-04 14:12",
                @"sa_family": @"我"
            }
        ] forKey:@"userDefault_sa_bookArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if(_sa_tableView){
        [_sa_tableView reloadData];
    }
}
- (void)addSASubViews
{
    [self addSABgView];
    [self addSAFamilyTableView];
}

- (void)addSABgView
{
    UIImageView *saFamilyBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, sa_ScreenWidth, sa_ScreenHeight - 64 - 44)];
    saFamilyBgView.contentMode = UIViewContentModeScaleAspectFill;
    saFamilyBgView.image = [UIImage imageNamed:@"sa_login_background.png"];
    [self.view addSubview:saFamilyBgView];
}
- (void)addSAFamilyTableView
{
    UITableView *tmpSAFamilyTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 64, sa_ScreenWidth-40, sa_ScreenHeight - 64) style:UITableViewStylePlain];
    tmpSAFamilyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tmpSAFamilyTableView];
    
    tmpSAFamilyTableView.dataSource = self;
    tmpSAFamilyTableView.delegate = self;
    
    tmpSAFamilyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _sa_tableView = tmpSAFamilyTableView;
    _sa_tableView.tableHeaderView = [SAFamilyHeadView saFamilyHeadView];

    _sa_tableView.showsVerticalScrollIndicator = NO;
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sa_familyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAFamilyTableViewCell"];
    if (cell == nil) {
        cell = [SAFamilyTableViewCell saFamilyTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_sa_button_delete addTarget:self action:@selector(delSAButtonClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *saFamilyDict = [_sa_familyArr objectAtIndex:indexPath.row];
    cell.xib_sa_label_relation.text = [NSString stringWithFormat:@"家人关系：%@",saFamilyDict[@"sa_relation"]];
    cell.xib_sa_label_description.text = [NSString stringWithFormat:@"家人描述：%@",saFamilyDict[@"sa_description"]];
    cell.xib_sa_label_writer.text = [NSString stringWithFormat:@"喜欢作家：%@",saFamilyDict[@"sa_writer"]];
    cell.xib_sa_label_interest.text = [NSString stringWithFormat:@"阅读热点：%@",saFamilyDict[@"sa_interest"]];
    return cell;
}
- (void)delSAButtonClickedFunc:(UIButton *)btn
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该家人，该家人所有的阅读记录也会随之删除？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delSAButtonClicked:btn];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)delSAButtonClicked:(UIButton *)taButton
{
    while (![taButton isMemberOfClass:[SAFamilyTableViewCell class]]){
        taButton = (UIButton *)[taButton superview];
    }
    SAFamilyTableViewCell *taCell = (SAFamilyTableViewCell *)taButton;
    UITableView *taTableView = (UITableView *)taCell;
    while (![taTableView isMemberOfClass:[UITableView class]]){
        taTableView = (UITableView *)[taTableView superview];
    }
    NSIndexPath *indexPath = [taTableView indexPathForCell:taCell];
    NSDictionary *currentSAFamilyDict = [_sa_familyArr objectAtIndex:indexPath.row];
    NSString *tmpSARelation = currentSAFamilyDict[@"sa_relation"];
    [_sa_familyArr removeObjectAtIndex:indexPath.row];
    NSArray *tmpSAAccountArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_bookArr"];
    NSMutableArray *resultSAAccountArr = [NSMutableArray array];
    for (NSDictionary *tmpSAAccountDict in tmpSAAccountArr) {
        if(![tmpSAAccountDict[@"sa_family"] isEqualToString:tmpSARelation]){
            [resultSAAccountArr addObject:tmpSAAccountDict];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:resultSAAccountArr forKey:@"userDefault_sa_bookArr"];
    
    [self abstract_saveSAFamilyData];
    [_sa_tableView reloadData];
}
- (void)abstract_saveSAFamilyData
{
    [[NSUserDefaults standardUserDefaults] setObject:_sa_familyArr forKey:@"userDefault_sa_familyArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
}
- (void)pushSALoginViewController
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:NO];
    }
}
#pragma mark - btn 事件
- (void)addSAButtonClicked
{
    [self.navigationController pushViewController:[[NSClassFromString(@"SAAddFamilyViewController") alloc]init] animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *saFamilyDict = _sa_familyArr[indexPath.row];
    SomeoneBookViewController *saCtrl = [[SomeoneBookViewController alloc] init];
    saCtrl.saFamilyDict = saFamilyDict;
    [self.navigationController pushViewController:saCtrl animated:YES];
}
@end
