//
//  CountDownViewController.m
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "CountDownViewController.h"
#import "GameViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController
@synthesize countdownLabel;
int remainingCounts = 3;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSTimer *timer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown:)
                                           userInfo:nil
                                            repeats:YES];

}

-(void) countDown: (NSTimer *) timer
{
    remainingCounts--;
    if (remainingCounts == 0)
    {
        [timer invalidate];
        //startgame
        GameViewController *gameViewController = [[GameViewController alloc]init];
        [self presentViewController: gameViewController animated:NO completion:nil];
    } else {
        countdownLabel.text = [NSString stringWithFormat:@"%d",remainingCounts];
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
