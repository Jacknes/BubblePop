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
    [self initialiseLabelsAndSliders:numberOfBubblesInt and:timerInt]; //initialise the sliders values from the data sent from main screen
    
}

-(void) initialiseLabelsAndSliders: (int) numOfBubbles and: (int) timerValue;
{
    if (numOfBubbles!= 0) //if there is data sent
    {
        bubblesSlider.value = numOfBubbles; //sent the slider to the right value
    }
    
    if (timerValue != 0)
    {
        gameTimeSlider.value = timerValue;
    }
    
    [self timerSliderStateChange:nil]; //update the labels
    [self bubbleSliderStateChange:nil];
}

- (IBAction)timerSliderStateChange:(id)sender
{
    int timerValue = gameTimeSlider.value; //get slider value
    NSString *strFromInt = [NSString stringWithFormat:@"%d",timerValue];
    timerInt = timerValue;
    gameTimeLabel.text = strFromInt; //set the value of the labels
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *destination = segue.destinationViewController; //send the settings data back
    destination.numberOfBubbles = self.numberOfBubblesInt;
    destination.timer = self.timerInt;
}




@end
