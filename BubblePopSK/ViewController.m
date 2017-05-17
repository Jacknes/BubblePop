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
@synthesize numberOfBubbles, timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    numberOfBubbles = @"0";
    timer = @"0";
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"settingsSegue"])
    {
        //SettingsViewController *destination = segue.destinationViewController;
//        destination.numberOfBubblesInt = self.numberOfBubbles;
//        destination.timerInt = self.timer;
    }
    
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
