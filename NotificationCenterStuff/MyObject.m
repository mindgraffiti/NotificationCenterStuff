//
//  MyObject.m
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/29/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "MyObject.h"
@implementation MyObject

- (id)init{
    self = [super init];
    if (self) {
        // NSNotificationCenter constructor
        NSNotificationCenter *ncenter = [NSNotificationCenter defaultCenter];
        // create a listener for a message notification. name: is the name of the notification we want to listen for.
        // object: targets a specific object you want to listen for. nil means you don't care what object
        [ncenter addObserver:self selector:@selector(myNotificationHandler:) name:@"MyNotification" object:nil];
         
        /* [ncenter addObserverForName:@"MyNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSLog(@"MyObject received a notification - block example");
        }]; */
    }
    return self;
}

// this will take one param only, and it will always be an NSNotificationCenter obj.
-(void)myNotificationHandler:(NSNotificationCenter *)note{
    NSLog(@"My object received a notification - handler example");
    
    // alternative example
    /*
    NSDictionary *data = [note userInfo];
    NSLog(@"MyObejct received a notification with data: %@", data);
     */
}

@end
