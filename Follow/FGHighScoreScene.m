//
//  FGHighScoreScene.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 7/31/14.
//
//

#import "FGHighScoreScene.h"
#import "FGLevel2Scene.h"
#import "ColorConstants.h"

@implementation FGHighScoreScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = kColorStandardBackground;
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:kRegularFont];
        label.text = @"New High Score!!";
        label.fontSize = 30;
        label.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 120);
        [self addChild:label];
        
        SKLabelNode *highScore = [SKLabelNode labelNodeWithFontNamed:kRegularFont];
        highScore.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]];
        highScore.fontSize = 44;
        highScore.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 60);
        [self addChild:highScore];
        
        
        CGRect box = CGRectMake(self.frame.size.width / 2 - 75, self.frame.size.height / 2 - 12, 150, 44);
        SKShapeNode *boxNode = [[SKShapeNode alloc] init];
        boxNode.path = [UIBezierPath bezierPathWithRect:box].CGPath;
        boxNode.fillColor = kColorStandardNodeFour;
        boxNode.strokeColor = kColorStandardNodeFour;
        boxNode.hidden = YES;
        boxNode.name = @"TryAgainBox";
        [self addChild:boxNode];
        
        SKLabelNode *tryAgainLabel = [SKLabelNode labelNodeWithFontNamed:kBoldFont];
        tryAgainLabel.text = @"Play Again";
        tryAgainLabel.fontSize = 30;
        tryAgainLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
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
        
        
    }
    return self;
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
