//
//  GameScene.h
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface GameScene : SKScene
@property (nonatomic, strong) SKLabelNode *counterLabel;
@property (nonatomic, strong) SKLabelNode *timerLabel;
@property (nonatomic, strong) SKLabelNode *countdownLabel;
@property (nonatomic, strong) SKLabelNode *highscore;
@property (nonatomic, strong) SKLabelNode *combo;
@property (nonatomic) int score;
@property (nonatomic) int time;
@property (nonatomic) int initialTime;
@property (nonatomic) int maxBubbles;
@property (nonatomic) int comboCounter;
@property (nonatomic) NSMutableArray *tappedBubbles;
@property (nonatomic) NSMutableArray *bubbles;
@property GameViewController *vc;
-(void) initialiseParentView: (GameViewController*) parentViewController;

@end

