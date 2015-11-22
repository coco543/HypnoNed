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
}
@end
