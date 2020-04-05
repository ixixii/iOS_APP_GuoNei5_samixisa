//
//  SAMineViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAMineViewController.h"

#import "SAMineHeadView.h"
#import "SAMineCell.h"

@interface SAMineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_sa_tableView;
    NSMutableArray *_sa_modelArr;
}

@end

@implementation SAMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if(_sa_modelArr.count == 3){
//        [_sa_modelArr addObject:@{
//            @"sa_icon": @"sa_logout.png",
//            @"sa_title": @"退出登陆"
//        }];
//        [_sa_tableView reloadData];
//    }
    
    BOOL tmpSAISLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"];
    if(tmpSAISLogin && _sa_modelArr.count == 3){
        [_sa_modelArr addObject:@{
            @"sa_icon": @"sa_logout.png",
            @"sa_title": @"退出登陆"
        }];
        [_sa_tableView reloadData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sa_addTableView];
}

- (void)sa_addTableView
{
    CGRect frame = CGRectMake(0, 0, sa_ScreenWidth, sa_ScreenHeight);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _sa_tableView = tableView;
    
    NSArray *tmpArr = @[
        @{
            @"sa_icon": @"sa_kefu.png",
            @"sa_title": @"电话客服",
            @"sa_detailText": @"16675565267"
        },
        @{
            @"sa_icon": @"sa_feedback.png",
            @"sa_title": @"反馈意见",
            @"sa_className": @"SAFeedViewController"
        },
        @{
            @"sa_icon": @"sa_about.png",
            @"sa_title": @"关于我们",
            @"sa_className": @"SAAboutViewController"
        }
    ];
    _sa_modelArr = [NSMutableArray arrayWithArray:tmpArr];
    SAMineHeadView *tmpHeadView = [SAMineHeadView saMineHeadView];
    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgTapped)];
    [tmpHeadView.xib_sa_headImg addGestureRecognizer:tapReco];
    _sa_tableView.tableHeaderView = tmpHeadView;
}
- (void)headImgTapped
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
        return;
    }
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sa_modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAMineCell"];
    if (cell == nil) {
        cell = [SAMineCell saMineCell];
    }
    cell = [self inflateCell:cell withModel:[_sa_modelArr objectAtIndex:indexPath.row]];
    return cell;
}
- (SAMineCell *)inflateCell:(SAMineCell *)cell withModel:(NSDictionary *)model
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;
    cell.imageView.image = [UIImage imageNamed:[model objectForKey:@"sa_icon"]];
    cell.textLabel.text = [model objectForKey:@"sa_title"];
    cell.detailTextLabel.text = [model objectForKey:@"sa_detailText"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_sa_modelArr[indexPath.row][@"sa_detailText"]]]];
            }
            break;
        case 1:
            {
                [self.navigationController pushViewController:[[NSClassFromString([[_sa_modelArr objectAtIndex:indexPath.row] objectForKey:@"sa_className"]) alloc]init] animated:YES];
            }
            break;
        case 2:
            {
                [self.navigationController pushViewController:[[NSClassFromString([[_sa_modelArr objectAtIndex:indexPath.row] objectForKey:@"sa_className"]) alloc]init] animated:YES];
            }
            break;
        case 3:
            {
                UIAlertController *sa_alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你是否退出登录？" preferredStyle:UIAlertControllerStyleAlert];
                [sa_alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [sa_alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull act) {
                    [SAMessageTool showSAMessage:@"发送中..." duration:3];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SAMessageTool showSAMessage:@"退出登录成功"];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"userDefault_sa_isLogin"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
                        
                        if(_sa_modelArr.count == 4){
                            // modelArr 将最后一个移除
                            [_sa_modelArr removeLastObject];
                            [_sa_tableView reloadData];
                        }
                    });
                }]];
                [self presentViewController:sa_alertController animated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
}

@end
