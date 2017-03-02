
/**
 *     类名：       GroupMemberItem.h
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

#import <UIKit/UIKit.h>

@interface XCGroupMemberItem : UIView

@property (nonatomic, strong) UIImage *image;

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
                                       isClip:(BOOL)isClip;

@end























