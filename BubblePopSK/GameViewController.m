//
//  GameViewController.m
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "GameViewController.h"
#import "HighscoreTableViewController.h"
#import "GameScene.h"
@import AVFoundation;

@implementation GameViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp3"]; //initialises background music
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    // Configure the view.
    SKView * skView = (SKView *)self.view; //initialises the SKView
    if (!skView.scene) {
        
        //Lines to debug game performance
        //skView.showsFPS = YES;
        //skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        GameScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [scene initialiseParentView:self];
        
        // Present the scene.
        [skView presentScene:scene];
        
    }
}

-(void) dismissView
{
    [self performSegueWithIdentifier:@"HighScoreSegue" sender:nil]; //shows the highscore view
}

- (BOOL)shouldAutorotate
{
    return YES; 
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations //allows rotation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else
    {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden
{
    return YES; //hide status bar
}


@end
