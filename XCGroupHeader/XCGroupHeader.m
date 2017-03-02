
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//


/**
 *     类名：       GroupHeaderView.m
 *
 *     工程名称：   TTTT
 *
 *     创建人：     樊小聪
 *
 *     创建时间：   16/8/15
 */


/**
 *     备注：群组图片: 现在的处理方式是先移除所有的视图, 再添加新的图片(性能不是很好)
 */




#define K_SELF_WH self.bounds.size.height

#import "XCGroupHeader.h"
#import "XCGroupMemberItem.h"


static inline float radians(double degrees) { return degrees * M_PI / 180; }

@interface XCGroupHeader ()

@end

@implementation XCGroupHeader

#pragma mark - 🔓 👀 Public Method 👀


/**
 *  创建一个 群组头像的视图
 *
 *  @param headerWH         群组头像的宽、高
 *  @param placeholderImage 占位图片
 */
+ (instancetype)groupHeaderWithHeaderWH:(CGFloat)headerWH
                           placeholderImage:(UIImage *)placeholderImage
{
    XCGroupHeader *headerView = [[XCGroupHeader alloc] initWithFrame:CGRectMake(0, 0, headerWH, headerWH)];
    
    headerView.backgroundColor  = [UIColor clearColor];
    
    // 占位图片
    UIImage *placeholderImg = placeholderImage ? placeholderImage : [UIImage imageNamed:@"icon_head_group_placeholder"];
    
    [headerView addOneImages:@[placeholderImg]];
    
    return headerView;
}

+ (instancetype)groupHeaderWithHeaderWH:(CGFloat)headerWH
{
    return [self groupHeaderWithHeaderWH:headerWH placeholderImage:NULL];
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setImages:(NSArray<UIImage *> *)images
{
    if (!images || [images count] <= 0 || _images == images)
    {
        // 显示占位图片
        return;
    }
    
    _images = images;
    
    switch ([images count])
    {
        case 1:     // 只有一个成员的群组头像
        {
            [self addOneImages:images];
            break;
        }
        case 2:    // 有两个成员的群组头像
        {
            [self addTwoImages:images];
            break;
        }
        case 3:    // 有三个成员的群组头像
        {
            [self addThreeImages:images];
            break;
        }
        case 4:     // 有四个成员的群组头像
        {
            [self addFourImages:images];
            break;
        }
        case 5:    // 有五个成员的群组头像
        {
            [self addFiveImages:images];
            break;
        }
            
        default:
            break;
    }
}

/*
- (void)setUrls:(NSArray<NSString *> *)urls
{
    if (!urls || [urls count] <= 0 || _urls == urls)
    {
        return;
    }
    
    _urls = urls;
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    __weak typeof(self)weakSelf = self;
    
    switch ([urls count])
    {
        case 1:     // 只有一个成员的群组头像
        {
            // 下载图片
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urls.lastObject] options:SDWebImageLowPriority | SDWebImageRefreshCached progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                if (finished && image)
                {
                    [weakSelf addOneImages:@[image]];
                }
            }];
            
            break;
        }
        case 2:    // 有两个成员的群组头像
        {
            for (NSInteger index = 0; index < urls.count; index ++)
            {
                NSURL *url = [NSURL URLWithString:urls[index]];
                
                // 下载图片
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRefreshCached progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    if (finished && image)
                    {
                        [tempArr addObject:image];
                        
                        if (tempArr.count == 2)
                        {
                            [weakSelf addTwoImages:tempArr];
                        }
                    }
                }];
            }
            
            break;
        }
        case 3:    // 有三个成员的群组头像
        {
            for (NSInteger index = 0; index < urls.count; index ++)
            {
                NSURL *url = [NSURL URLWithString:urls[index]];
                
                // 下载图片
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRefreshCached progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    if (finished && image)
                    {
                        [tempArr addObject:image];
                        
                        if (tempArr.count == 3)
                        {
                            [weakSelf addThreeImages:tempArr];
                        }
                    }
                }];
            }
            
            break;
        }
        case 4:     // 有四个成员的群组头像
        {
            for (NSInteger index = 0; index < urls.count; index ++)
            {
                NSURL *url = [NSURL URLWithString:urls[index]];
                
                // 下载图片
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRefreshCached progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    if (finished && image)
                    {
                        [tempArr addObject:image];
                        
                        if (tempArr.count == 4)
                        {
                            [weakSelf addFourImages:tempArr];
                        }
                    }
                }];
            }
            
            break;
        }
        case 5:    // 有五个成员的群组头像
        {
            for (NSInteger index = 0; index < urls.count; index ++)
            {
                NSURL *url = [NSURL URLWithString:urls[index]];
                
                // 下载图片
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority | SDWebImageRefreshCached progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    if (finished && image)
                    {
                        [tempArr addObject:image];
                        
                        if (tempArr.count == 5)
                        {
                            [weakSelf addFiveImages:tempArr];
                        }
                    }
                }];
            }
            
            break;
        }
            
        default:
            break;
    }
    
}
 */

#pragma mark - 🔒 👀 Privite Method 👀

/**
 *  只有一个成员的群组头像
 *
 */
- (void)addOneImages:(NSArray <UIImage *> *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // header 的宽、高
    CGFloat diameter = K_SELF_WH;
    
    // 半径
    CGFloat r = diameter / 2;
    
    // 要显示图片的尺寸相对于header尺寸的缩放比例
    CGFloat scale = diameter / K_SELF_WH;
    
    UIImage *image = images[0];
    
    // 图片的实际尺寸
    CGSize imageSize = image.size;
    
    CGFloat correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);

    CGRect rect = [XCGroupHeader getRect:CGPointMake(r, r) size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:0 isClip:NO];
    
    [self addSubview:item];
}

/**
 *  有两个成员的群组头像
 */
- (void)addTwoImages:(NSArray <UIImage *> *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat diameter = (K_SELF_WH + K_SELF_WH - sqrtf(2) * K_SELF_WH);
    CGFloat r        = diameter / 2;
    CGFloat scale    = diameter / K_SELF_WH;
    
    UIImage *image       = images[0];
    CGSize imageSize     = image.size;
    CGFloat correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    
    CGRect rect = [XCGroupHeader getRect:CGPointMake(r, r) size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item1 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:0 isClip:NO];
   
    
    image        = images[1];
    imageSize    = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    rect = [XCGroupHeader getRect:CGPointMake(r + sqrtf(2) * diameter / 2, r + sqrtf(2) * diameter / 2) size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item2 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:180 - 45 isClip:YES];

    [self addSubview:item2];
    [self addSubview:item1];
}

/**
 *  有三个成员的群组头像
 */
- (void)addThreeImages:(NSArray <UIImage *> *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat diameter = K_SELF_WH / 2;
    CGFloat scale = diameter / K_SELF_WH;
    
    UIImage *image = images[0];
    CGSize imageSize = image.size;
    CGFloat correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center0 = CGPointMake(diameter, diameter / 2);
    CGRect rect = [XCGroupHeader getRect:center0 size:CGSizeMake(diameter, diameter)];
    
    XCGroupMemberItem *item1 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:30 isClip:YES];
    
    image = images[1];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(30)), diameter / 2 + diameter * cos(radians(30)));
    rect = [XCGroupHeader getRect:center1 size:CGSizeMake(diameter, diameter)];
    
    XCGroupMemberItem *item2 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:270 isClip:YES];
    
    image = images[2];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    rect = [XCGroupHeader getRect:center2 size:CGSizeMake(diameter, diameter)];
    
    XCGroupMemberItem *item3 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:180 - 30 isClip:YES];
    
    [self addSubview:item1];
    [self addSubview:item2];
    [self addSubview:item3];
}

/**
 *  有四个成员的群组头像
 */
- (void)addFourImages:(NSArray <UIImage *> *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat diameter = K_SELF_WH/2;
    CGFloat r = diameter / 2;
    CGFloat scale = diameter / K_SELF_WH;
    
    UIImage *image = images[0];
    CGSize imageSize = image.size;
    CGFloat correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center0 = CGPointMake(r, r);
    
    CGRect rect = [XCGroupHeader getRect:center0 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item1 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:0 isClip:YES];
    
    
    image = images[1];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center1 = CGPointMake(center0.x, center0.y + diameter);
    
    rect = [XCGroupHeader getRect:center1 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item2 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:270 isClip:YES];
    
    
    image = images[2];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center2 = CGPointMake(center1.x + diameter, center1.y);
    
    rect = [XCGroupHeader getRect:center2 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item3 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:180 isClip:YES];
    
    
    image = images[3];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center3 = CGPointMake(center2.x, center2.y - diameter);
    
    rect = [XCGroupHeader getRect:center3 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item4 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:90 isClip:YES];
    
    [self addSubview:item1];
    [self addSubview:item2];
    [self addSubview:item3];
    [self addSubview:item4];
}

/**
 *  有五个成员的群组头像
 */
- (void)addFiveImages:(NSArray <UIImage *> *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat r = K_SELF_WH / 2 / (2 * sin(radians(54)) + 1);
    CGFloat diameter = r * 2;
    CGFloat scale = diameter / K_SELF_WH;

    UIImage *image = images[0];
    CGSize imageSize = image.size;
    CGFloat correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center0 = CGPointMake(K_SELF_WH / 2, r);
    
    CGRect rect = [XCGroupHeader getRect:center0 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item1 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:54 isClip:YES];
    

    image = images[1];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center1 = CGPointMake(center0.x - diameter * sin(radians(54)), center0.y + diameter * cos(radians(54)));
    rect = [XCGroupHeader getRect:center1 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item2 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:270 + 72 isClip:YES];


    image = images[2];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center2 = CGPointMake(center1.x + diameter * cos(radians(72)), center1.y + diameter * sin(radians(72)));
    rect = [XCGroupHeader getRect:center2 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item3 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:270 isClip:YES];
    

    image = images[3];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center3 = CGPointMake(center2.x + diameter, center2.y);
    rect = [XCGroupHeader getRect:center3 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item4 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:180 + 18 isClip:YES];


    image = images[4];
    imageSize = image.size;
    correctScale = K_SELF_WH / MIN(imageSize.height, imageSize.width);
    CGPoint center4 = CGPointMake(center3.x + diameter * cos(radians(72)), center3.y - diameter * sin(radians(72)));
    rect = [XCGroupHeader getRect:center4 size:CGSizeMake(diameter, diameter)];
    XCGroupMemberItem *item5 = [XCGroupMemberItem groupMemberItemWithFrame:rect image:image scale:scale * correctScale degrees:90 + 36 isClip:YES];

    [self addSubview:item1];
    [self addSubview:item2];
    [self addSubview:item3];
    [self addSubview:item4];
    [self addSubview:item5];
}

+ (CGRect)getRect:(CGPoint)center size:(CGSize)size
{
    return CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
}



@end







































