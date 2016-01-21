//
//  UIView+UUTransitionAnimation.h
//  day17-UINavigationController-baseTransition
//
//  Created by 尤锐 on 15/8/6.
//  Copyright (c) 2015年 UU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    UUTransitionAnimationTypeCameraIris,
    //相机
    UUTransitionAnimationTypeCube,
    //立方体
    UUTransitionAnimationTypeFade,
    //淡入
    UUTransitionAnimationTypeMoveIn,
    //移入
    UUTransitionAnimationTypeOglFilp,
    //翻转
    UUTransitionAnimationTypePageCurl,
    //翻去一页
    UUTransitionAnimationTypePageUnCurl,
    //添上一页
    UUTransitionAnimationTypePush,
    //平移
    UUTransitionAnimationTypeReveal,
    //移走
    UUTransitionAnimationTypeRippleEffect,
    UUTransitionAnimationTypeSuckEffect
}UUTransitionAnimationType;

/**动画方向*/
typedef enum
{
    UUTransitionAnimationTowardFromLeft,
    UUTransitionAnimationTowardFromRight,
    UUTransitionAnimationTowardFromTop,
    UUTransitionAnimationTowardFromBottom
}UUTransitionAnimationToward;

@interface UIView (UUTransitionAnimation)

- (void)setTransitionAnimationType:(UUTransitionAnimationType)transtionAnimationType toward:(UUTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration;

@end
