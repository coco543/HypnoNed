//
//  QuizViewController.m
//  Quiz
//
//  Created by 郑克明 on 15/11/16.
//  Copyright © 2015年 郑克明. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()
@property (nonatomic,weak) IBOutlet UILabel *questionsLabel;
@property (nonatomic,weak) IBOutlet UILabel *answerLabel;

@property (nonatomic) int currentIndex;
@property (nonatomic,copy) NSArray *questions;
@property (nonatomic,copy) NSArray *answer;
@end

@implementation QuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.questions = @[@"From what is cognac made?",@"What is 7+7?",@"What is the capital of Vermont?"];
        self.answer = @[@"Grapes",@"14",@"Montpelier"];
    }
    self.title = @"问答";
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"start");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showQuestion:(id)sender{
    self.currentIndex++;
    if(self.currentIndex == [self.questions count]){
        self.currentIndex = 0;
    }
    NSString * q = self.questions[self.currentIndex];
    self.questionsLabel.text = q;
    self.answerLabel.text = @"???";
}
- (IBAction)showAnswer:(id)sender{
    NSString *ans = self.answer[self.currentIndex];
    self.answerLabel.text = ans;
    
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
