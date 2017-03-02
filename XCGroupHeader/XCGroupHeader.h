
/**
 *     类名：       GroupHeaderView.h
 *
 *     工程名称：   TTTT
 *
 *     创建人：     樊小聪
 *
 *     创建时间：   16/8/15
 */


/**
 *     备注：群组图片
 */

#import <UIKit/UIKit.h>

@interface XCGroupHeader : UIView

/** 👀 图片数组 👀 */
@property (strong, nonatomic) NSArray<UIImage *> *images;

/** 👀 图片地址数组: 此处为也方便演示, 暂时屏蔽 👀 */
@property (strong, nonatomic) NSArray<NSString *> *urls;


/**
 *  创建一个 群组头像的视图
 *
 *  @param headerWH         群组头像的宽、高
 *  @param placeholderImage 占位图片
 */
+ (instancetype)groupHeaderWithHeaderWH:(CGFloat)headerWH
                       placeholderImage:(UIImage *)placeholderImage;

/**
 *  创建一个 群组头像的视图
 *
 *  @param headerWH         群组头像的宽、高
 */
+ (instancetype)groupHeaderWithHeaderWH:(CGFloat)headerWH;


@end



























