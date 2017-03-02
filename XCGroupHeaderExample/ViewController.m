//
//  ViewController.m
//  XCGroupHeaderExample
//
//  Created by 樊小聪 on 2017/3/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import "TextCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *dataArr;


@end

static NSString * const cellIdentifier = @"TextCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:NULL] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - 💤 👀 LazyLoad Method 👀

- (NSMutableArray<UIImage *> *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
        
        for (NSInteger i=0; i<30; i++)
        {
            NSInteger index = 1 + arc4random_uniform(5);
            NSMutableArray *mArr = [NSMutableArray array];
            
            for (NSInteger j=0; j<index; j++)
            {
                UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%zi.jpg", j+1]];
                [mArr addObject:img];
            }
            
            [_dataArr addObject:mArr];
        }
    }
    
    return _dataArr;
}

#pragma mark - 📕 👀 UITableViewDataSource 👀


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.imgs = self.dataArr[indexPath.row];
    
    return cell;
}


@end

