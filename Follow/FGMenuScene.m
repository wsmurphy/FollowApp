//
//  FGMenuScene.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 7/27/14.
//
//

#import "FGMenuScene.h"
#import "FGLevel2Scene.h"
#import "ColorConstants.h"

@implementation FGMenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = kColorStandardBackground;
        
        SKSpriteNode *headerView = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.976f green:0.145f blue:0.243f alpha:1.0f] size:CGSizeMake(self.frame.size.width, 44)];
        headerView.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 22);
        [self addChild:headerView];
        
        SKSpriteNode *menuIcon = [SKSpriteNode spriteNodeWithImageNamed:@"MenuIcon"];
        menuIcon.position = CGPointMake(self.frame.size.width - 20, self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 22);
        menuIcon.name = @"MenuIcon";
        [self addChild:menuIcon];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    SKNode *touchedNode = [self nodeAtPoint:[touch locationInNode:self]];
    NSLog(@"Node name: %@", touchedNode.name);
    
    if([touchedNode.name isEqualToString:@"MenuIcon"]) {
        [self dismissMenu];
    }
}

-(void)dismissMenu {
    FGLevel2Scene *level2 = [[FGLevel2Scene alloc] initWithSize:self.size];
    [level2 restoreSavedPlayArray:self.savedPlayArray];
    SKTransition *slideIn = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5];
    [self.view presentScene:level2 transition:slideIn];
}
@end
