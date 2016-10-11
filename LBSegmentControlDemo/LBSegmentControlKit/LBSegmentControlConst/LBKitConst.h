// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBSegmentControl




#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "UIViewExt.h"
#import "UIView+ViewController.h"

// 当前设备的物理尺寸
#define LBkScreen_width [UIScreen mainScreen].bounds.size.width

#define LBkScreen_height [UIScreen mainScreen].bounds.size.height

// 颜色定义
#define LBkColor(r,g,b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#pragma mark - LBSegementView

// 设置标题选中字体(LBSegementView)
#define segementTitleSelectFont [UIFont systemFontOfSize:16 weight:1.5]

// 设置标题正常字体(LBSegementView)
#define segementTitleNormalFont [UIFont systemFontOfSize:14]

// 设置标题文本颜色(LBSegementView)
#define segementColor_title_color [UIColor colorWithRed:180 / 255.0 green:149 / 255.0 blue:111 / 255.0 alpha:1.0]

// 设置标题文本选中颜色(LBSegementView)
#define segementColor_title_select_color [UIColor colorWithRed:130 / 255.0 green:79 / 255.0 blue:15 / 255.0 alpha:1.0]


// 常量
// 分段控件标题之间的间距
UIKIT_EXTERN const CGFloat LBSegementViewTitlePadding;

// 分段控件底部视图的高度
UIKIT_EXTERN const CGFloat LBSegementViewBottomViewHeight;

// 分段控件标题缩放的最大比例(与正常状态对比)
UIKIT_EXTERN const CGFloat LBSegementViewTitleSelectMaxScale;




