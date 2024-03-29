//
//  GTRecommandViewController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/5/15.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTRecommandViewController.h"
#import "IGListKit.h"
#import "GTRecommendSectionController.h"
@interface GTRecommandViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation GTRecommandViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor greenColor];
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor lightGrayColor],[UIColor grayColor]];
    for (int i =0; i <5; i++)
    {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            [view addSubview:({
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
                view.backgroundColor = [UIColor yellowColor];
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
                tapGesture.delegate = self;
                [view addGestureRecognizer:tapGesture];
                view;
            })];
            view.backgroundColor = [colorArray objectAtIndex:i];
            view;
        })];
    }
    //scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}


-(void)viewClick
{
    NSURL *urlScheme = [NSURL URLWithString:@"testScheme://"];
    BOOL canOpenURL = [[UIApplication sharedApplication]canOpenURL:urlScheme]; //判断是否安装需要在infoplist设置白名单，否则无法判断
    [[UIApplication sharedApplication] openURL:urlScheme options:nil completionHandler:^(BOOL success) {
        NSLog(@"completionHandler");
    }];
    NSLog(@"viewClick");
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
// any offset changes
{
//    NSLog(@"scrollViewDidScroll -%@ ",@(scrollView.contentOffset.x));
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"BeginDragging");
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"EndDragging");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView // called on finger up as we are moving
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView     // called when scroll view grinds to a halt
{

}


//待git源代码更新再补充
//@interface GTRecommandViewController ()<IGListAdapterDelegate   ,IGListAdapterDataSource>
//
//@property(nonatomic,strong,readwrite)IGListCollectionView *collectionView;
//@property(nonatomic,strong,readwrite)IGListAdapter *adapter;
//
//@end
//
//@implementation GTRecommandViewController
//
//-(instancetype)init
//{
//    self = [super init];
//    if (self)
//    {
//
//        self.tabBarItem.title = @"推荐";
//        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
//        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc]init];
//
//    _adapter = [[IGListAdapter alloc]initWithUpdater:updater viewController:self workingRangeSize:0];
//    _adapter.collectionView = _collectionView;
//    _adapter.delegate = self;
//    _adapter.dataSource =self;
//
//
//    [self.view addSubview:({
//
//        IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc]initWithStickyHeaders:NO topContentInset:0 stretchToEdge:YES];
//        _collectionView = [[IGListCollectionView alloc]initWithFrame:self.view.bounds listCollectionViewLayout:layout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView;
//    })];
//
//    [_adapter reloadDataWithCompletion:nil];
//}
//
//#pragma mark -IGListAdapterDataSource
//
//
//- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
//{
//    return @[@"1",@"2",@"3",@"4",@"5"];
//}
//
//- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object
//{
//
//    return [[GTRecommendSectionController alloc]init];
//}
//
//
//- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
//{
//    return nil;
//
//}
//
//
//- (void)listAdapter:(IGListAdapter *)listAdapter willDisplayObject:(id)object atIndex:(NSInteger)index
//{
//
//}
//- (void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingObject:(id)object atIndex:(NSInteger)index
//{
//
//}
@end
