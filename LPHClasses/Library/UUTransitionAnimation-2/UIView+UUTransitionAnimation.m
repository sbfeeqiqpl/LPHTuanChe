//
//  UIView+UUTransitionAnimation.m
//  day17-UINavigationController-baseTransition
//
//  Created by 尤锐 on 15/8/6.
//  Copyright (c) 2015年 PSB. All rights reserved.
//

#import "UIView+UUTransitionAnimation.h"

@implementation UIView (UUTransitionAnimation)
- (void)setTransitionAnimationType:(UUTransitionAnimationType)transtionAnimationType toward:(UUTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration
{
    CATransition * transition = [CATransition animation];
    transition.duration = duration;
    NSArray * animations = @[@"cameraIris",
                             @"cube",
                             @"fade",
                             @"moveIn",
                             @"oglFilp",
                             @"pageCurl",
                             @"pageUnCurl",
                             @"push",
                             @"reveal",
                             @"rippleEffect",
                             @"suckEffect"];
    NSArray * subTypes = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    transition.type = animations[transtionAnimationType];
    transition.subtype = subTypes[transitionAnimationToward];
    
    [self.layer addAnimation:transition forKey:nil];
}


@end
