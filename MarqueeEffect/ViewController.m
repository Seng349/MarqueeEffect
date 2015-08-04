//
//  ViewController.m
//  MarqueeEffect
//
//  Created by ZhengWenQiang on 8/3/15.
//  Copyright © 2015 seng. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeLayer.h"

@interface ViewController ()
{
    MarqueeLayer* mMarquee;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [ UIColor darkGrayColor ];
    
    mMarquee = [ [ MarqueeLayer alloc ] init ];
    [ mMarquee OnStartAnimation ];
    [ self.view.layer addSublayer: mMarquee ];
}

- (void)viewWillLayoutSubviews
{
    mMarquee.frame = CGRectMake(50, 50, 100, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
