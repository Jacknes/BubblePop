//
//  SettingsViewController.h
//  BubblePop
//
//  Created by Jack Pascoe on 28/4/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *bubblesSlider;
@property (weak, nonatomic) IBOutlet UISlider *gameTimeSlider;
@property (weak, nonatomic) IBOutlet UILabel *bubblesLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic) int timerInt;
@property(nonatomic) int numberOfBubblesInt;

@end
