//
//  ViewController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/4/27.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTMediator.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"
#import "GTSearchBar.h"
#import "GTScreen.h"
#import "GTCommentManager.h"
//@interface TestView : UIView
//
//@end
//
//@implementation TestView
//
//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}
//
//- (void)willMoveToSuperview:(nullable UIView *)newSuperview
//{
//    [super willMoveToSuperview:newSuperview];
//}
//- (void)didMoveToSuperview
//{
//    [super didMoveToSuperview];
//}
//- (void)willMoveToWindow:(nullable UIWindow *)newWindow
//{
//    [super willMoveToWindow:newWindow];
//}
//- (void)didMoveToWindow
//{
//    [super didMoveToWindow];
//}
//
//@end
@interface GTNewsViewController () <UITableViewDataSource,UITableViewDelegate,GTNormalTableViewCellDelegate>

@property(nonatomic,strong,readwrite)UITableView *tableView;
//@property(nonatomic,strong,readwrite)NSMutableArray *dataArray;
@property(nonatomic,strong,readwrite)NSArray *dataArray;
@property(nonatomic ,strong,readwrite)GTListLoader *listLoader;

@end

@implementation GTNewsViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
//        _dataArray = @[].mutableCopy;
//        for (int i=0; i<20; i++) {
//            [_dataArray addObject:@(i)];
//        }

    }
    return self;
}

////从storyboard创建的时候会调用
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        NSLog(@"initWithCoder");
//    }
//    return self;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
   /* [self.view addSubview:({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"hello world";
        [label sizeToFit];
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        label;//这一行是什么意思？ 注释掉无法运行，估计是label出了括号之外就被销毁了，引用一下就还会存在{}表达式返回的是label。这个是gcc的一种扩展，具体可见https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html 主要的作用就是优化代码结构，可以在代码较多的时候，更易阅读。重点就在于容易阅读，其实就是一个闭包的概念。
        
    })];//要自信啊，是他讲错了不是语法变了
    
//    int result1= ({
//        int a=3;
//        int b=5;
//        b;
//    });
//
//    int result12= ({
//        int a=3;
//        int b=5;
//        b;
//    });
//
//    NSLog(@"result1 is %d,result2 is %d",result1,result12);
    
*/
//    TestView *view = [[TestView alloc]init];
//    view.backgroundColor = [UIColor greenColor];
//    view.frame = CGRectMake(150, 150, 100, 100);
    
//    UIView *view2 = [[UIView alloc]init];
//    view2.backgroundColor = [UIColor greenColor];
//    view2.frame = CGRectMake(150, 150, 100, 100);
//
//    [self.view addSubview:view2];
    
//    [self.view addSubview:view];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushController)];
//    [view addGestureRecognizer:tapGesture];
//    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
//    tableView.dataSource = self;
//    tableView.delegate = self;
//    [self.view addSubview:tableView];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.listLoader = [[GTListLoader alloc]init];
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> *dataArray) {
        __strong typeof(wself) strongself = wself;
        strongself.dataArray = dataArray;
        NSLog(@"loadListDataWithFinishBlock");
        [strongself.tableView reloadData];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    //也可以在didload中添加searchbar，这里加方便演示
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.tabBarController.navigationItem setTitleView:({
    
//        GTSearchBar *searchBar = [[GTSearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-UI(20), self.navigationController.navigationBar.bounds.size.height)];
//        searchBar;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-UI(20), self.navigationController.navigationBar.bounds.size.height)];
        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(_showCommentView) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
//    __kindof UIViewController *detailController = [GTMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
//    UIViewController *controller = [[UIViewController alloc]init];
//    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
//    controller.view.backgroundColor = [UIColor whiteColor];//不设置颜色会卡顿
   // [self.navigationController pushViewController:detailController animated:YES];
    
//    [GTMediator openUrl:@"detail://" params:@{@"url":item.articleUrl,@"controller":self.navigationController}]; //问题在于调用方并不知道传什么值，只有查阅具体逻辑才知道
    
    Class cls =[GTMediator classForProtocol:@protocol(GTDetailViewControllerProtocol)];
    
    [self.navigationController pushViewController:[[cls alloc] initWithUrlString:item.articleUrl] animated:YES];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:item.uniqueKey];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
//    return 20;
    return _dataArray.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
//    }
//
////    cell.textLabel.text = @"主标题";
//    cell.textLabel.text = [NSString stringWithFormat: @"主标题 - %@",@(indexPath.row)];
//    cell.detailTextLabel.text = @"副标题";
//    cell.imageView.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
//    return cell;
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
    [cell layoutTabelViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(void)tableviewCell: (UITableViewCell *)tableViewCell clickDeleteButton : (UIButton *)deleteButton
{
//    NSLog(@"cell delegate");
//    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc]initWithFrame:self.view.bounds];
//    //    [deleteView showDeleteView];
//    CGRect rect = [tableViewCell  convertRect:deleteButton.frame toView:nil];
//    
//    __weak typeof(self) wself = self;
//    [deleteView showDeleteViewFromPoint:(CGPoint)rect.origin clickBlock:^{
//        NSLog(@"clickBlock");
//        __strong typeof(self) strongSelf = wself;
//        [strongSelf.dataArray removeLastObject];
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDidScroll");
}
////UIViewController demo
//-(void)pushController
//{
//    UIViewController *viewController = [[UIViewController alloc]init];
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.navigationItem.title = @"内容";
//
//    viewController .navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//}


-(void)_showCommentView
{
    [[GTCommentManager sharedManager]showCommentView];
}
@end
