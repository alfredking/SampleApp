//
//  GTListLoader.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/6/29.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"

@implementation GTListLoader

-(void)loadListDataWithFinishBlock: (GTListLoaderFinishBlock)finishBlock
{
    [[AFHTTPSessionManager manager]GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
    
    NSArray<GTListItem *> *listData = [self _readDataFromLocal];
    if (listData) {
        finishBlock(YES , listData);
    }
    NSString * urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    NSLog(@"urlString");
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
#warning  类型的检查
        
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary*)jsonObj)objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc]init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }
        [weakSelf _archiveListDataWithArray:listItemArray.copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error == nil , listItemArray.copy);
            }
        });
        NSLog(@"completionHandler");
    }];
    [dataTask resume];
    //[self _getSandBoxPath];
    
}

#pragma private method
-(NSArray<GTListItem *> *)_readDataFromLocal
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiveObject = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil] fromData:readListData error:nil];
    
    if ([unarchiveObject isKindOfClass:[NSArray class]] && [unarchiveObject count]>0) {
        return (NSArray<GTListItem *> *)unarchiveObject;
    }
    
    return nil;
    
   
}
//-(void)_getSandBoxPath
-(void)_archiveListDataWithArray:(NSArray <GTListItem * > *)array
{
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachePath = [pathArray firstObject];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    NSError *createError;
    
//    createIntermediates
//    If true, this method creates any nonexistent parent directories as part of creating the directory in url. If false, this method fails if any of the intermediate parent directories does not exist.
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    
    //创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    //NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    

//
//    [[NSUserDefaults standardUserDefaults] setObject:@"abc" forKey:@"test"];
//    NSString *test = [[NSUserDefaults standardUserDefaults] objectForKey:@"test"];
    
//    [[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
//    NSData *testListData = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData"];
//
//    id unarchiveObject = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil] fromData:testListData error:nil];
//
    //查询文件
    //BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
    
    //删除
    
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    
//    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//    [fileHandler seekToEndOfFile];
//    [fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [fileHandler synchronizeFile]; //实时性要求不高可以不调
//    [fileHandler closeFile]; //其实fileHandler销毁的时候会自动关闭
    NSLog(@"getSandBoxPath");
}
@end
