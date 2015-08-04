//
//  MarqueeLayer.m
//  MarqueeEffect
//
//  Created by ZhengWenQiang on 8/3/15.
//  Copyright © 2015 seng. All rights reserved.
//

#import "MarqueeLayer.h"

@implementation MarqueeLayer

#pragma mark -
#pragma mark Initalizer 
/**
 *  
 *
 */
- (nonnull instancetype)init
{
    self = [ super init ];
    
    if ( self )
    {
        [ self SS_init ];
    }
    
    return self;
}

/**
 *
 *
 */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [ super init ];
    
    if ( self )
    {
        [ self SS_init ];
    }
    
    return self;
}

/**
 *
 *
 */
- (nonnull instancetype)initWithLayer:(nonnull id)layer
{
    self = [ super initWithLayer: layer ];
    
    if ( self )
    {
        [ self SS_init ];
    }
    
    return self;
}

/**
 *  
 *
 */
- ( void ) SS_init
{
    [ self setFillColor: [ UIColor clearColor ].CGColor ];
    [ self setStrokeColor: [ UIColor whiteColor ].CGColor ];
    [ self setLineWidth: 2.F ];
    [ self setLineJoin: kCALineJoinRound ];
    [ self setLineDashPattern: @[@(10), @(5)] ];
    
    [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                selector: @selector(OnStartAnimation)
                                                    name: UIApplicationDidBecomeActiveNotification
                                                  object: nil ];
}


#pragma mark -
#pragma mark Animation
/**
 *
 *
 */
- ( void ) OnStartAnimation
{
    if ( [ self animationForKey: @"linePhase" ] )
    {
        [ self removeAnimationForKey: @"linePhase" ];
    }
    
    @autoreleasepool
    {
        self.hidden = NO;
        
        CABasicAnimation* const aDashAnimation = [ CABasicAnimation animationWithKeyPath: @"lineDashPhase" ];
        [ aDashAnimation setFromValue: @( 0.0F ) ];
        [ aDashAnimation setToValue: @( 15 ) ];
        [ aDashAnimation setDuration: 0.75F ];
        [ aDashAnimation setRepeatCount: 100000 ];
        
        [ self addAnimation: aDashAnimation
                     forKey: @"linePhase" ];
    }
}

/**
 *
 *
 */
- ( void ) OnExitAnimation
{
    if ( [ self animationForKey: @"linePhase" ] )
    {
        [ self removeAnimationForKey: @"linePhase" ];
    }
}

#pragma mark -
#pragma mark Base Method Rewrite
/**
 *  
 *
 */
- (void)setFrame:(CGRect)frame
{
    [ super setFrame: frame ];
    
    [ self SetAnimationPath ];
}

#pragma mark -
#pragma mark Set Path
/**
 *  
 *
 */
- ( void ) SetAnimationPath
{
    if ( self.superlayer == nil )
    {
        return;
    }
    
    UIWindow* aTopWindow = [[ UIApplication sharedApplication ].windows lastObject];
    
    while ( aTopWindow.superview != nil )
    {
        UIView* aView = aTopWindow.superview;
        aTopWindow = (UIWindow*)aView;
    }
    
    CALayer* aTopLayer      = aTopWindow.layer;
    CGRect aTopFrame        = [ self convertRect: self.bounds toLayer: aTopLayer ];
    CGRect aTopIntersection = CGRectIntersection(aTopFrame, aTopLayer.bounds);
    CGRect aAnimationPath   = [ self convertRect: aTopIntersection fromLayer: aTopLayer ];
    
    CGMutablePathRef const aPath = CGPathCreateMutable();
    CGPathAddRect(aPath, NULL, aAnimationPath);
    self.path                    = aPath;
    CGPathRelease(aPath);
}

@end
