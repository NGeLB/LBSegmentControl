// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBSegmentControl




// 当前设备的物理尺寸
#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height

#import "ScrollSegmentControl.h"

#import "LBSegmentControl.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"

@interface ScrollSegmentControl ()

@end

@implementation ScrollSegmentControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建视图控制器
    FirstViewController * firstVC = [[FirstViewController alloc] init];
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    ThirdViewController * thirdVC = [[ThirdViewController alloc] init];
    FourthViewController * fourthVC = [[FourthViewController alloc] init];
    FifthViewController * fifthVC = [[FifthViewController alloc] init];
    SixthViewController * sixthVC = [[SixthViewController alloc] init];
    
    LBSegmentControl * segmentControl = [[LBSegmentControl alloc] initScrollTitlesWithFrame:CGRectMake(0, 20, kScreen_width, 45)];
    segmentControl.titles = @[@"第一页", @"第二页二", @"第三页第三页", @"第四页第四页第四页", @"第五", @"六六六六六六六六六六"];
    segmentControl.viewControllers = @[firstVC, secondVC, thirdVC, fourthVC, fifthVC, sixthVC];
    segmentControl.titleNormalColor = [UIColor blueColor];
    segmentControl.titleSelectColor = [UIColor redColor];
    //    [segementView setBottomViewColor:[UIColor blueColor]];
    [segmentControl setBottomViewImage:[UIImage imageNamed:@"upIcon.png"]];
    segmentControl.isTitleScale = YES;
    
    [self.view addSubview:segmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
