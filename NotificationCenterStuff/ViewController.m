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


- (void)viewDidLoad // "Loaded, not presented!"
{
    [super viewDidLoad];
    
    // NOTE: the removeObserver: method DOES NOT remove blocks.
    /*[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"application about to resign active");
    }]; */
    
    // this is the listener for the event where we see the keyboard
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"keyboard shown");
        // Now we want to scroll the view. So why doesn't this work?
        // self.myScrollView.frame.size.height = 10;
        // because the frame property is read-only!
        
        // so instead, let's assign a new frame.
        CGRect frame = self.myScrollView.frame;
        // and manipulate the frame
        frame.size.height = frame.size.height / 2;
        self.myScrollView.frame = frame;
    }];
    
    // this is the listener for the event where we hid the keyboard
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        //[self.view endEditing:YES];
        NSLog(@"keyboard hidden");
    }];
    
    
}

- (IBAction)buttonPressed:(id)sender
{
    // post a notification that our object was listening for
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self];
    // alternative way to use this
    /*
    NSMutableDictionary *myMetadata = [[NSMutableDictionary alloc] init];
    [myMetadata setObject:@"some data" forKey:@"some key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self userInfo:myMetadata];
     */
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // if you are limiting the size of your scrollView, do this:
    // 1. measure the size of the scrollView
     CGSize size = self.myScrollView.frame.size;
    // 2. set the content size based on the scrollView's frame
    self.myScrollView.contentSize = size;
    
    // 3. a cleaner way to say this is:
    // self.myScrollView.contentSize = self.myScrollView.frame.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
