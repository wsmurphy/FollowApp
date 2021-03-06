//
//  FGViewController.m
//  Follow
//
//  Created by Murphy, Stephen - William S on 6/13/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FGViewController.h"
#import "FGTutorialScene.h"
#import "FGLevel2Scene.h"

@implementation FGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKScene *scene;
    NSInteger tutorialCompleted = [[NSUserDefaults standardUserDefaults] integerForKey:@"tutorialCompleted"];
    if(tutorialCompleted == 0) {
        scene = [FGTutorialScene sceneWithSize:skView.bounds.size];
    } else {
        scene = [FGLevel2Scene sceneWithSize:skView.bounds.size];
    }
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
