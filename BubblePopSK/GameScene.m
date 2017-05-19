//
//  GameScene.m
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"

@implementation GameScene {
}

@synthesize counterLabel, timerLabel, countdownLabel, highscore, score, time, maxBubbles, tappedBubbles, bubbles, initialTime, vc, comboCounter;



-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) //initialise the scene with a set size.
    {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; //set the background colour to white
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //retrieve the user defaults
        
        maxBubbles = [[defaults stringForKey:@"NumberOfBubbles"]intValue]; //get the max number of bubbles
        time = [[defaults stringForKey:@"GameTimer"]intValue]; //get the time of the game
        initialTime = time; //store the initial game length

        [self showCountdown]; //initiate the countdown sequence
 
    }
    return self;
}


-(void) initialiseParentView: (GameViewController*) parentViewController
{
    vc = parentViewController; //initialises the parent view controller to allow for seguing later.
}

-(void) initialiseGame
{
    bubbles = [[NSMutableArray alloc] init];
    tappedBubbles = [[NSMutableArray alloc] init];
    [self drawLabels]; //draw the on screen labels
    
    comboCounter = 0; //initialise the combo counter
    [self addBubbles:maxBubbles]; //add the required number of bubbles
    [self initialiseTimer]; //start the timer
}

-(void) initialiseTimer
{
    
    SKAction *updateLabel = [SKAction runBlock:^{ //This block update the timer and displays it
        timerLabel.text = [NSString stringWithFormat:@"Time Left: %lu", (unsigned long)time];
        if (time != initialTime){
            [self updateBubbles];
        }
        NSLog(@"Number of bubbles: %lu", (unsigned long)bubbles.count);
        time--;
        
    }];
    
    SKAction *wait = [SKAction waitForDuration:1.0]; //this block simply waits for one second
    
    SKAction *updateLabelAndWait = [SKAction sequence:@[updateLabel, wait]];
    [timerLabel runAction:[SKAction repeatAction:updateLabelAndWait count:time] completion:^{ //this block runs them for the set game time.
        //timerLabel.text = @"GAME OVER!";
        [self gameOver]; //One completed, gameOver is ran
    }];
}

-(void) drawLabels
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //defaults is loaded to get the highest score
    
    self.counterLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"]; //score label defined and drew to screen
    self.counterLabel.name = @"ScoreLabel";
    self.counterLabel.text = @"Score: 0";
    self.counterLabel.fontSize = 20;
    self.counterLabel.fontColor = [SKColor blackColor];
    self.counterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.counterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.counterLabel.position = CGPointMake(self.frame.size.width - 50, self.frame.size.height-20);
    self.counterLabel.zPosition = 900;
    [self addChild: self.counterLabel];
    
    self.highscore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"]; //highscore label defined and drew to screen
    self.highscore.name = @"HighScoreLabel";
    NSArray *highscores = [defaults arrayForKey:@"HighScores"];
    if (highscores.count > 0){
        highscore.text = [NSString stringWithFormat:@"High Score: %@",[highscores objectAtIndex:0]];
    } else {
        self.highscore.text = @"High Score: 0";
    }
    self.highscore.fontSize = 20;
    self.highscore.fontColor = [SKColor blackColor];
    self.highscore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.highscore.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.highscore.position = CGPointMake(self.frame.size.width - 80, self.frame.size.height - 50);
    self.highscore.zPosition = 900;
    [self addChild: self.highscore];
    
    self.combo = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"]; //combo label defined and drawn to screen
    self.combo.name = @"ComboLabel";
    self.combo.text = @"Combo: 0";
    self.combo.fontSize = 20;
    self.combo.fontColor = [SKColor blackColor];
    self.combo.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.combo.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.combo.position = CGPointMake(self.frame.origin.x + 48, self.frame.size.height - 48);
    self.combo.zPosition = 900;
    [self addChild: self.combo];
    
    self.timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"]; //timer label drawn to screen
    self.timerLabel.name = @"TimerLabel";
    self.timerLabel.text = @"60";
    self.timerLabel.fontSize = 20;
    self.timerLabel.fontColor = [SKColor blackColor];
    self.timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.timerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.timerLabel.position = CGPointMake(self.frame.origin.x + 60, self.frame.size.height-20);
    self.timerLabel.zPosition = 900;
    [self addChild: self.timerLabel];
    
    
    
}


-(void) showCountdown
{
    self.countdownLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"]; //a countdown label is displayed
    self.countdownLabel.name = @"ScoreLabel";
    self.countdownLabel.text = @"4";
    self.countdownLabel.fontSize = 50;
    self.countdownLabel.fontColor = [SKColor blackColor];
    self.countdownLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.countdownLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.countdownLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height /2); // change x,y to location you want
    self.countdownLabel.zPosition = 900;
    [self addChild: self.countdownLabel];
    SKAction *updateLabel = [SKAction runBlock:^{ //counts down for 3 seconds, updating the countdown
        int count = [self.countdownLabel.text intValue];
        count--;
        self.countdownLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)count];
        
    }];
    
    SKAction *wait = [SKAction waitForDuration:1.0]; //simply waits

    SKAction *updateLabelAndWait = [SKAction sequence:@[updateLabel, wait]]; //combines the above actions to run the countdown
    [countdownLabel runAction:[SKAction repeatAction:updateLabelAndWait count:3] completion:^{
        [self.countdownLabel runAction:[SKAction fadeOutWithDuration:0]]; //on completion hide the label
        [self initialiseGame]; //and start the game
    }];
}



-(void) addBubbles: (int) numberOfBubblesToAdd
{
    for (int i = 0; i < numberOfBubblesToAdd; i++) //for each bubble to add
    {
        if (bubbles.count < maxBubbles){ //ensure you can legally add the bubble
            [self addBubble]; //add the bubble
        }
    }
}

-(void) removeBubbles: (int) numberToRemove
{
    if (numberToRemove <= bubbles.count) //ensures the bubble can still be removed
    {
        for (int i = 0; i < numberToRemove; i++) //for each bubble to remove
        {
            int randomNumber = arc4random_uniform((int)bubbles.count); //randomise which bubble to remove
            SKSpriteNode * bubble =  [bubbles objectAtIndex:randomNumber]; //get the bubble
            [bubble runAction:[SKAction fadeOutWithDuration:0]]; //remove it off screen
            [bubbles removeObjectAtIndex:randomNumber]; //remove it from the bubble list
        }
    }
}


- (void)addBubble {
    
    //Generate random number to determine the colour
    int randomColour = arc4random_uniform(100);
    NSString *colour = [self randomColour:randomColour];
    
    
    // Create sprite with the random colour
    SKSpriteNode * bubble = [SKSpriteNode spriteNodeWithImageNamed:colour];
    

    // Determine where to spawn the bubble along the X and Y axis
    bubble = [self generateBubbleLocation:bubble];
    bubble.userInteractionEnabled = NO;
    bubble.name = colour;
    [self.bubbles addObject:bubble]; //add bubble to list of bubbles
    [self addChild:bubble]; //draw the bubble on screen
  
}

-(NSString*) randomColour: (int) randomNumber //function that returns random colour based on the data set. 0 - 99
{
    if (randomNumber < 39)
    {
        return @"RedBubble";
    } else if (randomNumber <69)
    {
        return @"PinkBubble";
    } else if (randomNumber < 84)
    {
        return @"GreenBubble";
    } else if (randomNumber < 94)
    {
        return @"BlueBubble";
    } else if (randomNumber < 99)
    {
        return @"BlackBubble";
    } else
    {
        return nil;
    }
}

-(SKSpriteNode*) generateBubbleLocation: (SKSpriteNode*) bubble
{
    int x = [self generateX: bubble]; //generates a random point on the x axis
    int y = [self generateY: bubble]; //generates a random point on the y axis
    bubble.position = CGPointMake(x, y); //sets the bubble at the location
    bubble.xScale = 0.75; //scales the bubble down
    bubble.yScale = 0.75;
    while([self doesIntersectWithOther:bubble]) //checks that it doesn't collide with an existing bubble, keeps generating new locations until it doesn't
    {
        int x = [self generateX: bubble];
        int y = [self generateY: bubble];
        bubble.position = CGPointMake(x, y);
        bubble.xScale = 0.75;
        bubble.yScale = 0.75;
    }
    
    return bubble; //returns the located bubble.
}

-(int) generateX:(SKSpriteNode*) bubble
{
    int minX = bubble.size.width / 2; //minimum x value to fit on screen
    int maxX = self.frame.size.width - bubble.size.width / 2; //max v value to fit on screen
    int rangeX = maxX - minX; //the range
    int actualX = (arc4random() % rangeX) + minX; //randomises the location
    return actualX; //returns it
}

-(int) generateY: (SKSpriteNode*) bubble //same as generateX
{
    int minY = bubble.size.height / 2;
    int maxY = self.frame.size.height - bubble.size.height / 2 - 50;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    return actualY;
}


-(BOOL) doesIntersectWithOther: (SKSpriteNode*) bubble
{
    for (int i = 0; i < self.bubbles.count; i++) //for each existing bubble
    {
        SKSpriteNode *tempBubble = [self.bubbles objectAtIndex:i]; //get the current bubble
 
        if (CGRectIntersectsRect(bubble.frame, tempBubble.frame)) //if the bubble you're trying to add collides with the existing bubble
        {
            return true;
        }
    }
    return false; //no collision
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject]; //Gets the user touch
    CGPoint location = [touch locationInNode:self]; //gets the location
    SKNode *node = [self nodeAtPoint:location]; //gets the node at location (bubble)
    
    if ([node.name containsString:@"Bubble"]) //checks that it is a bubble
    {
        [self runAction:[SKAction playSoundFileNamed:@"Pop.wav" waitForCompletion:NO]]; //plays pop sound
        NSLog(@"Bubble was touched!");
        [self.tappedBubbles addObject:node]; //adds the bubble to a list of popped bubbles
        [self.bubbles removeObject:node]; //removes the bubble from the list
        [self addScore:node.name]; //adds the score to the users score
        [self updateScore]; //updates the score label
        [node runAction:[SKAction fadeOutWithDuration:0.3]]; //removes the bubble from the screen
    }
}


-(void) addScore: (NSString*) bubbleType
{
    NSDictionary *bubbleValues = [self createBubbleValueDictionary]; //gets the bubble value dictionary
    NSString* value = [bubbleValues valueForKey:bubbleType]; //gets the value of the bubble
    
    if (tappedBubbles.count > 1) { //if there is a bubble history
        SKNode *node = [self.tappedBubbles objectAtIndex:tappedBubbles.count-2]; //gets the last popped bubble
        if (node != nil) //if the bubble exists
        {
            if (bubbleType == node.name) //if the last bubble is the same colour
            {
                comboCounter = comboCounter + 1; //add one to combo
                [self iterateCombo:comboCounter]; //add the combo to the combo label
                float scoreToAdd = [value intValue] * 1.5; //add the combo score
                self.score = self.score + (int)lroundf(scoreToAdd); //update score
            } else
            {
                comboCounter = 1; //reset combo counter
                [self iterateCombo:comboCounter]; //update the combo label
                self.score = self.score + [value intValue]; //update score
            }
        }
    } else
    {
        self.score = self.score + [value intValue]; //no bubble history, just add score
    }
   

}

-(void) updateBubbles
{
    //Generate a random number of the current bubbles to remove.
    int randomNumber = arc4random_uniform((int)bubbles.count);
    
    //remove that number randomly.
    [self removeBubbles:randomNumber];
    
    //Determine how many bubbles are missing from max and generate a random number less than that.
    int numberToAddFromTaps = arc4random_uniform(maxBubbles - (int)bubbles.count);
    
    //Add these bubbles back onto the screen
    [self addBubbles:randomNumber + numberToAddFromTaps];
    
}

-(void) iterateCombo: (int) iterator
{
    if (iterator == 0) //if the combo needs to reset
    {
        self.combo.text = @"Combo: 1"; //reset combo label
    } else
    {
        self.combo.text = [NSString stringWithFormat:@"Combo: %i",iterator]; //add one to combo label
    }
}

-(void) updateScore
{
    self.counterLabel.text = [NSString stringWithFormat:@"Score: %d", self.score]; //updates the score label
}

-(void) gameOver
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults stringForKey:@"PlayerName"]; //retrieves the player name
    [self addNewScore:name andScore:score]; //adds the new score to the user defaults
    [vc dismissView]; //displays the highscore table
}

-(void) addNewScore:(NSString *) name andScore: (int) playerScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //retrieves user defaults
    NSArray *highScoreNames = [defaults arrayForKey:@"HighScoreNames"]; //gets the current names and scores
    NSArray *highScores = [defaults arrayForKey:@"HighScores"];
    if (highScoreNames != nil) //if there aren't any names yet
    {
        NSArray *newHighScoreNames = [highScoreNames arrayByAddingObject:name]; //create the arrays and add them
        NSArray *newHighScores = [highScores arrayByAddingObject:[NSString stringWithFormat:@"%d", playerScore]];
        [defaults setObject:newHighScoreNames forKey:@"HighScoreNames"];
        [defaults setObject:newHighScores forKey:@"HighScores"];
    } else {
        NSMutableArray *highScoreNames = [[NSMutableArray alloc]init]; //otherwise get the current arrays
        NSMutableArray *highScores = [[NSMutableArray alloc]init];
        [highScoreNames addObject:name];
        [highScores addObject:[NSString stringWithFormat:@"%d", playerScore]];
        [defaults setObject:[highScoreNames copy] forKey:@"HighScoreNames"]; //add the new score onto the end
        [defaults setObject:[highScores copy] forKey:@"HighScores"];
        
    }
    [defaults synchronize]; //send the defaults back
}


-(NSDictionary*) createBubbleValueDictionary
{
        return [NSDictionary dictionaryWithObjectsAndKeys: //create the colour value dictionary
                @"1", @"RedBubble",
                @"2", @"PinkBubble",
                @"5", @"GreenBubble",
                @"8", @"BlueBubble",
                @"10", @"BlackBubble",
                nil];
    
}


@end

