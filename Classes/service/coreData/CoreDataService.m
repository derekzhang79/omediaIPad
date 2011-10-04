//
//  CoreDataService.m
//  omedia
//
//  Created by xu hongfeng on 11-10-4.
//  Copyright 2011 THU. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CoreDataService.h"
#import "Account.h"
#import "omediaAppDelegate.h"

@implementation CoreDataService

-(id) initWithOwnerController:(BaseController *)controller {
	self = [super initWithOwnerController:controller];
	if(self) {
		context = [self omediatAppDelegate].managedObjectContext;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(Account*) getAccountWithId:(NSNumber *)accountId {
	NSFetchRequest* request = [[NSFetchRequest alloc]init];
	NSEntityDescription* entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"accountId",accountId];
	[request setEntity:entity];
	[request setPredicate:predicate];
	NSError *error = nil;
	NSArray *results = [context executeFetchRequest:request error:&error];
	[request release];
	if (results == nil) {
		//TODO  exception
		return nil;
	}
	if ([results count] == 0) {
		return nil;
	} else {
		return [results objectAtIndex:0];
	}
}

-(Account*) createAccountWithId:(NSNumber *)accountId withUserName:(NSString *)username withToken:(NSNumber *)token {
	Account* account = (Account*)[NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
	account.username = username;
	account.token = token;
	account.accountId = accountId;
	return account;
}

-(void) saveContext {
	NSError* error = nil;
	if (![context save:&error]) {
		//TODO exception
	}
}

@end
