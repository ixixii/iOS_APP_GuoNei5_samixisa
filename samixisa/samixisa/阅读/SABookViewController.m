//
//  SABookViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SABookViewController.h"
#import "SAFamilyHeadView.h"
#import "SABookTableViewCell.h"
#import "SAAddBookViewController.h"

@interface SABookViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_sa_tableView;
    NSMutableArray *_sa_bookArr;
}
@end

@implementation SABookViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadSAData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSAData];
    [self addSASubViews];
}

- (void)addSASubViews
{
    [self addSABgView];
    [self addSATableView];
}
- (void)addSABgView
{
    UIImageView *bgTAView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, sa_ScreenWidth, sa_ScreenHeight - 64 - 44)];
    bgTAView.image = [UIImage imageNamed:@"sa_login_background.png"];
    bgTAView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgTAView];
}
- (void)addSATableView
{
    UITableView *taTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 64, sa_ScreenWidth-40, sa_ScreenHeight - 64) style:UITableViewStylePlain];
    taTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:taTableView];
    
    taTableView.dataSource = self;
    taTableView.delegate = self;
    
    taTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _sa_tableView = taTableView;
    SAFamilyHeadView *taHeadView = [SAFamilyHeadView saFamilyHeadView];
    taHeadView.xib_sa_imgView_banner.image = [UIImage imageNamed:@"book_banner.png"];
    _sa_tableView.tableHeaderView = taHeadView;
    _sa_tableView.showsVerticalScrollIndicator = NO;
}
- (void)loadSAData
{
    NSArray *taArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_bookArr"];
    _sa_bookArr = [NSMutableArray arrayWithArray:taArr];
    if(_sa_tableView){
        [_sa_tableView reloadData];
    }
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sa_bookArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SABookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SABookTableViewCell"];
    if (cell == nil) {
        cell = [SABookTableViewCell saTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_sa_btn_del addTarget:self action:@selector(delSAButtonClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *accountDict = [_sa_bookArr objectAtIndex:indexPath.row];
    cell.xib_sa_label_book.text = [NSString stringWithFormat:@"书名：%@",accountDict[@"sa_book"]];
    cell.xib_sa_label_author.text = [NSString stringWithFormat:@"作者：%@",accountDict[@"sa_author"]];
    cell.xib_sa_label_count.text = [NSString stringWithFormat:@"字数：%@",accountDict[@"sa_count"]];
    cell.xib_sa_label_remark.text = [NSString stringWithFormat:@"阅读心得：%@",accountDict[@"sa_remark"]];
    cell.xib_sa_label_date.text = [NSString stringWithFormat:@"阅读日期：%@",accountDict[@"sa_date"]];
    cell.xib_sa_label_family.text = [NSString stringWithFormat:@"所属家人：%@",accountDict[@"sa_family"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 206;
}
#pragma mark - btn 事件
- (void)addSABtnClicked
{
    [self.navigationController pushViewController:[[NSClassFromString(@"SAAddBookViewController") alloc]init] animated:YES];
}

- (void)delSAButtonClickedFunc:(UIButton *)btn
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
        return;
    }
    
    UIAlertController *alertTACtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该读书记录？" preferredStyle:UIAlertControllerStyleAlert];
    [alertTACtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertTACtrl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delSABtnClicked:btn];
    }]];
    [self presentViewController:alertTACtrl animated:YES completion:nil];
}
- (void)delSABtnClicked:(UIButton *)btn
{
    while (![btn isMemberOfClass:[SABookTableViewCell class]]){
        btn = (UIButton *)[btn superview];
    }
    SABookTableViewCell *cell = (SABookTableViewCell *)btn;
    UITableView *tableView = (UITableView *)cell;
    while (![tableView isMemberOfClass:[UITableView class]]){
        tableView = (UITableView *)[tableView superview];
    }
    NSIndexPath *indexTAPath = [tableView indexPathForCell:cell];
    [_sa_bookArr removeObjectAtIndex:indexTAPath.row];
    [self abstract_saveSAData];
    [_sa_tableView reloadData];
}
- (void)abstract_saveSAData
{
    [[NSUserDefaults standardUserDefaults] setObject:_sa_bookArr forKey:@"userDefault_sa_bookArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - tableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentTAAccount = _sa_bookArr[indexPath.row];
    SAAddBookViewController *addTACtrl = [[SAAddBookViewController alloc]init];
    addTACtrl.model = currentTAAccount;
    [self.navigationController pushViewController:addTACtrl animated:YES];
}

@end
