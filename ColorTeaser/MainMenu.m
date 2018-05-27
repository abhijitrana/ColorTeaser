//
//  MainMenu.m
//  ColorTeaser
//
//  Created by ABHIJIT RANA on 08/06/15.
//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import "MainMenu.h"
#import "UIColor+Hex.h"

#import "GameScene.h"
@implementation MainMenu

-(void)didMoveToView:(SKView *)view {
   
    self.backgroundColor=[UIColor darkGrayColor];//[UIColor colorWithHexString:@"0XFF3B30"];
    
    float scaleFactor=view.frame.size.height/568;
    
    
    //add sound
    SKSpriteNode *sound=[SKSpriteNode spriteNodeWithImageNamed:@"soundOn.png"];
    sound.position=CGPointMake(view.frame.size.width*0.10, view.frame.size.height*0.95);
    sound.xScale=0.4*scaleFactor;
    sound.yScale=0.4*scaleFactor;
    sound.name=@"sound";
    [self addChild:sound];
    
    //add noAd
    SKSpriteNode *noAd=[SKSpriteNode spriteNodeWithImageNamed:@"no_ad.png"];
    noAd.position=CGPointMake(view.frame.size.width*0.90, view.frame.size.height*0.95);
    noAd.xScale=0.4*scaleFactor;
    noAd.yScale=0.4*scaleFactor;
    noAd.name=@"noAd";
    [self addChild:noAd];
    
    
    //add logo
    SKSpriteNode *logo=[SKSpriteNode spriteNodeWithImageNamed:@"logo.png"];
    logo.position=CGPointMake(view.frame.size.width/2, view.frame.size.height*0.8);
    logo.xScale=0.8*scaleFactor;
    logo.yScale=0.8*scaleFactor;
    [self addChild:logo];
    
    //add play button
    SKSpriteNode *playNow=[SKSpriteNode spriteNodeWithImageNamed:@"play_now.png"];
    playNow.position=CGPointMake(view.frame.size.width/2, view.frame.size.height*0.6);
    playNow.xScale=0.5*scaleFactor;
    playNow.yScale=0.5*scaleFactor;
    playNow.name=@"playnow";
    [self addChild:playNow];
    
    //Add store button
    SKSpriteNode *store=[SKSpriteNode spriteNodeWithImageNamed:@"store.png"];
    store.position=CGPointMake(view.frame.size.width/2, view.frame.size.height*0.5);
    store.xScale=0.5*scaleFactor;
    store.yScale=0.5*scaleFactor;
    store.name=@"store";
    [self addChild:store];
    
    
    //Add facebook
    SKSpriteNode *facebook=[SKSpriteNode spriteNodeWithImageNamed:@"fb.png"];
    facebook.position=CGPointMake(view.frame.size.width*0.25, view.frame.size.height*0.3);
    facebook.xScale=0.5*scaleFactor;
    facebook.yScale=0.5*scaleFactor;
    facebook.name=@"facebook";
    [self addChild:facebook];
    
    //Add twitter
    SKSpriteNode *twitter=[SKSpriteNode spriteNodeWithImageNamed:@"twitter.png"];
    twitter.position=CGPointMake(view.frame.size.width *0.50, view.frame.size.height*0.3);
    twitter.xScale=0.5*scaleFactor;
    twitter.yScale=0.5*scaleFactor;
    twitter.name=@"twitter";
    [self addChild:twitter];
  
    //Add game center
    SKSpriteNode *gamecenter=[SKSpriteNode spriteNodeWithImageNamed:@"gamecenter.png"];
    gamecenter.position=CGPointMake(view.frame.size.width *0.75, view.frame.size.height*0.3);
    gamecenter.xScale=0.5*scaleFactor;
    gamecenter.yScale=0.5*scaleFactor;
    gamecenter.name=@"gamecenter";
    [self addChild:gamecenter];
    
    
    //Add highScore
    SKLabelNode *highScore=[SKLabelNode labelNodeWithText:@"HIGH SCORE:0"];
    highScore.position=CGPointMake(view.frame.size.width *0.5, view.frame.size.height*0.1);
    highScore.fontName=@"Chalkduster";

    highScore.fontSize=15*scaleFactor;
    highScore.fontColor=[UIColor whiteColor];
    [self addChild:highScore];
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
 
    if ([node.name isEqualToString:@"sound"]) {
        //do whatever...
    }
    
    
    if ([node.name isEqualToString:@"noAd"]) {
        //do whatever...
    }
    
    
    if ([node.name isEqualToString:@"playnow"]) {
        //do whatever...
        GameScene *gameScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    
    if ([node.name isEqualToString:@"store"]) {
        //do whatever...
    }
    
    
    if ([node.name isEqualToString:@"facebook"]) {
        //do whatever...
    }
    
    
    if ([node.name isEqualToString:@"twitter"]) {
        //do whatever...
    }
    
    
    if ([node.name isEqualToString:@"gamecenter"]) {
        //do whatever...
    }
}
@end
