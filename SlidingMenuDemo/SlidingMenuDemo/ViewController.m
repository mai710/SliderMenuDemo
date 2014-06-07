//
//  ViewController.m
//  SlidingMenuDemo
//
//  Created by Mai El-Awini on 2014-05-18.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.slider setTopLock:80];
    [self.slider setBottomLock:(self.view.frame.size.height - self.slider.frame.size.height)];
    [self.slider setMoveConstraint:self.sliderConstraint];
    [self.slider setPullThreshold:0.15];
    self.blurView.image = [self.slider applyBlurToImage:self.blurView.image];
    
    self.slider.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SLIDER DELEGATE METHODS

-(void)sliderDidMoveToPosition:(CGFloat)yDelta
{
    
}

-(void)sliderDidAnimateToLock:(CGFloat)yPos
{
    
}

@end
