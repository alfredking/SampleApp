//
//  GTMineViewController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/26.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTMineViewController.h"
#import "GTLogin.h"
#import <SDWebImage.h>

@interface GTMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong,readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite) UIView *tableViewHeaderView;
@property(nonatomic,strong,readwrite) UIImageView *headerImageView;

@end

@implementation GTMineViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:({
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds  style:UITableViewStyleGrouped];//这个style表示什么意思
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView;
    })];
    
    
}

#pragma mark --

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineTableViewCell"];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_tableViewHeaderView)
    {
        _tableViewHeaderView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        _tableViewHeaderView.backgroundColor = [UIColor whiteColor];
        
        [_tableViewHeaderView addSubview:({
            _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,30, self.view.frame.size.width, 100)];
            _headerImageView.backgroundColor = [UIColor whiteColor];
            _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
            _headerImageView.clipsToBounds =YES;
            
            _headerImageView.userInteractionEnabled = YES;
            
            _headerImageView;
        })];
        
        [_tableViewHeaderView addGestureRecognizer:({
            UITapGestureRecognizer *tapGesture =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapImage)];
            tapGesture;
            
        })];
        
    }
    return _tableViewHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (![[GTLogin sharedLogin] isLogin])
    {
        [_headerImageView setImage:[UIImage imageNamed:@"icon.bundle/home@2x.png"]];
    }
    else
    {
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[GTLogin sharedLogin].avatarUrl]];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        cell.textLabel.text = [[GTLogin sharedLogin ]isLogin ] ? [GTLogin sharedLogin ].nick :@"昵称";
    }
    else
    {
        cell.textLabel.text = [[GTLogin sharedLogin ]isLogin ] ? [GTLogin sharedLogin ].address :@"地区";
    }
}

#pragma mark --

-(void)_tapImage
{
    if (![[GTLogin sharedLogin] isLogin])
    {
        [[GTLogin sharedLogin]loginWithFinishBlock:^(BOOL isLogin) {
            if (isLogin) {
                [self.tableView reloadData];
            }
        }];
    }
    else
    {
        [[GTLogin sharedLogin]logOut];
        [self.tableView reloadData];
    }
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
