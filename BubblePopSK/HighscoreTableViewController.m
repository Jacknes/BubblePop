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
    [self sortHighScores]; //sort the highscores
}
- (IBAction)backButtonPress:(id)sender {
    [self performSegueWithIdentifier:@"MainMenuSegue" sender:nil]; //go back to the main screen
}


-(void) sortHighScores
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"]; //get the current highscore arrays
    NSArray *highscores = [defaults arrayForKey:@"HighScores"];
    
    NSMutableArray *mutableHigh = [[NSMutableArray alloc]initWithArray:highscores]; //convert them to mutable
    NSMutableArray *mutableHighNames = [[NSMutableArray alloc]initWithArray:highscoreNames];
    
    NSMutableArray *newNames = [[NSMutableArray alloc] init]; //create new arrays to store the sorted data
    NSMutableArray *newScores = [[NSMutableArray alloc] init];
    
    while([newScores count] != [highscores count]) //while not all scores sorted
    {
        int maxIndex = 0; //store the max number
        for (int i = 0; i < [mutableHigh count]; i++) //for each value
        {
            if ([[mutableHigh objectAtIndex:i]intValue] > [[mutableHigh objectAtIndex:maxIndex]intValue]) //if the value is greater than the current max
            {
                maxIndex = i; //store that value
            }
        }
        //Remove the object from the initial arrays and place in the new ordered ones
        [newNames addObject:[mutableHighNames objectAtIndex:maxIndex]];
        [mutableHighNames removeObjectAtIndex:maxIndex];
        
        [newScores addObject:[mutableHigh objectAtIndex:maxIndex]];
        [mutableHigh removeObjectAtIndex:maxIndex];
        
        maxIndex = 0; //reset max
    }
    
        //Put the new sorted array back into the user defaults
        [defaults setObject:[newNames copy] forKey:@"HighScoreNames"];
        [defaults setObject:[newScores copy] forKey:@"HighScores"];
        
        
        [defaults synchronize]; //save the new sorted arrays
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //only ever 1 section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"];
    return (int)highscoreNames.count; //number of rows is the number of highscores
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell"; //create a cell for each highscore
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];  //initialise the cell
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *highscoreNames = [defaults arrayForKey:@"HighScoreNames"]; //get the highscore arrays
    NSArray *highscores = [defaults arrayForKey:@"HighScores"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[highscoreNames objectAtIndex:indexPath.row],[highscores objectAtIndex:indexPath.row]]; //set the values of the cell based on the row number
    return cell; //return the cell
}

@end
