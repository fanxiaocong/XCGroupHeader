
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
 *     类名：       GroupMemberItem.m
 *
 *     工程名称：   TTTT
 *
 *     创建人：     樊小聪
 *
 *     创建时间：   16/8/15
 */


/**
 *     备注：群组中每个成员的头像
 */

#import "XCGroupMemberItem.h"

// 裁剪角度与旋转角度的夹角
#define K_HEADER_CLIP_HALF_ANGLE 30.f

static inline float radians(double degrees) { return degrees * M_PI / 180; }

@interface XCGroupMemberItem ()

@property (nonatomic, assign) NSInteger degrees;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) BOOL isClip;

@end

@implementation XCGroupMemberItem

/**
 *  创建群组中每个成员的头像
 *
 *  @param frame   尺寸
 *  @param image   image对象
 *  @param scale   缩放比例
 *  @param degrees 放置角度
 *  @param isClip  是否裁剪
 */
+ (XCGroupMemberItem *)groupMemberItemWithFrame:(CGRect)frame
                                        image:(UIImage *)image
                                        scale:(CGFloat)scale
                                      degrees:(NSInteger)degrees
                                       isClip:(BOOL)isClip
{
    XCGroupMemberItem *item = [[XCGroupMemberItem alloc] initWithFrame:frame];
    
    item.backgroundColor = [UIColor clearColor];

    item.degrees = degrees;
    item.image   = image;
    item.scale   = scale;
    item.isClip  = isClip;
    
    return item;
}

- (void)setImage:(UIImage *)image
{
    if (_image != image)
    {
        _image = image;
    
        // 重绘
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = self.bounds;
    CGSize size = bounds.size;
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformRotate(transform, radians(_degrees));
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    if (_isClip)
    {
        CGPathAddArc(path, &transform, size.width / 2, size.height / 2, size.width / 2, radians((90 - K_HEADER_CLIP_HALF_ANGLE)), radians(90 + K_HEADER_CLIP_HALF_ANGLE), 1);
        CGPathAddArcToPoint(path,&transform,
                            size.width / 2,
                            size.height / 2 + (size.width / 2 * sin(radians(90 - K_HEADER_CLIP_HALF_ANGLE)) - size.width / 2 * sin(radians(K_HEADER_CLIP_HALF_ANGLE)) * tan(radians(K_HEADER_CLIP_HALF_ANGLE))),
                            size.width / 2 + size.width / 2 * sin(radians(K_HEADER_CLIP_HALF_ANGLE)),
                            size.height / 2 + size.width / 2 * sin(radians(90 - K_HEADER_CLIP_HALF_ANGLE)),
                            size.width / 2);
    }
    else
    {
        CGPathAddArc(path, &transform, size.width / 2, size.height / 2, size.width / 2, radians((90)), radians(90 + 0.01), 1);
    }
    CGContextAddPath(context, path);
    CGContextClosePath(context);
    CGContextClip(context);
    
    UIGraphicsPushContext( context );
    
    [_image drawInRect:rect];
    
    UIGraphicsPopContext();
    
    CFRelease(path);
}


@end






































