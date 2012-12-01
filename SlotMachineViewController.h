//
//  SlotMachineViewController.h
//  SlotMachine
//
//  Created by Ashoraya Mezdo on 9/18/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlotMachineViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UIPickerView *slotMachinePickerView;
@property (nonatomic, strong) IBOutlet UILabel *totalMoney;
@property (nonatomic, strong) IBOutlet UILabel *moneyEarnedFromSpin;
@property (nonatomic, strong) NSMutableArray *slotMachineImages;

-(IBAction)spinButtonPressed;
-(void)startTimer;
-(void)spinSlotMachine:(NSInteger)spinResult;
-(void)awardMoney;
-(void)centerPickerView;
-(void)startSlotMachineTimer;
-(void)timerFired:(id)theTimer;

@end
