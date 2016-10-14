// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBSegmentControl




#import <UIKit/UIKit.h>

@interface LBSegment : UIControl

typedef NS_ENUM(NSInteger, SegementItemCurrentStatus) {
    // 当前状态选中
    segementItemCurrentStatusSelect,
    // 当前状态正常
    segementItemCurrentStatusNormal,
    // 正在取消选中
    segementItemCurrentStatusDeselecting,
    // 正在选中
    segementItemCurrentStatusSelecting,
};

/**
 *  标题
 */
@property (copy, nonatomic) NSString * title;

/**
 *  选中颜色
 */
@property (strong, nonatomic) UIColor * selectColor;

/**
 *  正常颜色
 */
@property (strong, nonatomic) UIColor * normalColor;

/**
 *  选中标题颜色
 */
@property (strong, nonatomic) UIColor * titleSelectColor;

/**
 *  正常标题颜色
 */
@property (strong, nonatomic) UIColor * titleNormalColor;

/**
 *  选中标题是否加粗
 */
@property (assign, nonatomic) BOOL titleSelectBold;

/**
 *  选中进度 0 ~ 1
 */
@property (assign, nonatomic) CGFloat selectProgress;

/**
 *  当前状态
 */
@property (assign, nonatomic) SegementItemCurrentStatus currentStatus;

/**
 *  标题是否支持缩放(默认不支持)
 */
@property (assign, nonatomic) BOOL isTitleScale;
@end
