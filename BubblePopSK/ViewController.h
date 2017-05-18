//
//  ViewController.h
//  BubblePop
//
//  Created by Jack Pascoe on 27/4/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic) int timer;
@property(nonatomic) int numberOfBubbles;
@property (weak, nonatomic) IBOutlet UITextField *playerTextField;

@end

