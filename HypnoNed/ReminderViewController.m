//
//  ReminderViewController.m
//  HypnoNed
//
//  Created by 郑克明 on 15/11/21.
//  Copyright © 2015年 郑克明. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;
@end

@implementation ReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBarItem.title = @"Reminder";
        UIImage *img = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = img;
    }
    return self;
}

-(IBAction)addReminder:(id)sender{
    NSDate *date = self.datePicker.date;
    
    NSLog(@"Setting a reminder for %@",date);
    self.timeLabel.text = [NSString stringWithFormat:@"%@",date];
    //添加一个本地通知
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"时间到啦~";
    notification.fireDate = date;
    notification.timeZone=[NSTimeZone defaultTimeZone];
    
    //iOS8 之后需要注册通知,才能实现后台通知功能
    UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
@end
