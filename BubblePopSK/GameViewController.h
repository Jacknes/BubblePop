//
//  GameViewController.h
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@protocol TransitionDelegate <NSObject>

- (void)transitionToOtherViewController;

@end

@interface GameViewController : UIViewController <TransitionDelegate>

@end
