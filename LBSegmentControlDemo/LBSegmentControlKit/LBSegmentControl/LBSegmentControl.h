// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBSegmentControl




#import <UIKit/UIKit.h>

@interface LBSegmentControl : UIView

/**
 *  初始化静止标题栏（不可左右拖动）
 */
- (instancetype)initStaticTitlesWithFrame:(CGRect)frame;

/**
 *  初始化滑动标题栏（可以左右拖动）
 */
- (instancetype)initScrollTitlesWithFrame:(CGRect)frame;

/**
 *  标题数组
 */
@property (strong, nonatomic) NSArray * titles;

/**
 *  控制器数组
 */
@property (strong, nonatomic) NSArray * viewControllers;

/**
 *  标题正常字体颜色
 */
@property (strong, nonatomic) UIColor * titleNormalColor;

/**
 *  标题选中字体颜色
 */
@property (strong, nonatomic) UIColor * titleSelectColor;

/**
 *  标题是否支持缩放(默认不支持)
 */
@property (assign, nonatomic) BOOL isTitleScale;
/**
 *  设置底部栏颜色(和底部栏图片只能设置一个)
 */
- (void)setBottomViewColor:(UIColor *)color;

/**
 *  设置底部栏图片(和底部栏颜色只能设置一个)
 */
- (void)setBottomViewImage:(UIImage *)image;

/**
 *  取消底部栏
 */
- (void)cancelBottomView;

@end
