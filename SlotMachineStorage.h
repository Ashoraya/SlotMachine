//
//  SlotMachineStorage.h
//  SlotMachine
//
//  Created by amezdo1 on 11/21/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlotMachineStorage : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictionary;

-(id)init;
-(NSInteger)createNewUser:(NSString*)userName withPassword: (NSString*)password;
-(NSInteger)checkUserCredentials:(NSString*)userName withPassword:(NSString*)password;
-(NSInteger)saveUserMoney:(NSInteger)money;

@end
