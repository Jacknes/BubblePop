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
@import AVFoundation;

@interface GameViewController : UIViewController
-(void) dismissView;
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@end
