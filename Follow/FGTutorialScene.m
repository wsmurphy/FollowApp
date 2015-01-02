//
//  FGMyScene.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 6/13/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FGTutorialScene.h"
#import "FGLevel2Scene.h"
#import "ColorConstants.h"
#import "SpriteContstants.h"

@implementation FGTutorialScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = kColorStandardBackground;
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:kRegularFont];
        
        myLabel.text = @"Tap the box!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame) - 60.0f);
        
        [self addChild:myLabel];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:kColorStandardNodeOne size:CGSizeMake(88.0f, 88.0f)];
        sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        sprite.name = @"0";
        [self addChild:sprite];
        
        [sprite runAction:[SKAction sequence:@[[SKAction waitForDuration:0.4], kTouchSeq]]];
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:[touch locationInNode:self]];
    NSLog(@"Node name: %@", touchedNode.name);
    
    if([touchedNode isKindOfClass:[SKSpriteNode class]]) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:kRegularFont];
        
        label.text = @"Good!";
        label.fontSize = 40;
        label.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame) - 144.0f);
        
        [self addChild:label];
        
     [touchedNode runAction:[SKAction sequence:@[[SKAction scaleTo:1.5 duration:0.2], [SKAction waitForDuration:0.2],[SKAction scaleTo:1.0 duration:0.2]]]];
      [label runAction:[SKAction sequence:@[[SKAction waitForDuration:0.6], [SKAction scaleTo:4.5 duration:0.5],[SKAction fadeOutWithDuration:0.2], [SKAction removeFromParent]]]];
        
        SKAction *doneAction = [SKAction runBlock:^{
            //Set the tutorial completed flag to true.
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"tutorialCompleted"];
            
            //Present the main game screen
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            FGLevel2Scene *level2 = [[FGLevel2Scene alloc] initWithSize:self.size];
            [self.view presentScene:level2 transition: reveal];
        }];
        
        [self runAction:[SKAction sequence:@[[SKAction waitForDuration:0.6], doneAction]]];


    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
