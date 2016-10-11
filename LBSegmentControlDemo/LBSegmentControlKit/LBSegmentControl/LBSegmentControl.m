// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBSegmentControl





/**
 *  拖动的时候，手指不松开，点击上面的标题Item，会调用scrollView的
 *  代理方法，导致关闭scrollView的事件响应
 */

#import "LBSegmentControl.h"

#import "LBKitConst.h"
#import "LBSegment.h"
#import "UIView+ViewController.h"

typedef NS_ENUM(NSInteger, ScrollCtrlViewScrollStatus) {
    // 当前状态向左移动
    scrollCtrlViewScrollStatusToLeft,
    // 当前状态向右移动
    scrollCtrlViewScrollStatusToRight,
    // 正在状态静止
    scrollCtrlViewScrollStatusStatic,
};

@interface LBSegmentControl () <UIScrollViewDelegate>

/**
 *  是否是滑动标题
 */
@property (assign, nonatomic) BOOL isScrollTitle;

/**
 *  标题栏滑动试图
 */
@property (strong, nonatomic) UIScrollView * segementScrollView;

/**
 *  控制器试图滑动试图
 */
@property (strong, nonatomic) UIScrollView * scrollCtrlView;

/**
 *  底部栏试图
 */
@property (strong, nonatomic) UIView * bottomView;

/**
 *  当前选中索引
 */
@property (assign, nonatomic) LBSegment * currentItem;

/**
 *  将要选中的Item
 */
@property (assign, nonatomic) LBSegment * nextItem;

/**
 *  滑动控制器视图（下面的ScrollView）滑动状态
 */
@property (assign, nonatomic) ScrollCtrlViewScrollStatus scrollCtrlViewScrollStatus;

/**
 *  选中进度(1:选中状态，0:正常状态)
 */
@property (assign, nonatomic) CGFloat currentSelectProgress;

@end

@implementation LBSegmentControl

#pragma mark - Lifecycle

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置当前Item默认值
    self.currentItem = [self.segementScrollView viewWithTag:1995 + 0];
    
    // 必须要在这个方法中调用，因为在这里才可以知道响应者链的顺序
    [self.viewController.view addSubview:self.scrollCtrlView];
    
    // 创建默认的控制器试图
    [self addCtrlViewToScrollViewWithCtrlIndex:0];
    
    // 设置默认选中的Item
    self.currentItem.selectProgress = 1;
    // 为标题设置属性
    if (self.titles.count != 0) {
        for (UIView * subview in self.segementScrollView.subviews) {
            if ([subview isKindOfClass:[LBSegment class]]) {
                LBSegment * segment = (LBSegment *)subview;
                segment.titleNormalColor = self.titleNormalColor;
                segment.titleSelectColor = self.titleSelectColor;
                segment.isTitleScale = self.isTitleScale;
            }
        }
    }
    // 设置底部条的宽度
    self.bottomView.width = self.currentItem.width;
    // 设置底部条x值
    self.bottomView.left = 0;
    if (self.bottomView.subviews.count != 0) {
        UIImageView * imageView = [self.bottomView.subviews firstObject];
        imageView.left = (self.bottomView.width - imageView.width) / 2;
    }
    
}

/**
 *  初始化静止标题栏（不可左右拖动）
 */
- (instancetype)initStaticTitlesWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.isScrollTitle = NO;
        [self initDefault];
        [self creatSegementScrollView];
    }
    return self;
}

/**
 *  初始化滑动标题栏（可以左右拖动）
 */
- (instancetype)initScrollTitlesWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.isScrollTitle = YES;
        [self initDefault];
        [self creatSegementScrollView];
    }
    return self;
}

- (void)initDefault {
    self.titleNormalColor = segementColor_title_color;
    self.titleSelectColor = segementColor_title_select_color;
}
/**
 *  创建标题栏
 */
- (void)creatSegementScrollView {
    self.segementScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    // 隐藏滑动条
    self.segementScrollView.showsVerticalScrollIndicator = NO;
    self.segementScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.segementScrollView];
}

/**
 *  创建滑动控制器试图
 */
- (void)creatScrollCtrlView {
    // 滑动控制器试图y值
    CGFloat scrollCtrlViewY = self.origin.y + self.height;
    // 创建滑动控制器试图
    self.scrollCtrlView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollCtrlViewY, LBkScreen_width, LBkScreen_height - scrollCtrlViewY)];
    self.scrollCtrlView.contentSize = CGSizeMake(self.viewControllers.count * LBkScreen_width, 0);
    // 隐藏滑动条
    self.scrollCtrlView.showsVerticalScrollIndicator = NO;
    self.scrollCtrlView.showsHorizontalScrollIndicator = NO;
    self.scrollCtrlView.backgroundColor = [UIColor whiteColor];
    // 取消回弹效果
    self.scrollCtrlView.bounces = NO;
    self.scrollCtrlView.delegate = self;
    self.scrollCtrlView.pagingEnabled = YES;
}

#pragma mark - Custom Accessors

- (void)setTitles:(NSArray *)titles {
    _titles = titles;

    // Item的宽度
    CGFloat itemW = 0.0;
    CGFloat itemX = 0.0;
    for (int i = 0; i < titles.count; i ++) {
        // 判断是滑动还是静止标题栏
        if (self.isScrollTitle == YES) {
            // 滑动标题栏
            
            // 计算文本标签的Size
            CGSize labelSize = [self sizeWithText:titles[i] font:segementTitleNormalFont maxSize:CGSizeMake(LBkScreen_width, self.height)];
            // 计算Item的宽度  Item的宽度 = 本标签的宽度 + 间距
            itemW = labelSize.width + LBSegementViewTitlePadding / 2;
            // 设置contentSize
            self.segementScrollView.contentSize = [self getContentSize];
            // 滑动标题栏Item的x值在后面进行计算
        } else {
            // 静止标题栏
            
            // Item的宽度
            itemW = LBkScreen_width / titles.count;
            // Item的x值
            itemX = i * itemW;
            // 设置contentSize
            self.segementScrollView.contentSize = CGSizeMake(LBkScreen_width, 0);
        }
        LBSegment * segment = [[LBSegment alloc] initWithFrame:CGRectMake(itemX, 0, itemW, self.height)];
        segment.title = titles[i];
        segment.titleNormalColor = self.titleNormalColor;
        segment.titleSelectColor = self.titleSelectColor;
        
        segment.titleSelectBold = YES;
        segment.tag = 1995 + i;
        [segment addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.segementScrollView addSubview:segment];
        
        // 计算滑动标题栏Item的x值
        itemX += itemW;
    }
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    
    [self creatScrollCtrlView];
}

#pragma mark - IBActions(事件)

/**
 *  标题项点击事件
 */
- (void)itemAction:(LBSegment *)segment {
    
    // 设置滑动试图的偏移量
    [self.scrollCtrlView setContentOffset:CGPointMake(LBkScreen_width * (segment.tag - 1995), 0) animated:NO];
    
    // 赋值
    self.currentItem = segment;
    
    [self setSegementAnimate];
}

#pragma mark - Public

/**
 *  设置底部栏颜色(和底部栏图片只能设置一个)
 */
- (void)setBottomViewColor:(UIColor *)color {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - LBSegementViewBottomViewHeight, 0, LBSegementViewBottomViewHeight)];
    self.bottomView.backgroundColor = color;
    [self.segementScrollView addSubview:self.bottomView];
}

/**
 *  设置底部栏图片(和底部栏颜色只能设置一个)
 */
- (void)setBottomViewImage:(UIImage *)image {
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 10, 0, 10)];
    [self.segementScrollView addSubview:self.bottomView];
    // 设置图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    imageView.image = image;
    [self.bottomView addSubview:imageView];
}

/**
 *  取消底部栏
 */
- (void)cancelBottomView {
    self.bottomView = nil;
}

#pragma mark - Private

/**
 *  添加控制器的视图到滑动试图上
 */
- (void)addCtrlViewToScrollViewWithCtrlIndex:(NSInteger)ctrlIndex {
    // 创建试图控制器
    UIViewController * VC = self.viewControllers[ctrlIndex];
    // 判断试图有没有加载过
    if ([VC isViewLoaded]) {
        return;
    }
    // 设置子视图
    VC.view.frame = CGRectMake(ctrlIndex * LBkScreen_width, 0, LBkScreen_width, LBkScreen_height - self.origin.y);
    [self.scrollCtrlView addSubview:VC.view];
    [self.viewController addChildViewController:VC];
}

/**
 *  获取ContentSize
 */
- (CGSize)getContentSize {
    NSString * titleString = @"";
    for (NSString * title in self.titles) {
        titleString = [titleString stringByAppendingString:title];
    }
    // 计算总字符串得宽度
    CGSize stringWidth = [self sizeWithText:titleString font:segementTitleNormalFont maxSize:CGSizeMake(MAXFLOAT, self.height)];
    // 加上间距
    CGFloat totalWidth = stringWidth.width + self.titles.count * (LBSegementViewTitlePadding / 2);
    
    return CGSizeMake(totalWidth, 0);
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


/**
 *  修改选中进度
 */
- (void)changeSelectProgressWithCurrentIndex:(NSInteger)currentIndex {
    // 计算出当前选择的Item
    CGFloat selectIndex = self.scrollCtrlView.contentOffset.x / LBkScreen_width;
    // 计算出变化跨度是几
    CGFloat changeIndexNumber = selectIndex - currentIndex;
    // 取绝对值，向上取整操作
    changeIndexNumber = ceil(fabs(changeIndexNumber));
    // 获取将要选中的Item
    if (self.scrollCtrlViewScrollStatus == scrollCtrlViewScrollStatusToLeft) {
        // 试图向左拖拽
        self.nextItem = [self.segementScrollView viewWithTag:self.currentItem.tag + changeIndexNumber];
    } else if (self.scrollCtrlViewScrollStatus == scrollCtrlViewScrollStatusToRight) {
        // 试图向右拖拽
        self.nextItem = [self.segementScrollView viewWithTag:self.currentItem.tag - changeIndexNumber];
    }
    [UIView animateWithDuration:0.3 animations:^{
        // 设置将要选中Item的选择进度
        self.nextItem.selectProgress = 1 - self.currentSelectProgress;
        self.currentItem.selectProgress = self.currentSelectProgress;
        // 设置底部栏视图
        // 两个标题项中宽度的差
        CGFloat differenceW = self.nextItem.width - self.currentItem.width;
        // 设置动画增长或缩短宽度
        self.bottomView.width = self.currentItem.width + (differenceW * (1 - self.currentSelectProgress));
        // 两个标题项中x的差
        CGFloat differenceX = self.nextItem.left - self.currentItem.left;
        // 设置动画修改x值
        self.bottomView.left = self.currentItem.left + (differenceX * (1 - self.currentSelectProgress));
        // 判断底部条是否是图片，如果是图片设置图片
        if (self.bottomView.subviews.count != 0) {
            UIImageView * imageView = [self.bottomView.subviews firstObject];
            imageView.left = (self.bottomView.width - imageView.width) / 2;
        }

    }];
}

/**
 *  设置标题栏动画
 */
- (void)setSegementAnimate {
    // 当前选中的Item
    LBSegment * currentItem = self.currentItem;
    // 标题栏动画
    [UIView animateWithDuration:0.3 animations:^{
        // 判断能否设置居中（除开距离不够的）
        if (currentItem.center.x > (self.width / 2) && currentItem.center.x < (self.segementScrollView.contentSize.width - self.width / 2)) {
            // 居中的偏移量 = 标题按钮的偏移量 - 屏幕宽度的一半
            CGFloat contentOffsetX = currentItem.center.x - (LBkScreen_width / 2);
            self.segementScrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        } else if (currentItem.center.x < self.width / 2) {
            self.segementScrollView.contentOffset = CGPointMake(0, 0);
        } else if (currentItem.center.x > (self.segementScrollView.contentSize.width - self.width / 2)) {
            self.segementScrollView.contentOffset = CGPointMake(self.segementScrollView.contentSize.width - (self.width), 0);
        }
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = self.currentItem.tag - 1995;
    if (scrollView.contentOffset.x > (currentIndex * LBkScreen_width)) {
        // 向左滑动，偏移量变大
        self.currentSelectProgress = 1 - (fmod (scrollView.contentOffset.x, LBkScreen_width) / LBkScreen_width);
        // 设置手势是向左滑动
        self.scrollCtrlViewScrollStatus = scrollCtrlViewScrollStatusToLeft;
        // 保持从0 -> 1，也就是从非选中到选中状态
        if (self.currentSelectProgress == 0) {
            self.currentSelectProgress = 1;
        } else if (self.currentSelectProgress == 1) {
            self.currentSelectProgress = 0;
        }
    } else if (scrollView.contentOffset.x < (currentIndex * LBkScreen_width)) {
        // 向右滑动，偏移量变小
        self.currentSelectProgress = fmod (scrollView.contentOffset.x, LBkScreen_width) / LBkScreen_width;
        // 设置手势是向右滑动
        self.scrollCtrlViewScrollStatus = scrollCtrlViewScrollStatusToRight;
    }
    // 修改选中进度
    [self changeSelectProgressWithCurrentIndex:currentIndex];
    
    // 判断选中进度（其实不判断也可以，判断就不会一直调用节省性能）
    if (self.currentSelectProgress > 0.95 || self.currentSelectProgress == 0.0) {
        // 添加控制器试图到滑动试图上
        [self addCtrlViewToScrollViewWithCtrlIndex:self.nextItem.tag - 1995];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentIndex = scrollView.contentOffset.x / LBkScreen_width;
    self.currentItem = [self.segementScrollView viewWithTag:currentIndex + 1995];
    scrollView.scrollEnabled = YES;
    [self setSegementAnimate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.scrollEnabled = NO;
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    scrollView.scrollEnabled = YES;
    [self setSegementAnimate];
}


@end
