//
//  HypnosisViewController.m
//  HypnoNed
//
//  Created by 郑克明 on 15/11/21.
//  Copyright © 2015年 郑克明. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisterView.h"


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
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hpnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgrounddView addSubview:textField];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"Call viewDidLoad on HypnosisViewController");
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
        heigth = arc4random() %heigth;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(width, heigth);
        messageLabel.frame = frame;
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        
        [messageLabel addMotionEffect:motionEffect];
    }
}
@end
