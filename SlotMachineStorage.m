//
//  SlotMachineStorage.m
//  SlotMachine
//
//  Created by amezdo1 on 11/21/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import "SlotMachineStorage.h"

@implementation SlotMachineStorage

@synthesize dictionary = _dictionary;

-(id)init
{
    self = [super init];
    if(self) {
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"plist"];
        NSString *path = @"/Users/ASUuser/Documents/SlotMachine/dictionary.plist";
        _dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        if(_dictionary == nil) {
            NSLog(@"Error loading dictionary.");
        }
    }
    return self;
}

//Creates a new user and saves it to a dictionary file.
//Returns Codes:
//0 = Successfully created a new user
//-1 = User already exists
//-2 = Unable to write to file
-(NSInteger)createNewUser:(NSString*)userName withPassword:(NSString*)password
{
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"plist"];
    NSString *path = @"/Users/ASUuser/Documents/SlotMachine/dictionary.plist";
    NSString *key = [userName stringByAppendingString:@"-password"];
    if([_dictionary objectForKey:key]) {
        return -1; //user already exists
    }
    else {
        [_dictionary setValue:password forKey:key];
        BOOL writeResult = [_dictionary writeToFile:path atomically:YES];
        if(writeResult == NO){
            return -2; //unable to write to file
        }
        else {
            return 0; //successfully created a new user
        }
    }
}

//Checks to see if the credentials provided by the user match the credentials in the dictionary
//Returns Codes:
//0 = Credentials match
//-1 = Username does not exist
//-2 = Password does not match dictionary password
-(NSInteger)checkUserCredentials:(NSString*)userName withPassword:(NSString*)password
{
    NSString *key = [userName stringByAppendingString:@"-password"];
    NSString *dictionaryReturnResult = [_dictionary valueForKey:key];
    if(dictionaryReturnResult == nil) {
        return -1; //username does not exist
    }
    else if(!([password isEqualToString:dictionaryReturnResult])) {
        return -2; //password does not match dictionary password
    }
    else {
        return 0; //credentials match
    }
}

-(NSInteger)saveUserMoney:(NSInteger)money
{
    return 0;
}
                      

@end
