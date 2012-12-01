//
//  SpinController.m
//  SlotMachine
//
//  Created by Ashoraya Mezdo on 9/27/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import "SpinController.h"
#import "SlotMachineViewController.h"

@implementation SpinController

//Returns the result from each spin, which is based on a predefined probability.
//The returned number corresponds to the index of the image. For example, if the
//player matches 3 grapes, then the number 4 is returned. Returns 9 if there is no match.
+(NSInteger)spinResult
{    
    //Generate a random number between 0 - 99
    NSInteger spinResult = arc4random() % 100;
    
    //1% chance to match 3 sevens
    if(spinResult < 1)
    {
        return 7;
    }
    
    //2% chance to match 3 bars
    else if((spinResult >= 1) && (spinResult <= 2))
    {
        return 1;
    }
    
    //3% chance to match 3 bells
    else if((spinResult >= 3) && (spinResult <= 5))
    {
        return 2;
    }
    
    //4% chance to match 3 cherries
    else if((spinResult >= 6) && (spinResult <= 9))
    {
        return 3;
    }
    
    //5% chance to match 3 grapes
    else if((spinResult >= 10) && (spinResult <= 14))
    {
        return 4;
    }
    
    //6% chance to match 3 lemons
    else if((spinResult >= 15) && (spinResult <= 20))
    {
        return 5;
    }
    
    //7% chance to match 3 oranges
    else if((spinResult >= 21) && (spinResult <= 27))
    {
        return 6;
    }
    
    //8% chance to match 3 watermelon
    else if((spinResult >= 28) && (spinResult <= 35))
    {
        return 8;
    }
    
    //9% chance to match 3 apples
    else if((spinResult >= 36) && spinResult <= 44)
    {
        return 0;
    }
    
    //55% chance to match nothing
    else
    {
        return 9;
    }
}

@end
