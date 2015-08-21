//
//  ViewController.m
//  ShadowExample
//
//  Created by Manish Kumar on 19/08/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kShadowColor   [UIColor colorWithWhite:0.0 alpha:0.5]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createNormalShadowWithShadowOffset];
    //[self createTrapezoidalShadowToImage];
    //[self createOverallShadowToImage];
    //[self createEllepticalShadowBeneathImage];
    //[self createRoundedCornerShadow];
    //[self createCurlShadowForImageView];
    //[self createAnimatedShadows];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createNormalShadowWithShadowOffset{
    //applyiong shadow with offset to image
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius = 3.0;
}


-(void)createTrapezoidalShadowToImage{

    CGSize size = _imageView.bounds.size;
    
    //createing a trapezoidal path for shadow
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.20f, size.height * 0.80f)];
    [path addLineToPoint:CGPointMake(size.width * 0.80f, size.height * 0.80f)];
    [path addLineToPoint:CGPointMake(size.width * 1.20f, size.height * 1.20f)];
    [path addLineToPoint:CGPointMake(size.width * -0.20f, size.height * 1.20f)];
    [path closePath];

    //applying path as shadow to image
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius =2.0;
    _imageView.layer.shadowPath = path.CGPath;
}


-(void)createOverallShadowToImage{
    
    //applying overall shadow to image
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius = 6.0;
}


-(void)createEllepticalShadowBeneathImage{

    //create elliptical shdow forimage through UIBezierPath
    CGRect ovalRect = CGRectMake(0.0f, _imageView.frame.size.height + 10, _imageView.frame.size.width, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    
    //applying shadow to path
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius = 3.0;
    _imageView.layer.shadowPath = path.CGPath;
}


-(void)createRoundedCornerShadow{
    
    //make the image view rounded
    _imageView.layer.cornerRadius = _imageView.frame.size.width/ 2.0;
    _imageView.layer.masksToBounds = YES;
    
    //aplying rounded corner shadow to image
    [self putView:_imageView insideShadowWithColor:[UIColor colorWithWhite:0.0 alpha:0.8] andRadius:5.0 andOffset:CGSizeMake(0.0, 0.0) andOpacity:1.0];
}


-(void)createCurlShadowForImageView{
    //create a bezier path with curl effect
    CGSize size = _imageView.frame.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    //strating from left pont
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0.0, size.height + 20.0f)];
    
    //curved bottom part
    [path addCurveToPoint:CGPointMake(size.width, size.height + 20.0f)
            controlPoint1:CGPointMake(20.0f, size.height)
            controlPoint2:CGPointMake(size.width - 20.0f, size.height)];
    
    //closing the path by going upper top part
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];

    //close the path and apply the path as shadow
    [path closePath];
    
    //applying shadow to imageView thorugh the path created
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius = 3.0;
    _imageView.layer.shadowPath = path.CGPath;
}


-(void)createAnimatedShadows{
    
    //applying the shadow
    _imageView.layer.shadowColor = kShadowColor.CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(20.0, -20.0);
    _imageView.layer.shadowOpacity = 1.0;
    _imageView.layer.shadowRadius = 2.0;
    
    //providing animation to shadow
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(-20.0, -20.0)];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(20.0, -20.0)];
    animation.duration = 2.0;
    [_imageView.layer addAnimation:animation forKey:@"shadowOffset"];

}

//http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow#12969741
- (UIView*)putView:(UIView*)view insideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    CGRect shadowFrame; // Modify this if needed
    shadowFrame.size.width = 0.f;
    shadowFrame.size.height = 0.f;
    shadowFrame.origin.x = 0.f;
    shadowFrame.origin.y = 0.f;
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    shadow.userInteractionEnabled = NO; // Modify this if needed
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    [view.superview insertSubview:shadow belowSubview:view];
    [shadow addSubview:view];
    return shadow;
}



@end
