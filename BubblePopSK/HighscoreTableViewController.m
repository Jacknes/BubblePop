//
//  HighscoreTableViewController.m
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "HighscoreTableViewController.h"

@interface HighscoreTableViewController ()

@end

@implementation HighscoreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sortHighScores];
}
- (IBAction)backButtonPress:(id)sender {
    [self performSegueWithIdentifier:@"MainMenuSegue" sender:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
}


-(void) sortHighScores
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"];
    NSArray *highscores = [defaults arrayForKey:@"HighScores"];
    NSMutableArray *mutableHigh = [[NSMutableArray alloc]initWithArray:highscores];
    NSMutableArray *mutableHighNames = [[NSMutableArray alloc]initWithArray:highscoreNames];
    NSMutableArray *newNames = [[NSMutableArray alloc] init];
    NSMutableArray *newScores = [[NSMutableArray alloc] init];
    
    while([newScores count] != [highscores count])
    {
        int maxIndex = 0;
        for (int i = 0; i < [mutableHigh count]; i++)
        {
            if ([[mutableHigh objectAtIndex:i]intValue] > [[mutableHigh objectAtIndex:maxIndex]intValue])
            {
                maxIndex = i;
            }
        }
        //Remove the object from the initial arrays and place in the new ordered ones
        [newNames addObject:[mutableHighNames objectAtIndex:maxIndex]];
        [mutableHighNames removeObjectAtIndex:maxIndex];
        [newScores addObject:[mutableHigh objectAtIndex:maxIndex]];
        [mutableHigh removeObjectAtIndex:maxIndex];
        maxIndex = 0;
        
        //Put the new sorted array back into the user defaults
        [defaults setObject:[newNames copy] forKey:@"HighScoreNames"];
        [defaults setObject:[newScores copy] forKey:@"HighScores"];
        
        
        [defaults synchronize];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"];
    return (int)highscoreNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"];
    NSArray *highscores = [defaults arrayForKey:@"HighScores"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[highscoreNames objectAtIndex:indexPath.row],[highscores objectAtIndex:indexPath.row]];
    NSLog(@"Cell generated");
    return cell;
}



@end
