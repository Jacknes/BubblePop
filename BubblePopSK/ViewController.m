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
    static dispatch_once_t once; //code block clears the user name if there is still one existing at launch
    dispatch_once(&once, ^ {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"PlayerName"];
        [defaults synchronize];
    });
    
    [self retrieveName]; //retrieves the stored user name
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"settingsSegue"]) //if going to settings
    {
        SettingsViewController *destination = segue.destinationViewController;
        destination.numberOfBubblesInt = self.numberOfBubbles; //pass the number of bubbles and gametime to the settings
        destination.timerInt = self.timer;
       
        
    } else if ([segue.identifier isEqualToString:@"GameSegue"]) { //if going to game
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *playerName = playerTextField.text;
        if ([playerName  isEqual: @""]) {
            playerName = @"Unnamed Player";
        }
        
        [defaults setObject:playerName forKey:@"PlayerName"]; //set the play name in user defaults
        
        NSString *gameTimer = [NSString stringWithFormat:@"%i", self.timer]; //send the gamelength
        if ([gameTimer  isEqual: @"0"]) {
            gameTimer = @"60";
        }
        
        [defaults setObject:gameTimer forKey:@"GameTimer"];
        
        NSString *numberOfBubblesSave = [NSString stringWithFormat:@"%i", self.numberOfBubbles]; //send the number of bubbles
        if ([numberOfBubblesSave  isEqual: @"0"]) {
            numberOfBubblesSave = @"15";
        }
        
        [defaults setObject:numberOfBubblesSave forKey:@"NumberOfBubbles"];
        
        [defaults synchronize]; //save the defaults
    }
     [self saveName]; //save the name
    
}

-(void) retrieveName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *playerName = [defaults stringForKey:@"PlayerName"]; //gets the user name from defaults
    
    if (![playerName  isEqual: @""]) //if there is a name
    {
        playerTextField.text = playerName; //set the name textfield to the name
    }
}

-(void) saveName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *playerName = playerTextField.text;
    [defaults setObject:playerName forKey:@"PlayerName"]; //save the player name in user defaults
    [defaults synchronize];
}

@end
