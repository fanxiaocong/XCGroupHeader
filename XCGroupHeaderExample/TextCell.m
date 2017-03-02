//
//  TextCell.m
//  仿QQ群组头像
//
//  Created by 樊小聪 on 2017/2/28.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "TextCell.h"
#import "XCGroupHeader.h"

@interface TextCell ()

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) XCGroupHeader *headers;



@end

@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];

    XCGroupHeader *headerView = [XCGroupHeader groupHeaderWithHeaderWH:60];
    
    self.headers = headerView;
    
    [self.headerView addSubview:headerView];
}

- (void)setImgs:(NSArray<UIImage *> *)imgs
{
    _imgs = imgs;
    
    /** 👀 一般头像的图片来自于 url 数组, 这里只是方便演示, 就没有用 url 的方式 👀 */
    self.headers.images = imgs;
}

@end




























