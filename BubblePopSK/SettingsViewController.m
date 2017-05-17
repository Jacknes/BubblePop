//
//  SettingsViewController.m
//  BubblePop
//
//  Created by Jack Pascoe on 28/4/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize gameTimeSlider, gameTimeLabel, bubblesLabel, bubblesSlider, numberOfBubblesInt, timerInt;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseLabelsAndSliders:numberOfBubblesInt and:timerInt];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [self initialiseLabelsAndSliders:numberOfBubblesInt and:timerInt];
}

-(void) initialiseLabelsAndSliders: (int) numOfBubbles and: (int) timerValue;
{
    if (numOfBubbles!= 0)
    {
        bubblesSlider.value = numOfBubbles;
    }
    
    if (timerValue != 0)
    {
        gameTimeSlider.value = timerValue;
    }
    
    [self timerSliderStateChange:nil];
    [self bubbleSliderStateChange:nil];
}

- (IBAction)timerSliderStateChange:(id)sender
{
    int timerValue = gameTimeSlider.value;
    NSString *strFromInt = [NSString stringWithFormat:@"%d",timerValue];
    timerInt = timerValue;
    gameTimeLabel.text = strFromInt;
}
- (IBAction)bubbleSliderStateChange:(id)sender
{
    int bubbleValue = bubblesSlider.value;
    NSString *strFromInt = [NSString stringWithFormat:@"%d",bubbleValue];
    numberOfBubblesInt = bubbleValue;
    bubblesLabel.text = strFromInt;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)saveButtonPressed:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    ViewController *destination = segue.destinationViewController;
//    destination.numberOfBubbles = self.numberOfBubblesInt;
    //destination.timer
//    destination.timer = self.timer;
    //[NSString stringWithFormat:@"%f",self.gameTimeSlider.value];
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
