# LBSegmentControl

### 分栏导航框架
##### 支持功能:

- 支持静止分栏导航、滑动分栏导航（网易新闻顶部导航）
- 标题底部条、标题底部图标
- 切换动画效果
- 性能优化:在滑动到相应位置时再加载对应页面

##### 介绍
- 集成非常简单
- LBSegmentControl的自定义能力也非常强
- 性能也是尽量做到最佳
- 在LBSegmentControlImgs文件夹下面有一张默认的底部图标，在使用时可以用其他的图标替换掉，在LBSegmentControlTools文件夹下面是我使用的工具类，不可删除，如果在你的项目中也用到了，可删除掉一个

#### 使用方式
##### 初始化
```OBJC
/**
 *  初始化静止标题栏（不可左右拖动）
 */
- (instancetype)initStaticTitlesWithFrame:(CGRect)frame;

/**
 *  初始化滑动标题栏（可以左右拖动）
 */
- (instancetype)initScrollTitlesWithFrame:(CGRect)frame;
```
##### 设置标题底部试图
```OBJC
/**
 *  设置底部栏颜色(和底部栏图片只能设置一个)
 */
- (void)setBottomViewColor:(UIColor *)color;

/**
 *  设置底部栏图片(和底部栏颜色只能设置一个)
 */
- (void)setBottomViewImage:(UIImage *)image;
```

#### 设置标题
```OBJC
/**
 *  标题是否支持缩放(默认不支持)
 */
@property (assign, nonatomic) BOOL isTitleScale;
```
#### 效果图
![](http://p1.bpimg.com/567571/54dbfb91cab5e4af.gif)
![](http://p1.bpimg.com/567571/9d187f6872f23a79.gif)



