//
//  SlidingTabViewController.m
//  Intrepid Museum
//
//  Created by Mai El-Awini on 2014-04-24.
//  Copyright (c) 2014 Ad-Dispatch. All rights reserved.
//

#import "SlidingTabView.h"
#import "UIImage+ImageEffects.h"


@interface SlidingTabView (){
    CGFloat constraintOrigin;
    CGFloat lastPoint;
    CGFloat startYPos;
    int fullSlidingDistance;
    BOOL isTabDown;
}



@end

@implementation SlidingTabView


- (id)initWithFrame:(CGRect)frame andTopLock:(int)topLock andBottomLock:(int)bottomLock andMoveConstraint:(NSLayoutConstraint*)constraint
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.topLock = topLock;
        self.bottomLock = bottomLock;
        self.moveConstraint = constraint;
        self.pullThreshold = 0.10;
        
        fullSlidingDistance = self.bottomLock - self.topLock;
        self.moveConstraint.constant = self.topLock;
        constraintOrigin = self.moveConstraint.constant;
        isTabDown = NO;
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = YES;

        self.pullThreshold = 0.10;
        fullSlidingDistance = self.bottomLock - self.topLock;
        self.moveConstraint.constant = self.topLock;
        constraintOrigin = self.moveConstraint.constant;
        isTabDown = NO;
    }
    
    return self;
}

-(UIImage *)applyBlurToImage:(UIImage*)img
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    return [img applyBlurWithRadius:5 tintColor:tintColor saturationDeltaFactor:1 maskImage:nil];
}

-(void)setTopLock:(int)topLock
{
    _topLock = topLock;
    
    //recalculate fullSlidingDistance
    fullSlidingDistance = _bottomLock - _topLock;
}

-(void)setBottomLock:(int)bottomLock
{
    _bottomLock = bottomLock;
    
    //recalculate fullSlidingDistance
    fullSlidingDistance = _bottomLock - _topLock;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    CGPoint pt = [[touches  anyObject] locationInView:self.superview];
    
    if (pt.y > self.topLock && pt.y < (self.bottomLock + self.frame.size.height))
    {
        CGFloat delta = pt.y - lastPoint;
        self.moveConstraint.constant += delta;
        
        //pass the change to the delegate
        [self.delegate sliderDidMoveToPosition:delta];
    }
    
    lastPoint = pt.y;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    lastPoint = [[touches anyObject] locationInView:self.superview].y;
    
}


-(BOOL)willSnapToTopLock
{
    CGFloat distTop = self.frame.origin.y - self.topLock;
    CGFloat distBottom = self.bottomLock - self.frame.origin.y;
    
    if (isTabDown) {
        if(distBottom >= fullSlidingDistance * self.pullThreshold)
            return YES;
        else
            return NO;
    }
    else{
        if(distTop >= fullSlidingDistance * self.pullThreshold)
            return NO;
        else
            return YES;
    }
}


//if the user doesn't slide it all the way to a lock,
//the slider animates the rest of the way on its own
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//    CGPoint pt = [[touches  anyObject] locationInView:self.superview];
    
    if ([self willSnapToTopLock]) {
        self.moveConstraint.constant = self.topLock;
        isTabDown = NO;
    }
    else{
        self.moveConstraint.constant = self.bottomLock;
        isTabDown = YES;
    }
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.superview layoutIfNeeded];
                     }
                     completion:nil];
}


@end
