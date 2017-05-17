//
//  GameScene.m
//  BubblePopSK
//
//  Created by Jack Pascoe on 17/5/17.
//  Copyright © 2017 Jack Pascoe. All rights reserved.
//

#import "GameScene.h"
@interface GameScene ()
@property (nonatomic) SKSpriteNode *bubble2;
@property (nonatomic) NSMutableArray *bubbles;
@property (nonatomic) int score;
@property (nonatomic) NSMutableArray *tappedBubbles;

@end
@implementation GameScene {
}

@synthesize counterLabel;
int score;


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        
        // 2
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        
        // 3
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // 4
//        self.bubble = [SKSpriteNode spriteNodeWithImageNamed:@"BlueBubble"];
//        self.bubble.position = CGPointMake(100, 100);
//        [self addChild:self.bubble];
//        
//        self.bubble2 = [SKSpriteNode spriteNodeWithImageNamed:@"RedBubble"];
//        self.bubble2.position = CGPointMake(200, 200);
//        [self addChild:self.bubble2];
//        [self addBubble];
        [self drawLabels];

        for (int i = 0; i < 10; i++)
        {
            [self addBubble];
        }
        
        
    }
    return self;
}

//id wait = [SKAction waitForDuration:2.5];
//id run = [SKAction runBlock:^{
//    // your code here ...
//}];
//[node runAction:[SKAction sequence:@[wait, run]]];

-(void) drawLabels
{
    self.counterLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"];
    self.counterLabel.name = @"ScoreLabel";
    self.counterLabel.text = @"0";
    self.counterLabel.fontSize = 20;
    self.counterLabel.fontColor = [SKColor blackColor];
    self.counterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.counterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.counterLabel.position = CGPointMake(self.frame.size.width - 20, self.frame.size.height-20); // change x,y to location you want
    self.counterLabel.zPosition = 900;
    [self addChild: self.counterLabel];
    
    self.timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"];
    self.timerLabel.name = @"TimerLabel";
    self.timerLabel.text = @"60";
    self.timerLabel.fontSize = 20;
    self.timerLabel.fontColor = [SKColor blackColor];
    self.timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.timerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.timerLabel.position = CGPointMake(self.frame.origin.x, self.frame.size.height-20); // change x,y to location you want
    self.timerLabel.zPosition = 900;
    [self addChild: self.timerLabel];
    
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
    [self.bubbles addObject:bubble];
    [self addChild:bubble];

    // Determine speed of the monster
//    int minDuration = 2.0;
//    int maxDuration = 4.0;
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
//    SKAction * actionMove = [SKAction moveTo:CGPointMake(-bubble.size.width/2, actualY) duration:actualDuration];
//    SKAction * actionMoveDone = [SKAction removeFromParent];
//    [bubble runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

-(NSString*) randomColour: (int) randomNumber
{
    if (randomNumber < 39){
        return @"RedBubble";
    } else if (randomNumber <69) {
        return @"PinkBubble";
    } else if (randomNumber < 84) {
        return @"GreenBubble";
    } else if (randomNumber < 94) {
        return @"BlueBubble";
    } else if (randomNumber < 99) {
        return @"BlackBubble";
    } else {
        return nil;
    }
}

-(SKSpriteNode*) generateBubbleLocation: (SKSpriteNode*) bubble {
    int x = [self generateX: bubble];
    int y = [self generateY: bubble];
    bubble.position = CGPointMake(x, y);
    bubble.xScale = 0.75;
    bubble.yScale = 0.75;
    if([self doesIntersectWithOther:bubble])
    {
        int x = [self generateX: bubble];
        int y = [self generateY: bubble];
        bubble.position = CGPointMake(x, y);
        bubble.xScale = 0.75;
        bubble.yScale = 0.75;
    }
    
    return bubble;
}

-(int) generateX:(SKSpriteNode*) bubble
{
    int minX = bubble.size.width / 2;
    int maxX = self.frame.size.width - bubble.size.width / 2;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    return actualX;
}

-(int) generateY: (SKSpriteNode*) bubble
{
    int minY = bubble.size.height / 2;
    int maxY = self.frame.size.height - bubble.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    return actualY;
}


-(BOOL) doesIntersectWithOther: (SKSpriteNode*) bubble
{
    for (int i = 0; i < self.bubbles.count; i++)
    {
        SKSpriteNode *tempBubble = [self.bubbles objectAtIndex:i];
 
        if (CGRectIntersectsRect(bubble.frame, tempBubble.frame))
        {
            return true;
        }
    }
    return false;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name containsString:@"Bubble"]) {
        NSLog(@"Bubble was touched!");
        [self addScore:node.name];
        [self updateScore];
        [node runAction:[SKAction fadeOutWithDuration:0]];
    }
    
}


-(void) addScore: (NSString*) bubbleType
{
    NSDictionary *bubbleValues = [self createBubbleValueDictionary];
    NSString* value = [bubbleValues valueForKey:bubbleType];
    score = score + [value intValue];
}

-(void) updateScore
{
    self.counterLabel.text = [NSString stringWithFormat:@"%d", score];
}


-(NSDictionary*) createBubbleValueDictionary
{
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"1", @"RedBubble",
                @"2", @"PinkBubble",
                @"5", @"GreenBubble",
                @"8", @"BlueBubble",
                @"10", @"BlackBubble",
                nil];
    
}


@end

