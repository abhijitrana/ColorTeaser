//
//  ColorDisc.h
//  ColorTeaser
//
//  Created by ABHIJIT RANA on 07/06/15.
//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ColorDisc : SKShapeNode

@property (nonatomic) BOOL isWrongDisc;
@property (nonatomic) BOOL isSpecialBonusDisc;
@property (nonatomic) NSString *colorText;
@property (nonatomic) UIColor  *discColor;


-(void)setUpColorDisc:(UIColor *)color withText:(NSString *)text;

@end
