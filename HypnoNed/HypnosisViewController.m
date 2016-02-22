//
//  HypnosisViewController.m
//  HypnoNed
//
//  Created by 郑克明 on 15/11/21.
//  Copyright © 2015年 郑克明. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisterView.h"

@interface HypnosisViewController () <UITextFieldDelegate>
@property (nonatomic,weak) UITextField *textField;
@end

@implementation HypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBarItem.title = @"Hypnotize";
        UIImage *img = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = img;
    }
    return self;
}


-(void)loadView{
    [super loadView];
    HypnosisterView *backgrounddView = [[HypnosisterView alloc] init];
    self.view = backgrounddView;
    
    //设置弹簧动画
//    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    CGRect textFieldRect = CGRectMake(40, -20, 240, 30);
    
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hpnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgrounddView addSubview:textField];
    self.textField = textField;
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"Call viewDidLoad on HypnosisViewController");
}
//视图一出现就开始执行动画
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame = CGRectMake(40, 70, 240, 30);
        self.textField.frame = frame;
    } completion:NULL];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"Pressing return.");
    [self drawHypnoticMessage:textField.text];
    return YES;
}

-(void)drawHypnoticMessage:(NSString *)message{
    for(int i = 0; i < 20; i++){
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        width = arc4random() % width;
        
        int heigth = self.view.bounds.size.height - messageLabel.bounds.size.height;
        heigth = arc4random() % heigth;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(width, heigth);
        messageLabel.frame = frame;
        [self.view addSubview:messageLabel];
        
        //第27章:添加动画效果
        //起始
        messageLabel.alpha = 0.0;
        /* 最简单的动画
        //由0.0 变到 1.0
        [UIView animateWithDuration:0.5 animations:^{
            messageLabel.alpha = 1.0;
        }];
         //*/
        
        //* 另一种动画  UIViewAnimationOptionCurveEaseIn 渐快函数
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            messageLabel.alpha = 1.0;
        } completion:NULL];
         //*/
        
        //* 关键帧动画 先移动到屏幕中间,再随机一个地方定下
        int mult = 3;
        [UIView animateKeyframesWithDuration:1.0 * mult delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                messageLabel.center = self.view.center;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                int x = arc4random() % width;
                int y = arc4random() % heigth;
                messageLabel.center = CGPointMake(x, y);
            }];
        } completion:NULL];
         //*/
        
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        
        [messageLabel addMotionEffect:motionEffect];
    }
}
@end
