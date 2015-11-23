//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by 郑克明 on 15/11/19.
//  Copyright © 2015年 郑克明. All rights reserved.
//

#import "HypnosisterView.h"
//类扩展
@interface HypnosisterView()
@property (strong,nonatomic) UIColor *circleColor;
@end

@implementation HypnosisterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
        self.multipleTouchEnabled = YES;
    }
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"红",@"绿",@"蓝"]];
    segmentedControl.frame = CGRectMake(bounds.size.width/4.0, 50, bounds.size.width/2.0, 50);
    //[segmentedControl:self:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmentedControl];
    return self;
}

-(void) setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = (bounds.origin.x + bounds.size.width)/2.0;
    center.y = (bounds.origin.y + bounds.size.height)/2.0;
//  float radius =(MIN(bounds.size.width, bounds.size.height)/2.0);
    float maxRadius = hypotf(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    }
    [path setLineWidth:10.0];
    //[[UIColor lightGrayColor] setStroke];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //CGContextSetStrokeColor(currentContext, CGColorGetComponents(CGColorCreate(colorspace,(CGFloat []){0.2,0,0,1})));
    //上面两句代码等于下面一行
    //CGContextSetStrokeColor(currentContext, (CGFloat []){0.2,0.2,0.2,0.3});
//    CGContextSetStrokeColor(currentContext, CGColorGetComponents(self.circleColor.CGColor));
    CGContextSetStrokeColorWithColor(currentContext, self.circleColor.CGColor);
    //先保存
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7),3);
    [path stroke];
    //添加渐变
    CGFloat location[2] = {0.0,1.0};
    CGFloat components[8] = {1.0,0.0,0.0,1.0,1.0,1.0,0.0,1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, location, 2);
    CGPoint startPoint = CGPointMake(10, 10);
    CGPoint endPoint = CGPointMake(80, 80);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    //剪切出一个三角形,再画上渐变,然后恢复画布
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGPoint triangleStartPoint,triangleMiddlePoint,triangleEndPoint;
    triangleStartPoint.x = bounds.size.width / 4.0 ;
    triangleStartPoint.y = bounds.size.height * (3/4.0);
    
    triangleMiddlePoint.x = bounds.size.width * (3/4.0);
    triangleMiddlePoint.y = triangleStartPoint.y;
    
    triangleEndPoint.x = (triangleStartPoint.x+triangleMiddlePoint.x) / 2.0;
    triangleEndPoint.y  = bounds.size.height / 4.0;
    
    [trianglePath moveToPoint:triangleStartPoint];
    [trianglePath addLineToPoint:triangleMiddlePoint];
    [trianglePath addLineToPoint:triangleEndPoint];
    
    //剪切三角形画布
    [trianglePath addClip];
    CGContextDrawLinearGradient(currentContext, gradient, CGPointMake(bounds.size.width/2.0, triangleStartPoint.y), triangleEndPoint, 2);
    
    CGContextRestoreGState(currentContext);
    
    CGContextSetShadow(currentContext, CGSizeMake(4, 7),3);
    UIImage *img = [UIImage imageNamed:@"logo.png"];
    [img drawInRect:CGRectMake(60, 100, 380/2.0,561/2.0)];
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
}
-(void)segmentAction:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    UIColor *c;
    switch (index) {
        case 0:
            c = [UIColor redColor];
            self.circleColor = c;
            break;
        case 1:
            c = [UIColor greenColor];
            self.circleColor = c;
            break;
        case 2:
            c = [UIColor blueColor];
            self.circleColor = c;
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@ was touched",self);
    float r = (arc4random()%100)/100.0;
    float g= (arc4random()%100)/100.0;
    float b = (arc4random()%100)/100.0;
    UIColor *randomColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    self.circleColor = randomColor;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@ was touched",self);
}

@end
