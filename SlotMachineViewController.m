//
//  SlotMachineViewController.m
//  SlotMachine
//
//  Created by Ashoraya Mezdo on 9/18/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import "SlotMachineViewController.h"
#import "SpinController.h"

int totalMoney = 500;
int spinButtonLimiter = 1;
int timerCounter = 20;

@interface SlotMachineViewController ()

@end


@implementation SlotMachineViewController

@synthesize slotMachinePickerView = _slotMachinePickerView;
@synthesize totalMoney = _totalMoney;
@synthesize moneyEarnedFromSpin = _moneyEarnedFromSpin;
@synthesize slotMachineImages = _slotMachineImages;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Stop the user from being able to scroll the picker view with the mouse
    [_slotMachinePickerView setUserInteractionEnabled:NO];
	
    //initialize the array which contains the slot machine images
    _slotMachineImages = [[NSMutableArray alloc] init];
    _slotMachineImages  = [NSMutableArray arrayWithObjects:
                                    [UIImage imageNamed:@"apple.png"],      //index 0
                                    [UIImage imageNamed:@"bar.png"],        //index 1
                                    [UIImage imageNamed:@"bell.png"],       //index 2
                                    [UIImage imageNamed:@"cherry.png"],     //index 3
                                    [UIImage imageNamed:@"grape.png"],      //index 4
                                    [UIImage imageNamed:@"lemon.png"],      //index 5
                                    [UIImage imageNamed:@"orange.png"],     //index 6
                                    [UIImage imageNamed:@"seven.png"],      //index 7
                                    [UIImage imageNamed:@"watermelon.png"], //index 8
                                    nil];
    
    //set the initial amount of money that the player has
    _totalMoney.text = [NSString stringWithFormat:@"$%d", totalMoney];
    
    //Have the slot machine start at the sevens
    for(int i = 0; i < 3; i++)
    {
        [_slotMachinePickerView selectRow:7 inComponent:i animated:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 16000;
}

-(UIImageView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIImageView *)view
{
    return [[UIImageView alloc] initWithImage:[_slotMachineImages objectAtIndex:row%9]];
}

//Whenever the slot machine is spinned, the row is set to somewhere in the center.
//This ensures that the end of the array is never reached.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self centerPickerView:component];
}


//Whenever the slot machine is spinned, the row is set to somewhere in the center.
//This ensures that the end of the array is never reached.
-(void)centerPickerView:(NSInteger)component
{
    NSInteger max = 16000;
    NSInteger base9 = (max/2) - (max/2) % 9;
    [_slotMachinePickerView selectRow:[_slotMachinePickerView selectedRowInComponent:component]%9+base9 inComponent:component animated:NO];
}

//Contains the logic which controls the spinning of the slot machine wheels
- (IBAction)spinButtonPressed
{
    if(spinButtonLimiter == 1)
    {
        //Prevent the spin button from being pressed while the slot machine is spinning
        spinButtonLimiter = 0;
        
        //Deduct $20 for spinning
        totalMoney -= 20;
        _totalMoney.text = [NSString stringWithFormat:@"$%d", totalMoney];
        
        //Start the slot machine timer which controls how the slot machine spins
        [self startSlotMachineTimer];
    }
}

//Initializes the slot machine timer which controls how many fake spins the slot machine performs before landing
//on the desired result
-(void)startSlotMachineTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(timerFired:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)timerFired:(id)theTimer {
    int currentIndex[3];
    int desiredIndex[3];
    
    //The timer will perform 19 fake spins to mimic a slot machine that spins for a second before stopping
    if(timerCounter > 1)
    {
        timerCounter--;
        for(NSInteger i = 0; i < 3; i++)
        {
            currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
            desiredIndex[i] = currentIndex[i] + (arc4random() % 9) + 9;
            [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
        }
    }
    
    //After 19 fake spins, the slot machine will perform the spin which determines where the slots will land
    if(timerCounter == 1)
    {
        //Reset the timer counter
        timerCounter = 20;
        
        //Spin the slot machine for the actual result
        [self spinSlotMachine: [SpinController spinResult]];
        
        //Give the player money if they match 3 slots
        [self awardMoney];
        
        //Disable the timer
        NSTimer *timer = (NSTimer*)theTimer;
        [timer invalidate];
        
        //Reenable the spin button
        spinButtonLimiter = 1;
    }
}

//Sets the slot machine rows to whatever was returned by the spinResult function
-(void)spinSlotMachine:(NSInteger)spinResult
{
    int currentIndex[3];
    int desiredIndex[3];
    NSInteger noMatchRow[3];
    switch (spinResult)
    {
        case 0:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (0 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            
            break;
            
        case 1:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (1 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 2:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (2 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 3:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (3 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 4:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (4 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 5:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (5 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 6:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (6 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 7:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (7 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 8:
            for(NSInteger i = 0; i < 3; i++)
            {
                currentIndex[i] = [_slotMachinePickerView selectedRowInComponent:i];
                desiredIndex[i] = currentIndex[i] + (8 - currentIndex[i]%9) + 9;
                [_slotMachinePickerView selectRow:desiredIndex[i] inComponent:i animated:YES];
            }
            break;
            
        case 9:
            do {
                noMatchRow[0] = arc4random() % 9;
                noMatchRow[1] = arc4random() % 9;
                noMatchRow[2] = arc4random() % 9;
            } while ((noMatchRow[0] == 0) || (noMatchRow[1] == 0) || (noMatchRow[2] == 0) || (noMatchRow[0] == noMatchRow[1]) || (noMatchRow[0] == noMatchRow[2]));
            
            for(NSInteger i = 0; i < 3; i++)
            {
                [_slotMachinePickerView selectRow:([_slotMachinePickerView selectedRowInComponent:i] + noMatchRow[i]) inComponent:i animated:YES];
            }
            break;
    }
}

//Awards money to the player if they match 3 slots
-(void)awardMoney
{
    NSInteger slot1, slot2, slot3, moneyFromSpin;
    slot1 = [_slotMachinePickerView selectedRowInComponent:0] % 9;
    slot2 = [_slotMachinePickerView selectedRowInComponent:1] % 9;
    slot3 = [_slotMachinePickerView selectedRowInComponent:2] % 9;
    
    //3 apples
    if((slot1 == 0) && (slot2 == 0) && (slot3 == 0))
    {
        moneyFromSpin = 50;
        totalMoney += 50;
    }
    
    //3 bars
    else if((slot1 == 1) && (slot2 == 1) && (slot3 == 1))
    {
        moneyFromSpin = 500;
        totalMoney += 500;
    }
    
    //3 bells
    else if((slot1 == 2) && (slot2 == 2) && (slot3 == 2))
    {
        moneyFromSpin = 400;
        totalMoney += 400;
    }
    
    //3 cherries
    else if((slot1 == 3) && (slot2 == 3) && (slot3 == 3))
    {
        moneyFromSpin = 300;
        totalMoney += 300;
    }
    
    //3 grapes
    else if((slot1 == 4) && (slot2 == 4) && (slot3 == 4))
    {
        moneyFromSpin = 200;
        totalMoney += 200;
    }
    
    //3 lemons
    else if((slot1 == 5) && (slot2 == 5) && (slot3 == 5))
    {
        moneyFromSpin = 150;
        totalMoney += 150;
    }
    
    //3 oranges
    else if((slot1 == 6) && (slot2 == 6) && (slot3 == 6))
    {
        moneyFromSpin = 100;
        totalMoney += 100;
    }
    
    //3 sevens
    else if((slot1 == 7) && (slot2 == 7) && (slot3 == 7))
    {
        moneyFromSpin = 1000;
        totalMoney += 1000;
    }
    
    //3 watermelons
    else if((slot1 == 8) && (slot2 == 8) && (slot3 == 8))
    {
        moneyFromSpin = 75;
        totalMoney += 75;
    }
    
    //no match
    else
    {
        moneyFromSpin = 0;
    }
    
    //If the player's total money drops to $0, give them $500 to continue playing
    if(totalMoney <= 0)
    {
        totalMoney = 500;
    }
    
    //update the label which displays the money won from the last spin
    _moneyEarnedFromSpin.text = [NSString stringWithFormat:@"$%d", moneyFromSpin];
    
    //update the label which displays the total money won
    _totalMoney.text = [NSString stringWithFormat:@"$%d", totalMoney];
}

@end
