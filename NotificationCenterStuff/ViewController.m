//
//  ViewController.m
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/29/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NOTE: the removeObserver: method DOES NOT remove blocks.
    /*[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"application about to resign active");
    }]; */
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"keyboard shown");
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"keyboard hidden");
    }];
}

- (IBAction)buttonPressed:(id)sender
{
    // post a notification that our object was listening for
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification"
    //                                                    object:self];
    // alternative way to use this
    /*
    NSMutableDictionary *myMetadata = [[NSMutableDictionary alloc] init];
    [myMetadata setObject:@"some data" forKey:@"some key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self userInfo:myMetadata];
     */
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
