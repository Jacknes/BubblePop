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

@implementation GameViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        GameScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [scene initialiseParentView:self];
        // Present the scene.
        //skView.scene.delegate = self;
        [skView presentScene:scene];
        
        if (skView.scene == nil)
        {
            NSLog(@"Success!");
            [self dismissView];
        }
    }
}

-(void) dismissView
{
    //HighScoreSegue
    [self performSegueWithIdentifier:@"HighScoreSegue" sender:nil];
    //[self dismissViewControllerAnimated:false completion:nil];
}

- (void)transitionToOtherViewController
{
    HighscoreTableViewController *controller = [HighscoreTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
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
    return YES;
}


@end
