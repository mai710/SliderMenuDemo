//
//  SlidingTabViewController.h
//  Intrepid Museum
//
//  Created by Mai El-Awini on 2014-04-24.
//  Copyright (c) 2014 Ad-Dispatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidingTabViewDelegate<NSObject>

-(void)sliderDidMoveToPosition:(CGFloat)yDelta;
-(void)sliderDidAnimateToLock:(CGFloat)yPos;

@end


@interface SlidingTabView : UIView

@property (nonatomic, assign) id <SlidingTabViewDelegate> delegate;

@property (nonatomic) int topLock;
@property (nonatomic) int bottomLock;
@property (nonatomic) NSLayoutConstraint *moveConstraint;
@property (nonatomic) CGFloat pullThreshold; //a percetange of the full sliding distance that user must drag before pull is confirmed

-(UIImage *)applyBlurToImage:(UIImage*)img;
- (id)initWithFrame:(CGRect)frame andTopLock:(int)topLock andBottomLock:(int)bottomLock andMoveConstraint:(NSLayoutConstraint*)constraint;

@end
