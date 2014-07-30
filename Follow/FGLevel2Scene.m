//
//  FGLevel2Scene.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 6/14/14.
//
//

#import "FGLevel2Scene.h"
#import "FGMenuScene.h"
#import "FGFailedScene.h"
#import "ColorConstants.h"
#import "SpriteContstants.h"

@implementation FGLevel2Scene {
    NSMutableArray *playArray;
    NSInteger touchCount;
    SKLabelNode *countLabel;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = kColorStandardBackground;
        
        SKSpriteNode *headerView = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.976f green:0.145f blue:0.243f alpha:1.0f] size:CGSizeMake(self.frame.size.width, 44)];
        headerView.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 22);
        [self addChild:headerView];
        
        SKSpriteNode *menuIcon = [SKSpriteNode spriteNodeWithImageNamed:@"MenuIcon"];
        menuIcon.position = CGPointMake(20, self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 22);
        menuIcon.name = @"MenuIcon";
        [self addChild:menuIcon];
        
        countLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        
        countLabel.text = @"0";
        countLabel.fontSize = 30;
        countLabel.position = CGPointMake(160, self.frame.size.height - 54);
        
        [self addChild:countLabel];
        
        for(NSInteger i = 0; i <= 3; i++) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(66.0f, 66.0f)];
            switch (i) {
                case 0:
                    sprite.position = CGPointMake(110, 290);
                    sprite.color = kColorStandardNodeOne;
                    break;
                case 1:
                    sprite.position = CGPointMake(210, 290);
                    sprite.color = kColorStandardNodeTwo;
                    break;
                case 2:
                    sprite.position = CGPointMake(110, 400);
                    sprite.color = kColorStandardNodeThree;
                    break;
                case 3:
                    sprite.position = CGPointMake(210, 400);
                    sprite.color = kColorStandardNodeFour;
                    break;
                default:
                    break;
            }
            
            sprite.name = [NSString stringWithFormat:@"%d", i];
            [self addChild:sprite];
        }
        
        touchCount = 0;
        [self startPlay];
  
    }
    return self;
}

-(void)startPlay {
    if(playArray == nil) {
        //Add first node
        playArray = [[NSMutableArray alloc] init];
    }
    
    NSInteger r = arc4random() % 4;
    NSNumber *rand = [NSNumber numberWithInt:r];
    
    [playArray addObject:rand];
    
    
    //Play the actions
    [self runAction:[SKAction waitForDuration:1.5] completion:^{
       [self playTouchActionForNode:playArray[0] andCount:1];
    }];
    
}

-(void)restoreSavedPlayArray:(NSArray *)savedArray {
    playArray = [NSMutableArray arrayWithArray:savedArray];
    
    //The max number of successful taps will be one fewer than the size of the playArray
    countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)playArray.count - 1];
}

-(void)playTouchActionForNode:(NSNumber *)nodeNumber andCount:(NSInteger)count {
    SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:nodeNumber.stringValue];
    [node runAction:kTouchSeq completion:^{
        if(count < playArray.count) {
            [self playTouchActionForNode:playArray[count] andCount:count + 1];
        }
    }];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    SKNode *touchedNode = [self nodeAtPoint:[touch locationInNode:self]];
    NSLog(@"Node name: %@", touchedNode.name);
    
    if([touchedNode isKindOfClass:[SKSpriteNode class]]) {
        if([touchedNode.name isEqualToString:@"0"] ||
           [touchedNode.name isEqualToString:@"1"] ||
           [touchedNode.name isEqualToString:@"2"] ||
           [touchedNode.name isEqualToString:@"3"]) {
            touchCount++;
            [touchedNode runAction:kTouchSeq];
    
            NSString *guess = touchedNode.name;
            NSNumber *guessComp = playArray[touchCount - 1];
            if(guess.intValue == guessComp.intValue) {
                NSLog(@"Match: %@ %@", guess, guessComp);
                if(touchCount == playArray.count) {
                    //Update "longest streak" counter
                    countLabel.text = [NSString stringWithFormat:@"%d", touchCount];
                    
                    touchCount = 0;
                   [self startPlay];
                }
            } else {
                NSLog(@"Fail");
                
                NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];
                if(playArray.count - 1 > highScore) {
                    //TODO:Go to high score view
                    [[NSUserDefaults standardUserDefaults] setInteger:playArray.count - 1 forKey:@"highScore"];
                }
                
                FGFailedScene *failedScene = [[FGFailedScene alloc] initWithSize:self.size];
                failedScene.currentScore = playArray.count - 1;
                [self.view presentScene:failedScene];
            }
        } else {
            if([touchedNode.name isEqualToString:@"MenuIcon"]) {
                [self displayMenu];
            }
        }
    }
}

-(void)displayMenu {
    FGMenuScene *menuScene = [[FGMenuScene alloc] initWithSize:self.size];
    menuScene.savedPlayArray = playArray;
    SKTransition *slideIn = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5];
    [self.view presentScene:menuScene transition:slideIn];
}
@end
