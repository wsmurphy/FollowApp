//
//  FGFailedScene.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 7/29/14.
//
//

#import "FGFailedScene.h"
#import "FGLevel2Scene.h"
#import "ColorConstants.h"

@implementation FGFailedScene {
    SKLabelNode *score;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = kColorStandardBackground;
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        label.text = @"Oops!";
        label.fontSize = 30;
        label.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 120);
        [self addChild:label];
        
        CGRect box = CGRectMake(self.frame.size.width / 2 - 75, self.frame.size.height / 2 + 48, 150, 44);
        
        SKShapeNode *boxNode = [[SKShapeNode alloc] init];
        boxNode.path = [UIBezierPath bezierPathWithRect:box].CGPath;
        boxNode.fillColor = kColorStandardNodeFour;
        boxNode.strokeColor = kColorStandardNodeFour;
        boxNode.hidden = YES;
        boxNode.name = @"TryAgainBox";
        [self addChild:boxNode];
        
        SKLabelNode *tryAgainLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue Bold"];
        tryAgainLabel.text = @"Try Again";
        tryAgainLabel.fontSize = 30;
        tryAgainLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 60);
        tryAgainLabel.hidden = YES;
        tryAgainLabel.name = @"TryAgain";
        [self addChild:tryAgainLabel];

        [tryAgainLabel runAction:[SKAction scaleTo:0.1 duration:0.1] completion:^{
            tryAgainLabel.hidden = NO;
            [tryAgainLabel runAction:[SKAction sequence:@[[SKAction scaleTo:1.5 duration:0.2], [SKAction waitForDuration:0.2],[SKAction scaleTo:1.0 duration:0.2], [SKAction waitForDuration:0.2]]]];
        }];
        
        [boxNode runAction:[SKAction scaleTo:0.1 duration:0.1] completion:^{
            boxNode.hidden = NO;
            [boxNode runAction:[SKAction sequence:@[[SKAction scaleTo:1.5 duration:0.2], [SKAction waitForDuration:0.2],[SKAction scaleTo:1.0 duration:0.2], [SKAction waitForDuration:0.2]]]];
        }];
        
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        scoreLabel.text = @"Score";
        scoreLabel.fontSize = 24;
        scoreLabel.position = CGPointMake(self.frame.size.width / 4, self.frame.size.height / 2 - 40);
        [self addChild:scoreLabel];
        
        score = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        score.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
        score.fontSize = 24;
        score.position = CGPointMake(self.frame.size.width / 4, self.frame.size.height / 2 - 75);
        [self addChild:score];
        
        SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        highScoreLabel.text = @"High Score";
        highScoreLabel.fontSize = 24;
        highScoreLabel.position = CGPointMake(self.frame.size.width / 4 + self.frame.size.width / 2, self.frame.size.height / 2 - 40);
        [self addChild:highScoreLabel];
        
        SKLabelNode *highScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Nueue"];
        highScore.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]];
        highScore.fontSize = 24;
        highScore.position = CGPointMake(self.frame.size.width / 4 + self.frame.size.width / 2, self.frame.size.height / 2 - 75);
        [self addChild:highScore];

    }
    return self;
}

- (void)setCurrentScore:(NSInteger)currentScore {
    _currentScore = currentScore;
    
    score.text = [NSString stringWithFormat:@"%ld", (long)currentScore];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    SKNode *touchedNode = [self nodeAtPoint:[touch locationInNode:self]];
    NSLog(@"Node name: %@", touchedNode.name);
    
    //TODO: Fix tapped region
    if([touchedNode.name isEqualToString:@"TryAgain"] || [touchedNode.name isEqualToString:@"TryAgainBox"]) {
        FGLevel2Scene *levelScene = [[FGLevel2Scene alloc] initWithSize:self.size];
        [self.view presentScene:levelScene];
    }
}


@end
