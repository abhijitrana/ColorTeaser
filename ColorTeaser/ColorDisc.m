//
//  ColorDisc.m
//  ColorTeaser
//
//  Created by ABHIJIT RANA on 07/06/15.
//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import "ColorDisc.h"
NSArray *allColors;
@implementation ColorDisc

 -(instancetype)init
{
    if(self=[super init])
    {
        allColors=[[NSArray alloc] initWithObjects:@"Red",
                   @"Green",
                   @"Blue",
                   @"Yellow",
                   @"Purple",
                   @"Orange", nil];
    }
    return self;
}

-(void)setUpColorDisc:(UIColor *)color withText:(NSString *)text
{
    self.discColor=color;
    self.fillColor=color;

    SKLabelNode *colorText=[SKLabelNode node];
    
    if(self.isWrongDisc==YES)
    {
        NSMutableArray *specificColorArr=[NSMutableArray arrayWithArray:allColors];
        [specificColorArr removeObject:text];
        
       colorText.text=[specificColorArr objectAtIndex:(arc4random()%specificColorArr.count)];
        self.colorText=colorText.text;
    }else{
       colorText.text=text;
        self.colorText=colorText.text;
    }

    colorText.fontColor=[UIColor whiteColor];
    colorText.fontName=@"Chalkduster";
    colorText.fontSize=16;
    if(color==[UIColor greenColor]||(color==[UIColor yellowColor]))
    {
     colorText.fontColor=[UIColor blueColor];
    }
    
    SKAction *scaleUp=[SKAction scaleTo:1.3 duration:0.5];
    SKAction *scaleDown=[SKAction scaleTo:1.0 duration:0.5];
    
    SKAction *anim=[SKAction sequence:@[scaleUp,scaleDown]];
    [colorText runAction:[SKAction repeatAction:anim count:10]];
    
 
    [self addChild:colorText];
    
    

    /*
    if(color==[UIColor redColor])
    {
        SKEmitterNode *redSmoke=[SKEmitterNode nodeWithFileNamed:@"redSmoke"];
        [self addChild:redSmoke];
    }else if (color==[UIColor blueColor])
    {
        SKEmitterNode *blueSmoke=[SKEmitterNode nodeWithFileNamed:@"blueSmoke"];
        [self addChild:blueSmoke];
    }else if(color==[UIColor greenColor])
    {
        SKEmitterNode *greenSmoke=[SKEmitterNode nodeWithFileNamed:@"greenSmoke"];
        [self addChild:greenSmoke];
    }
   */
    
}

@end
