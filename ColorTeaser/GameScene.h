//
//  GameScene.h
//  ColorTeaser
//

//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) int discTapped;

@property (nonatomic) int ScoreCount;
@property (nonatomic) int rainbowCount;

@property (nonatomic) float DiscSpeed;
@end
