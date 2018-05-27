//
//  GameScene.m
//  ColorTeaser
//
//  Created by ABHIJIT RANA on 07/06/15.
//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import "GameScene.h"
#import "MainMenu.h"

#import "ColorDisc.h"

#define MAX_SPEED 6
#define PLAY_COST 100
@implementation GameScene

{
    SKNode *_mainLayer;
    SKNode *_headerLayer;
    
    int POINT_NORMAL;
    int POINT_BONUS;
    
    SKLabelNode *scoreLbl;
    SKLabelNode *rainbowLbl;
    
    SKSpriteNode *gameOverBox;
    
    ColorDisc *discCausedToGameOver;
}
-(void)didMoveToView:(SKView *)view {
    self.lastUpdateTimeInterval=0;

    POINT_NORMAL=1;
    POINT_BONUS=10;
    
    self.ScoreCount=0;
    self.rainbowCount=20000;
    

    self.DiscSpeed=1;
    //Setting uo header panel to show score rainbows
    
    SKSpriteNode *headerBar=[SKSpriteNode spriteNodeWithImageNamed:@"game_topbar.png"];
    headerBar.xScale=1;
    headerBar.yScale=1;
    headerBar.position=CGPointMake(view.frame.size.width*0.5, view.frame.size.height*0.95);
    [self addChild:headerBar];
    
    
    SKSpriteNode *back=[SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
    back.name=@"back";
    back.xScale=0.4;
    back.yScale=0.4;
    back.position=CGPointMake(view.frame.size.width*0.1, view.frame.size.height*0.95);
    [self addChild:back];
 
    
    SKSpriteNode *gameState=[SKSpriteNode spriteNodeWithImageNamed:@"pause.png"];
    gameState.xScale=0.4;
    gameState.yScale=0.4;
    gameState.position=CGPointMake(view.frame.size.width*0.9, view.frame.size.height*0.95);
    [self addChild:gameState];
    
 
    
    scoreLbl=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLbl.position=CGPointMake(view.frame.size.width*(1.0/3), view.frame.size.height*0.95);
    scoreLbl.fontSize=12;
    scoreLbl.zPosition=10;
    scoreLbl.text=@"SCORE:0";
    
    [self addChild:scoreLbl];
    

    rainbowLbl=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    rainbowLbl.position=CGPointMake(view.frame.size.width*(2.0/3), view.frame.size.height*0.95);
    rainbowLbl.fontSize=12;
    rainbowLbl.zPosition=10;
    rainbowLbl.text=@"RAINBOWS:0";
    [self addChild:rainbowLbl];
    
    //main layer
    _mainLayer=[SKNode node];
    _mainLayer.zPosition=-10;
    [self addChild:_mainLayer];
    
    
    
    gameOverBox=[SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
    gameOverBox.xScale=1;
    gameOverBox.yScale=1;
    gameOverBox.position=CGPointMake(view.frame.size.width*0.5, view.frame.size.height*0.5);
    gameOverBox.zPosition=100;
    gameOverBox.hidden=YES;
    [self addChild:gameOverBox];
    
    
    SKSpriteNode* continueWithRainbows=[SKSpriteNode spriteNodeWithImageNamed:@"continue"];
    continueWithRainbows.xScale=1;
    continueWithRainbows.yScale=1;
    continueWithRainbows.name=@"continueWithRainbows";
    continueWithRainbows.position=CGPointMake(0, 0);
    [gameOverBox addChild:continueWithRainbows];

    SKSpriteNode* retry=[SKSpriteNode spriteNodeWithImageNamed:@"retry.png"];
    retry.xScale=1;
    retry.yScale=1;
    retry.name=@"retry";
    retry.position=CGPointMake(0, -38*1);
    [gameOverBox addChild:retry];
    
    SKSpriteNode* quitgame=[SKSpriteNode spriteNodeWithImageNamed:@"quit.png"];
    quitgame.xScale=1;
    quitgame.yScale=1;
    quitgame.name=@"quitgame";
    quitgame.position=CGPointMake(0, -38*2);
    [gameOverBox addChild:quitgame];
    
    
    [self setScore];
    [self setRainbow];

}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    NSArray *currentDisks=[_mainLayer children];
    
    [currentDisks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ColorDisc *node=(ColorDisc *)[currentDisks objectAtIndex:idx];
        
        if(node.position.y<0)
        {

            if ([node isKindOfClass:[ColorDisc class]] && node.isWrongDisc==NO) {
                [self loadGameOver];
            }
            
            [node removeAllChildren];
            [node removeFromParent];
            
        }
    }];
    
    
    
    CFTimeInterval  timeSinceLast=currentTime-self.lastUpdateTimeInterval;
  //  NSLog(@"timeSinceLast TIME:%f",timeSinceLast);
    if (timeSinceLast>3.0*(10-self.DiscSpeed)/10) {
        self.lastUpdateTimeInterval=currentTime;
        if(self.isPaused==NO){
             [self addDisc];
        }
       
    }
    
 
}

-(void)addSppecialBonusDisc
{
    /*
     ColorDisc *disc=[ColorDisc shapeNodeWithCircleOfRadius:50];
     disc.isSpecialBonusDisc=YES;
     disc.name=@"SPECIAL_BINUS";
    [disc setUpColorDisc:[UIColor magentaColor] withText:@"RAINBOW"];
    [_mainLayer addChild:disc];
   */
    
    SKSpriteNode *disc=[SKSpriteNode spriteNodeWithImageNamed:@"rainbow_disc.png"];
     disc.position=CGPointMake(arc4random()%(int)self.view.frame.size.width,
                               self.view.frame.size.height+disc.frame.size.height/2);
    disc.name=@"SPECIAL_BONUS";
    [_mainLayer addChild:disc];
    
    
    SKAction *moveDown=[SKAction moveTo:CGPointMake(arc4random()%(int)self.view.frame.size.width,
                                                    -disc.frame.size.height/2) duration:1.5];
    SKAction *rotation=[SKAction rotateToAngle:600 duration:10];
    
    SKAction *group=[SKAction group:@[moveDown,rotation]];
    
//    SKEmitterNode *trail=[SKEmitterNode nodeWithFileNamed:@"DiskTrail"];
//    [disc addChild:trail];
    [disc runAction:group];
    
    
}
-(void)addDisc
{
    ColorDisc *disc=[ColorDisc shapeNodeWithCircleOfRadius:50];
    
    
    UIColor *discColor;
    NSString *discColorText;
    switch (arc4random()%6) {
        case 0:
            discColor=[UIColor redColor];
            discColorText=@"Red";
            break;
        case 1:
            discColor=[UIColor greenColor];
            discColorText=@"Green";
            break;
        case 2:
            discColor=[UIColor blueColor];
            discColorText=@"Blue";
            break;
        case 3:
            discColor=[UIColor yellowColor];
            discColorText=@"Yellow";
            break;
        case 4:
            discColor=[UIColor purpleColor];
            discColorText=@"Purple";
            break;
        case 5:
            discColor=[UIColor orangeColor];
            discColorText=@"Orange";
            break;
        default:
            break;
    }
    
    switch (arc4random()%3) {
        case 0:
            //wrong disc
            disc.isWrongDisc=YES;
            disc.name=@"WRONG_DISC";
            break;
        case 1:
        case 2:
            //right disc
            disc.isWrongDisc=NO;
            disc.name=@"RIGHT_DISC";
            break;
        default:
            break;
    }
    [disc setUpColorDisc:discColor withText:discColorText];
    disc.position=CGPointMake(arc4random()%(int)self.view.frame.size.width, self.view.frame.size.height+disc.frame.size.height/2);

    
    SKAction *moveDown=[SKAction moveTo:CGPointMake(arc4random()%(int)self.view.frame.size.width, -disc.frame.size.height/2) duration:10*((100-self.DiscSpeed*10+10)/100)];
    
    [disc runAction:moveDown];
    
    [_mainLayer addChild:disc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        MainMenu *mainScene = [[MainMenu alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition  flipVerticalWithDuration:0.5];
        [self.view presentScene:mainScene transition:transition];
    }
    
    if ([node.name isEqualToString:@"continueWithRainbows"]) {
        [self continueGameWithRainBow ];
    }
    if ([node.name isEqualToString:@"retry"]) {
        [self reTryGame];
    }
    if ([node.name isEqualToString:@"quitgame"]) {
        //do whatever...
    }
    
    for (UITouch *touch in touches) {
         CGPoint location = [touch locationInNode:self];
        
        NSArray *currentDisks=[_mainLayer children];
        
        [currentDisks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SKShapeNode *node=(SKShapeNode *)[currentDisks objectAtIndex:idx];
             if(CGRectContainsPoint(node.frame, location))
             {
                 //Disc Tapped
                 if ([node.name isEqualToString:@"RIGHT_DISC"]) {
                     NSLog(@"RIGHT Disc tapped");
                     self.ScoreCount+=POINT_NORMAL;
                    
                     [self setScore];
                     if(self.ScoreCount%5==0)
                     {
                         [self addSppecialBonusDisc];
                     }
                     
                     SKAction *scaleDown=[SKAction scaleTo:0 duration:0.5];
                     SKAction *remove   =[SKAction runBlock:^{
                         [node removeFromParent];
                     }];
                     
                     [node runAction:[SKAction sequence:@[scaleDown,remove]]];
                     
                 }else if ([node.name isEqualToString:@"WRONG_DISC"])
                 {
                     discCausedToGameOver=(ColorDisc *)node;
                     [node removeAllActions];
 
                     [self loadGameOver];

                   NSLog(@"WRONG Disc tapped");
                 }else if ([node.name isEqualToString:@"SPECIAL_BONUS"])
                 {
                     [node removeAllActions];
                     SKAction *scaledownAndMove=[SKAction sequence:@[[SKAction scaleTo:0.3 duration:0.5],[SKAction moveTo:rainbowLbl.position duration:1]]];
                     [node runAction:scaledownAndMove];
                     if(self.DiscSpeed<=MAX_SPEED){
                     self.DiscSpeed+=2;
                     }
                     self.rainbowCount+=POINT_BONUS;
                     [self setRainbow];
                    
                     
//                     SKEmitterNode *emmiter=[SKEmitterNode nodeWithFileNamed:@"BonusCollected"];
//                     [node addChild:emmiter];
                     //[node removeFromParent];
                 }
                 
             }
 
        }];
                
 
                
        
    }
}

-(void)loadGameOver
{
    _mainLayer.alpha=0.6;
    self.paused=YES;
    
    gameOverBox.hidden=NO;
}

-(void)continueGameWithRainBow
{
    //check rainbow is available or not
    if(self.rainbowCount>=PLAY_COST)
    {
        self.rainbowCount-=PLAY_COST;
        [self setRainbow];
        
        self.DiscSpeed=1;
        
        SKAction *fall=[SKAction fadeAlphaTo:0 duration:1.2];
        
        SKAction *remove=[SKAction runBlock:^{
            [discCausedToGameOver removeFromParent];
        }];
        
        [discCausedToGameOver runAction:[SKAction sequence:@[fall,remove]]];
        _mainLayer.alpha=1;
        self.paused=NO;
        
        gameOverBox.hidden=YES;
    }else{
        //pop up for rainbow purchasing
        //redirect to store page
    }

}


-(void)reTryGame
{
    [_mainLayer removeAllChildren];
    self.ScoreCount=0;
    self.DiscSpeed=1;
    [self setScore];
    
    _mainLayer.alpha=1;
    self.paused=NO;
    
    gameOverBox.hidden=YES;
}

-(void)setRainbow
{
   rainbowLbl.text = [NSString stringWithFormat:@"RAINBOW:%d",self.rainbowCount];
}

-(void)setScore
{
   scoreLbl.text = [NSString stringWithFormat:@"SCORE:%d",self.ScoreCount];
}

@end
