//
//  ViewController.h
//  SlidingMenuDemo
//
//  Created by Mai El-Awini on 2014-05-18.
//
//

#import <UIKit/UIKit.h>
#import "SlidingTabView.h"

@interface ViewController : UIViewController <SlidingTabViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *tabParent;

@property (strong, nonatomic) IBOutlet SlidingTabView *slider;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sliderConstraint;

@property (strong, nonatomic) IBOutlet UIImageView *blurView;
@end
