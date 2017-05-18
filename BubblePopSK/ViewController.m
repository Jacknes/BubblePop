//
//  ViewController.m
//  BubblePop
//
//  Created by Jack Pascoe on 27/4/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize numberOfBubbles, timer, playerTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"settingsSegue"])
    {
        SettingsViewController *destination = segue.destinationViewController;
        destination.numberOfBubblesInt = self.numberOfBubbles;
        destination.timerInt = self.timer;
        
        
    } else if ([segue.identifier isEqualToString:@"GameSegue"]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *playerName = playerTextField.text;
        if ([playerName  isEqual: @""]) {
            playerName = @"Unnamed Player";
        }
        [defaults setObject:playerName forKey:@"PlayerName"];
        
        NSString *gameTimer = [NSString stringWithFormat:@"%i", self.timer];
        if ([gameTimer  isEqual: @"0"]) {
            gameTimer = @"60";
        }
        [defaults setObject:gameTimer forKey:@"GameTimer"];
        
        NSString *numberOfBubblesSave = [NSString stringWithFormat:@"%i", self.numberOfBubbles];
        if ([numberOfBubblesSave  isEqual: @"0"]) {
            numberOfBubblesSave = @"15";
        }
        [defaults setObject:numberOfBubblesSave forKey:@"NumberOfBubbles"];
        
        
        [defaults synchronize];
    }
    
}

-(void) saveName
{
    
}



-(void) viewDidAppear:(BOOL)animated
{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:numberOfBubbles
//                          message:nil
//                          delegate:self
//                          cancelButtonTitle:@"Cancel"
//                          otherButtonTitles:@"OK", nil];
//    [alert show];
}

@end
