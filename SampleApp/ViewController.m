//
//  ViewController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/4/27.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "ViewController.h"

@interface TestView : UIView

@end

@implementation TestView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
}
- (void)didMoveToWindow
{
    [super didMoveToWindow];
}

@end
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

//从storyboard创建的时候会调用
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"initWithCoder");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [[UIViewController alloc]init];
    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
    //https://blog.csdn.net/gang544043963/article/details/48656545 会产生卡顿，解决方法
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    
//    cell.textLabel.text = @"主标题";
    cell.textLabel.text = [NSString stringWithFormat: @"主标题 - %@",@(indexPath.row)];
    cell.detailTextLabel.text = @"副标题";
    cell.imageView.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
    return cell;
    
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
@end
